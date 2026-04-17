#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
🧪 Correcteur Interactif de TESTS CertifApp - VERSION SANS DÉPENDANCES
Backend: LM Studio / Ollama via HTTP | Git branches | Boucle interactive
Python stdlib uniquement : urllib, json, subprocess, pathlib, dataclasses
Cible: MacBook Pro M3 18Go RAM | Focus: JUnit 5, AssertJ, Mockito, Testcontainers, Jasmine
"""

import os, sys, json, subprocess, time, re, difflib, ssl, urllib.request, urllib.error
from pathlib import Path
from datetime import datetime
from typing import Dict, List, Optional, Tuple
from dataclasses import dataclass, field
from enum import Enum, auto

# ============================================================================
# CONFIGURATION
# ============================================================================
PROJECT_ROOT = Path.cwd()
REPORTS_DIR = PROJECT_ROOT / "reports" / "corrections_tests"
BACKUP_DIR = PROJECT_ROOT / "backups_tests"

TEST_MODULES: Dict[str, Dict] = {
    "1": {"name": "certif-domain-tests", "path": "certif-domain/src/test/java", "ext": [".java"],
          "desc": "Tests unitaires domaine (JUnit 5 + AssertJ, zéro Spring)",
          "rules": "- Tests purs JUnit 5 + AssertJ, aucun contexte Spring\n- Nommage: methodName_stateUnderTest_expectedBehavior\n- Structure AAA obligatoire\n- Pas de mocks inutiles (domaine pur)\n- Vérifier Exceptions métier et cas limites"},
    "2": {"name": "certif-application-tests", "path": "certif-application/src/test/java", "ext": [".java"],
          "desc": "Tests use cases (Mockito ports output)",
          "rules": "- JUnit 5 + Mockito (@Mock, @InjectMocks)\n- Ports output mockés strictement\n- AAA obligatoire\n- PAS de @SpringBootTest\n- Vérifier délégation vers services domain"},
    "3": {"name": "certif-infrastructure-tests", "path": "certif-infrastructure/src/test/java", "ext": [".java"],
          "desc": "Tests intégration (Testcontainers, JPA)",
          "rules": "- @Testcontainers + PostgreSQLContainer\n- @DataJpaTest pour repositories\n- @SpringBootTest uniquement pour adapters complets\n- Nettoyage BDD entre tests (@Transactional/@DirtiesContext)\n- Flyway migrations actives en test"},
    "4": {"name": "certif-api-rest-tests", "path": "certif-api-rest/src/test/java", "ext": [".java"],
          "desc": "Tests controllers & sécurité (MockMvc/WebMvcTest)",
          "rules": "- @WebMvcTest + MockMvc\n- Use cases mockés\n- Vérifier @Valid, HTTP status, headers JWT\n- Assertions JSON avec JsonPath/AssertJ\n- Pas de logique métier dans les tests"},
    "5": {"name": "certif-ai-tests", "path": "certif-ai/src/test/java", "ext": [".java"],
          "desc": "Tests services IA (LangChain4j mocks)",
          "rules": "- Mock ChatLanguageModel/EmbeddingModel\n- Tests unitaires des templates .mustache\n- Vérifier ModelRouter fallback (local ↔ prod)\n- Human-in-the-loop: ExplanationStatus\n- Zéro appel réseau réel"},
    "6": {"name": "certif-web-tests", "path": "certif-web/src/app", "ext": [".spec.ts", ".ts"],
          "desc": "Tests Angular (Jasmine/Karma)",
          "rules": "- TestBed.configureTestingModule\n- Components standalone\n- Services mockés (useValue)\n- async/await + fakeAsync/tick\n- Vérifier signals, outputs, events DOM"},
    "7": {"name": "certif-android-tests", "path": "certif-android/app/src/test", "ext": [".kt"],
          "desc": "Tests Android/Kotlin (JUnit + MockK)",
          "rules": "- JUnit 5 + MockK (mockk, verify, every)\n- Coroutines test: runTest, StandardTestDispatcher\n- ViewModel tests isolés\n- Architecture MVVM stricte\n- Pas d'Android framework sauf Robolectric si nécessaire"}
}

TEST_SYSTEM_PROMPT = (
    "Tu es un expert QA/Dev Java & Angular pour CertifApp. Ta mission: CORRIGER LES TESTS SANS TOUCHER AU CODE DE PRODUCTION.\n"
    "RÈGLES STRICTES:\n"
    "1. NOMMAGE: methodName_stateUnderTest_expectedBehavior (ex: calculateScore_withEmptyAnswers_returnsZero)\n"
    "2. STRUCTURE AAA: Arrange / Act / Assert obligatoire dans chaque @Test\n"
    "3. ASSERTIONS: AssertJ (Java) ou Jasmine expect() (Angular) uniquement\n"
    "4. MOCKS: Mockito (@Mock, @InjectMocks, lenient().when()) ou MockK (Kotlin)\n"
    "5. SPRING: @DataJpaTest, @WebMvcTest, @SpringBootTest selon le module. JAMAIS @SpringBootTest dans domain/app\n"
    "6. TESTCONTAINERS: @Testcontainers + PostgreSQLContainer pour infrastructure\n"
    "7. ANGULAR: TestBed, async/await, mock services, verification signals/outputs\n"
    "8. COUVERTURE: >80% obligatoire. Tester les cas limites (null, vide, exceptions métier)\n"
    "9. JAVA 21: Utiliser var, Records pour fixtures, Pattern Matching si applicable\n"
    "FORMAT: Retourne UNIQUEMENT le code corrigé, ou 'NO_CHANGES'. Conserve les imports existants, ajoute ceux manquants. Ne modifie JAMAIS la logique métier du code sous-test."
)

# ============================================================================
# TYPES
# ============================================================================
class Backend(Enum):
    LM_STUDIO = "lm_studio"
    OLLAMA = "ollama"

@dataclass
class CorrectionResult:
    file_path: str; original: str; corrected: str; changed: bool
    diff: str = ""; model: str = ""; time_sec: float = 0.0; notes: List[str] = field(default_factory=list)
    def __post_init__(self):
        if self.changed and not self.diff:
            self.diff = "\n".join(difflib.unified_diff(
                self.original.splitlines(keepends=True), self.corrected.splitlines(keepends=True),
                fromfile="a/" + self.file_path, tofile="b/" + self.file_path, lineterm=""
            ))

@dataclass
class SessionReport:
    backend: str; model: str; module: str; branch: str; dry_run: bool
    files: int; corrections: int; results: List[CorrectionResult] = field(default_factory=list)
    start: str = ""; end: str = ""; errors: List[str] = field(default_factory=list)
    def finalize(self): self.end = datetime.now().isoformat()
    def duration(self) -> str:
        if not self.end: return "..."
        s = int((datetime.fromisoformat(self.end) - datetime.fromisoformat(self.start)).total_seconds())
        return str(s) + "s"

# ============================================================================
# UI UTILS
# ============================================================================
def clear(): os.system("cls" if os.name == "nt" else "clear")
def hdr(t, c="="): print("\n" + c*60 + "\n  " + t + "\n" + c*60)
def ok(t): print("✅ " + t)
def err(t): print("❌ " + t)
def info(t): print("ℹ️  " + t)
def warn(t): print("⚠️  " + t)

def ask_yes(prompt, default=True):
    d = "O/n" if default else "o/N"
    while True:
        r = input(prompt + " (" + d + "): ").strip().lower()
        if not r: return default
        if r in ("o", "oui", "y", "yes"): return True
        if r in ("n", "non", "no"): return False
        err("Oui ou non.")

def ask_choice(opts, prompt):
    print("\n" + prompt)
    for k, v in opts.items(): print("  " + k + ". " + v)
    while True:
        c = input("Choix: ").strip()
        if c in opts: return c
        err("Invalide.")

# ============================================================================
# SHELL & GIT
# ============================================================================
def run_cmd(cmd):
    try:
        r = subprocess.run(cmd, capture_output=True, text=True, cwd=PROJECT_ROOT, timeout=30)
        return r.returncode == 0, (r.stdout.strip() if r.returncode == 0 else r.stderr.strip())
    except Exception as e: return False, str(e)

def get_base_branch():
    ok, branch = run_cmd(["git", "rev-parse", "--abbrev-ref", "HEAD"])
    return branch.strip() if ok else "main"

def create_fix_branch(module, model, backend):
    ts = datetime.now().strftime("%Y%m%d-%H%M")
    branch = "fix-tests/" + module + "-" + model.replace(":", "-")[:20] + "-" + ts
    ok, msg = run_cmd(["git", "status", "--porcelain"])
    if ok and msg.strip(): return False, "⚠️ Changements non commités. Stash/commit avant."
    return run_cmd(["git", "checkout", "-b", branch])

def commit_changes(msg):
    run_cmd(["git", "add", "-A"])
    return run_cmd(["git", "commit", "-m", msg])

def switch_branch(branch):
    return run_cmd(["git", "checkout", branch])

# ============================================================================
# HTTP UTILS (stdlib uniquement)
# ============================================================================
def _http_post_json(url, data, timeout=300):
    try:
        payload = json.dumps(data).encode("utf-8")
        ctx = ssl.create_default_context(); ctx.check_hostname = False; ctx.verify_mode = ssl.CERT_NONE
        req = urllib.request.Request(url, data=payload, headers={"Content-Type": "application/json"}, method="POST")
        with urllib.request.urlopen(req, timeout=timeout, context=ctx) as resp:
            return json.loads(resp.read().decode("utf-8"))
    except urllib.error.HTTPError as e:
        err("HTTP " + str(e.code) + ": " + e.read().decode("utf-8", errors="ignore")[:200])
        return None
    except Exception as e:
        err("Erreur: " + str(e))
        return None

def _http_get_json(url, timeout=5):
    try:
        ctx = ssl.create_default_context(); ctx.check_hostname = False; ctx.verify_mode = ssl.CERT_NONE
        with urllib.request.urlopen(url, timeout=timeout, context=ctx) as resp:
            return json.loads(resp.read().decode("utf-8"))
    except Exception:
        return None

# ============================================================================
# DÉTECTION & BACKENDS
# ============================================================================
def check_backend_status():
    status = {"lm_studio": False, "ollama": False}
    try:
        r = _http_get_json("http://localhost:1234/v1/models", timeout=3)
        if r and "data" in r: status["lm_studio"] = True
    except Exception: pass
    try: status["ollama"] = run_cmd(["ollama", "list"])[0]
    except Exception: pass
    return status

def select_backend():
    hdr("🔧 Sélection du Backend")
    s = check_backend_status()
    print("\nÉtat détecté :")
    print("  1. LM Studio (localhost:1234) " + ("✅ Disponible" if s["lm_studio"] else "❌ Serveur non lancé"))
    print("  2. Ollama                     " + ("✅ Disponible" if s["ollama"] else "❌ CLI non trouvée"))
    print("  3. Saisie manuelle / Forcer un backend")
    while True:
        c = input("\nChoix (1-3): ").strip()
        if c == "1": return Backend.LM_STUDIO
        if c == "2": return Backend.OLLAMA
        if c == "3":
            print("  a. lm_studio  |  b. ollama")
            m = input("Forcer: ").strip().lower()
            if m == "a": return Backend.LM_STUDIO
            if m == "b": return Backend.OLLAMA
        err("Invalide.")

def select_model(backend):
    hdr("🤖 Modèle (" + backend.value + ")")
    if backend == Backend.LM_STUDIO:
        info("💡 Sélectionnez le modèle dans l'interface LM Studio avant de continuer.")
        return input("Nom affiché dans LM Studio (ex: qwen2.5-coder-7b-instruct): ").strip() or "qwen2.5-coder-7b"
    return input("Modèle Ollama (ex: qwen2.5-coder:7b): ").strip() or "qwen2.5-coder:7b"

def query_lm_studio(model, prompt, system):
    data = {"model": model, "messages": [{"role": "system", "content": system}, {"role": "user", "content": prompt}], "temperature": 0.1, "max_tokens": 4096, "stream": False}
    resp = _http_post_json("http://localhost:1234/v1/chat/completions", data)
    if resp and "choices" in resp and len(resp["choices"]) > 0:
        return resp["choices"][0]["message"]["content"].strip()
    return None

def query_ollama(model, prompt, system):
    data = {"model": model, "prompt": prompt, "system": system, "stream": False, "options": {"temperature": 0.1, "num_predict": 4096}}
    resp = _http_post_json("http://localhost:11434/api/generate", data)
    if resp and "response" in resp: return resp["response"].strip()
    return None

def query_llm(backend, model, prompt, system):
    if backend == Backend.LM_STUDIO: return query_lm_studio(model, prompt, system)
    return query_ollama(model, prompt, system)

# ============================================================================
# SÉLECTION & TRAITEMENT
# ============================================================================
def select_module():
    hdr("📦 Module de tests à corriger")
    opts = {k: v["name"] + " - " + v["desc"] for k, v in TEST_MODULES.items()}
    c = ask_choice(opts, "Module?")
    return c, TEST_MODULES[c]

def find_files(key, exts):
    base = PROJECT_ROOT / TEST_MODULES[key]["path"]
    if not base.exists(): return []
    files = [f for f in base.rglob("*") if any(f.suffix == e for e in exts)]
    return sorted([f for f in files if not any(x in str(f) for x in ("target/", "build/", "node_modules/"))])

def select_files(files, mod_name):
    hdr("📄 Fichiers de tests - " + mod_name + " (" + str(len(files)) + " trouvés)")
    if not files: return []
    opts = {"1": "Tous", "2": "Regex", "3": "Manuelle"}
    c = ask_choice(opts, "Sélection?")
    if c == "1": return files
    if c == "2":
        pat = input("Regex nom: ").strip()
        try: return [f for f in files if re.search(pat, f.name, re.I)]
        except: err("Regex invalide"); return []
    for i, f in enumerate(files, 1): print("  " + str(i).rjust(3) + ". " + str(f.relative_to(PROJECT_ROOT)))
    idxs = input("Indices (ex: 1,3-5): ").strip()
    sel = []
    for p in idxs.split(","):
        if "-" in p:
            a, b = map(int, p.split("-")); sel.extend(files[a-1:b])
        elif p.isdigit():
            i = int(p)
            if 1 <= i <= len(files): sel.append(files[i-1])
    return list(set(sel))

def build_prompt(file, content, mod):
    ext = file.suffix.lstrip(".") or "java"
    return (
        "Module: " + mod["name"] + "\nFichier: " + file.name + "\n"
        "Règles spécifiques aux tests:\n" + mod["rules"] + "\n\nCode à corriger:\n```" + ext + "\n" + content + "\n```\n\n"
        "Retourne UNIQUEMENT le code corrigé, ou 'NO_CHANGES'."
    )

def parse_response(resp, original):
    if resp.strip() == "NO_CHANGES": return original, False, ["Aucune correction"]
    m = re.search(r"```\w*\n(.*?)```", resp, re.DOTALL)
    code = m.group(1).strip() if m else resp.strip()
    if code == original.strip(): return original, False, ["Identique"]
    if len(code) < 3 and not any(x in code for x in ("{", "import", "class", "@Test")):
        return original, False, ["⚠️ Réponse suspecte"]
    return code, True, ["Extrait du prompt"]

def process_file(file, mod, backend, model, dry):
    try: content = file.read_text(encoding="utf-8")
    except Exception as e: err("Lecture " + str(file) + ": " + str(e)); return None

    prompt = build_prompt(file, content, mod)
    info("🧪 " + file.name + "...")
    t0 = time.time()
    resp = query_llm(backend, model, prompt, TEST_SYSTEM_PROMPT)
    dt = time.time() - t0

    if not resp:
        return CorrectionResult(str(file.relative_to(PROJECT_ROOT)), content, content, False, model=model, time_sec=dt, notes=["Erreur LLM"])

    corr, changed, notes = parse_response(resp, content)
    notes.append("Temps: " + str(round(dt, 1)) + "s")

    if dry:
        warn("🧪 [DRY] " + ("Corrigé" if changed else "OK") + " " + file.name)
    elif changed:
        bk = BACKUP_DIR / file.relative_to(PROJECT_ROOT)
        bk.parent.mkdir(parents=True, exist_ok=True)
        bk.write_text(content, encoding="utf-8")
        file.write_text(corr, encoding="utf-8")
        ok("✏️ " + file.name)
    else:
        info("✅ " + file.name)

    return CorrectionResult(str(file.relative_to(PROJECT_ROOT)), content, corr, changed, model=model, time_sec=dt, notes=notes)

# ============================================================================
# RAPPORTS & MAIN
# ============================================================================
def save_report(rep):
    REPORTS_DIR.mkdir(parents=True, exist_ok=True)
    ts = datetime.now().strftime("%Y%m%d_%H%M%S")
    base = "test_report_" + rep.module + "_" + rep.model.replace(":", "_") + "_" + ts
    md = [
        "# 🧪 Rapport de Correction de TESTS",
        "**Backend**: " + rep.backend + " | **Modèle**: " + rep.model,
        "**Branche**: `" + rep.branch + "` | **Dry-run**: " + ("OUI" if rep.dry_run else "NON"),
        "**Fichiers**: " + str(rep.files) + " | **Corrections**: " + str(rep.corrections) + " | **Durée**: " + rep.duration(), ""
    ]
    for r in rep.results:
        if r.changed:
            md += ["### `" + r.file_path + "`", "```diff", r.diff[:1500], "```", ""]
    p = REPORTS_DIR / (base + ".md")
    p.write_text("\n".join(md), encoding="utf-8")
    ok("📊 Rapport: " + p.name)
    return p

def main():
    clear(); hdr("🚀 Correcteur de TESTS CertifApp - Boucle Interactive (stdlib)")
    backend = select_backend()
    model = select_model(backend)
    base_branch = get_base_branch()
    info("Branche de base: " + base_branch)

    while True:
        hdr("📦 Nouveau cycle de correction de tests")
        mod_key, mod = select_module()
        files = find_files(mod_key, mod["ext"])
        if not files: warn("Aucun fichier de test trouvé."); time.sleep(2); continue
        selected = select_files(files, mod["name"])
        if not selected: warn("Aucun fichier sélectionné."); time.sleep(2); continue

        dry = ask_yes("Mode DRY-RUN?", True)
        b_ok, b_msg = create_fix_branch(mod["name"], model, backend.value)
        current_branch = b_msg.strip() if b_ok else base_branch
        if not b_ok: warn("⚠️ Branche non créée: " + b_msg)
        else: info("🌿 Branche: " + current_branch)

        hdr("⚙️ Traitement")
        rep = SessionReport(backend.value, model, mod["name"], current_branch, dry, 0, 0)
        rep.start = datetime.now().isoformat()
        for i, f in enumerate(selected, 1):
            print("[" + str(i) + "/" + str(len(selected)) + "] " + f.name)
            res = process_file(f, mod, backend, model, dry)
            if res:
                rep.files += 1
                if res.changed: rep.corrections += 1
                rep.results.append(res)
        rep.finalize()

        hdr("📊 Résultats")
        print("✅ " + str(rep.files) + " traités | ✏️ " + str(rep.corrections) + " corrigés | ⏱️ " + rep.duration())
        if not dry and rep.corrections > 0:
            c_ok, c_msg = commit_changes("test(" + mod["name"] + "): corrections tests auto via " + model)
            if c_ok: ok("💾 Commité")
            else: warn("Commit échoué: " + c_msg)

        if ask_yes("Sauvegarder le rapport?", True): save_report(rep)
        if current_branch != base_branch:
            s_ok, _ = switch_branch(base_branch)
            if s_ok: info("🔄 Retour à " + base_branch)
        if ask_yes("Continuer avec un autre module de tests?", True): clear(); continue
        else: hdr("✨ Terminé"); break

if __name__ == "__main__":
    try: main()
    except KeyboardInterrupt: print("\n⚠️ Annulé"); sys.exit(130)
    except Exception as e: err("Fatal: " + str(e)); import traceback; traceback.print_exc(); sys.exit(1)