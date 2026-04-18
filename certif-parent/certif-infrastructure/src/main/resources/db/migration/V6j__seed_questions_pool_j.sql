-- =============================================================================
-- V6j__seed_questions_pool_j.sql
-- CertifApp — Import pool questions (589 questions, cka, kotlin certifications)
-- Idempotent : INSERT ... ON CONFLICT DO NOTHING
-- =============================================================================

-- ── CKA (300 questions) ──────
DO $$
DECLARE
    v_cert_id TEXT := 'cka';
    v_theme_id UUID; v_q_id UUID; v_opt_id UUID;
BEGIN
    IF NOT EXISTS (SELECT 1 FROM certifications WHERE id = v_cert_id) THEN
        RAISE NOTICE 'Certification % absente', v_cert_id; RETURN;
    END IF;
    INSERT INTO certification_themes (id, certification_id, code, label, question_count, display_order)
    VALUES (uuid_generate_v4(), v_cert_id, 'cluster_architecture', 'Cluster Architecture', 0, 0)
    ON CONFLICT (certification_id, code) DO NOTHING;
    INSERT INTO certification_themes (id, certification_id, code, label, question_count, display_order)
    VALUES (uuid_generate_v4(), v_cert_id, 'workloads___scheduling', 'Workloads & Scheduling', 0, 0)
    ON CONFLICT (certification_id, code) DO NOTHING;
    INSERT INTO certification_themes (id, certification_id, code, label, question_count, display_order)
    VALUES (uuid_generate_v4(), v_cert_id, 'services___networking', 'Services & Networking', 0, 0)
    ON CONFLICT (certification_id, code) DO NOTHING;
    INSERT INTO certification_themes (id, certification_id, code, label, question_count, display_order)
    VALUES (uuid_generate_v4(), v_cert_id, 'storage', 'Storage', 0, 0)
    ON CONFLICT (certification_id, code) DO NOTHING;
    INSERT INTO certification_themes (id, certification_id, code, label, question_count, display_order)
    VALUES (uuid_generate_v4(), v_cert_id, 'troubleshooting', 'Troubleshooting', 0, 0)
    ON CONFLICT (certification_id, code) DO NOTHING;
    INSERT INTO certification_themes (id, certification_id, code, label, question_count, display_order)
    VALUES (uuid_generate_v4(), v_cert_id, 'security', 'Security', 0, 0)
    ON CONFLICT (certification_id, code) DO NOTHING;
    INSERT INTO certification_themes (id, certification_id, code, label, question_count, display_order)
    VALUES (uuid_generate_v4(), v_cert_id, 'helm___operators', 'Helm & Operators', 0, 0)
    ON CONFLICT (certification_id, code) DO NOTHING;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-01-001') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='cluster_architecture' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-01-001',v_cert_id,v_theme_id,'Quels sont les composants du control plane Kubernetes ?','easy','SINGLE_CHOICE','Le control plane comprend l''API server, etcd, scheduler, controller manager.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','kube-apiserver, etcd, kube-scheduler, kube-controller-manager',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','kubelet, kube-proxy, container runtime',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','kube-apiserver, kubelet, kube-proxy',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','etcd, kubelet, kube-proxy',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-01-002') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='cluster_architecture' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-01-002',v_cert_id,v_theme_id,'Quel composant stocke l''état du cluster ?','easy','SINGLE_CHOICE','etcd est la base de données clé-valeur qui stocke l''état du cluster.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','etcd',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','kube-apiserver',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','kube-scheduler',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','kube-controller-manager',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-01-003') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='cluster_architecture' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-01-003',v_cert_id,v_theme_id,'Quel composant est responsable de la planification des pods ?','easy','SINGLE_CHOICE','Le scheduler assigne les pods aux nœuds.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','kube-scheduler',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','kube-apiserver',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','kube-controller-manager',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','kubelet',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-01-004') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='cluster_architecture' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-01-004',v_cert_id,v_theme_id,'Quel composant exécute les controllers (ex: deployment controller) ?','easy','SINGLE_CHOICE','Le controller manager exécute les boucles de contrôle.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','kube-controller-manager',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','kube-apiserver',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','kube-scheduler',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','kubelet',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-01-005') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='cluster_architecture' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-01-005',v_cert_id,v_theme_id,'Quel composant est le point d''entrée de toutes les opérations Kubernetes ?','easy','SINGLE_CHOICE','L''API server valide et traite toutes les requêtes.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','kube-apiserver',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','kube-scheduler',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','kube-controller-manager',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','etcd',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-01-006') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='cluster_architecture' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-01-006',v_cert_id,v_theme_id,'Quels sont les composants qui s''exécutent sur chaque nœud worker ?','easy','SINGLE_CHOICE','Les nœuds workers exécutent kubelet, kube-proxy et un container runtime.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','kubelet, kube-proxy, container runtime',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','kube-apiserver, kube-scheduler',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','etcd, kubelet',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','kube-controller-manager, kube-proxy',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-01-007') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='cluster_architecture' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-01-007',v_cert_id,v_theme_id,'Quel composant s''assure que les conteneurs tournent sur le nœud ?','easy','SINGLE_CHOICE','Le kubelet gère les pods et conteneurs sur le nœud.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','kubelet',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','kube-proxy',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','container runtime',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','kube-apiserver',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-01-008') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='cluster_architecture' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-01-008',v_cert_id,v_theme_id,'Quel composant gère les règles réseau (iptables) sur le nœud ?','easy','SINGLE_CHOICE','kube-proxy implémente le service proxy et les règles iptables.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','kube-proxy',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','kubelet',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','container runtime',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','cni plugin',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-01-009') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='cluster_architecture' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-01-009',v_cert_id,v_theme_id,'Quel add-on fournit la résolution DNS dans le cluster ?','easy','SINGLE_CHOICE','CoreDNS est l''add-on DNS standard depuis Kubernetes 1.13.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','CoreDNS',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','kube-dns',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','coredns',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A et B',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-01-010') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='cluster_architecture' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-01-010',v_cert_id,v_theme_id,'Quel add-on expose les métriques des nœuds et pods ?','easy','SINGLE_CHOICE','Metrics Server collecte les métriques de ressources pour HPA et kubectl top.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Metrics Server',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Heapster',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Prometheus',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','cAdvisor',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-01-011') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='cluster_architecture' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-01-011',v_cert_id,v_theme_id,'Quel add-on est nécessaire pour l''auto-scaling horizontal (HPA) ?','easy','SINGLE_CHOICE','HPA utilise les métriques de Metrics Server par défaut.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Metrics Server',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Heapster',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Prometheus',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Custom Metrics API',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-01-012') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='cluster_architecture' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-01-012',v_cert_id,v_theme_id,'Comment changer le contexte kubectl pour un cluster ?','easy','SINGLE_CHOICE','use-context bascule vers un contexte existant.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','kubectl config use-context <nom>',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','kubectl config set-context',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','kubectl config current-context',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','kubectl config get-contexts',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-01-013') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='cluster_architecture' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-01-013',v_cert_id,v_theme_id,'Comment lister tous les contextes ?','easy','SINGLE_CHOICE','get-contexts liste les contextes avec l''astérisque pour le courant.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','kubectl config get-contexts',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','kubectl config view',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','kubectl get contexts',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','kubectl config list-contexts',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-01-014') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='cluster_architecture' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-01-014',v_cert_id,v_theme_id,'Comment obtenir les logs d''un pod ?','easy','SINGLE_CHOICE','kubectl logs avec options -c, --tail, --since.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','kubectl logs <pod>',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','kubectl logs <pod> -c <container>',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','kubectl logs --tail=100 <pod>',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-01-015') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='cluster_architecture' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-01-015',v_cert_id,v_theme_id,'Comment exécuter une commande dans un pod ?','easy','SINGLE_CHOICE','kubectl exec permet d''exécuter des commandes dans un conteneur.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','kubectl exec <pod> -- <commande>',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','kubectl exec -it <pod> -- bash',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','kubectl exec <pod> -c <container> -- <commande>',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-01-016') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='cluster_architecture' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-01-016',v_cert_id,v_theme_id,'Comment copier un fichier depuis un pod ?','easy','SINGLE_CHOICE','kubectl cp fonctionne comme scp.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','kubectl cp <pod>:/chemin/fichier ./fichier',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','kubectl cp <pod>:<chemin> <chemin_local>',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','kubectl cp <namespace>/<pod>:<chemin> <local>',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-01-017') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='cluster_architecture' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-01-017',v_cert_id,v_theme_id,'Comment appliquer un fichier manifeste ?','easy','SINGLE_CHOICE','apply est déclaratif, create est impératif.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','kubectl apply -f fichier.yaml',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','kubectl create -f fichier.yaml',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','kubectl apply -f repertoire/',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-01-018') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='cluster_architecture' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-01-018',v_cert_id,v_theme_id,'Comment supprimer une ressource ?','easy','SINGLE_CHOICE','delete peut supprimer par nom, fichier, ou tout.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','kubectl delete <type> <nom>',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','kubectl delete -f fichier.yaml',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','kubectl delete <type> --all',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-01-019') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='cluster_architecture' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-01-019',v_cert_id,v_theme_id,'Comment décrire une ressource en détail ?','easy','SINGLE_CHOICE','describe donne l''état, -o yaml donne la définition complète.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','kubectl describe <type> <nom>',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','kubectl get <type> <nom> -o yaml',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','kubectl explain <type>',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A et B',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-01-020') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='cluster_architecture' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-01-020',v_cert_id,v_theme_id,'Comment obtenir les événements du cluster ?','easy','SINGLE_CHOICE','kubectl get events liste les événements.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','kubectl get events',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','kubectl get events --sort-by=''.lastTimestamp''',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','kubectl describe nodes',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A et B',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-01-021') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='cluster_architecture' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-01-021',v_cert_id,v_theme_id,'Quel port utilise l''API server par défaut ?','easy','SINGLE_CHOICE','L''API server écoute sur le port 6443 (HTTPS).','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','6443',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','8080',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','443',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','8443',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-01-022') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='cluster_architecture' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-01-022',v_cert_id,v_theme_id,'Comment accéder directement à l''API Kubernetes ?','easy','SINGLE_CHOICE','kubectl proxy ou direct avec certificats.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','kubectl proxy',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','curl https://<master>:6443 -k',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','kubectl get --raw /api/v1/namespaces',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-01-023') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='cluster_architecture' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-01-023',v_cert_id,v_theme_id,'Qu''est-ce que l''API aggregation layer ?','easy','SINGLE_CHOICE','L''aggregation layer permet d''ajouter des API via des apiservices.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Extension de l''API avec des ressources personnalisées',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Agrégation des logs',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Load balancing',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Monitoring',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-01-024') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='cluster_architecture' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-01-024',v_cert_id,v_theme_id,'Quel port etcd utilise-t-il par défaut ?','easy','SINGLE_CHOICE','2379 pour le client, 2380 pour le peer-to-peer.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','2379',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','2380',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','6443',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','10250',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-01-025') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='cluster_architecture' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-01-025',v_cert_id,v_theme_id,'Comment sauvegarder etcd ?','easy','SINGLE_CHOICE','etcdctl snapshot save sauvegarde l''état.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','ETCDCTL_API=3 etcdctl snapshot save snapshot.db',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','etcdctl backup',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','kubectl backup etcd',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A et B',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-01-026') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='cluster_architecture' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-01-026',v_cert_id,v_theme_id,'Comment restaurer une sauvegarde etcd ?','easy','SINGLE_CHOICE','snapshot restore restaure la sauvegarde.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','etcdctl snapshot restore snapshot.db',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','etcdctl restore',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','etcdctl snapshot load',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','etcdctl load',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-01-027') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='cluster_architecture' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-01-027',v_cert_id,v_theme_id,'Qu''est-ce qu''un scheduler policy ?','easy','SINGLE_CHOICE','La politique de scheduler définit comment les pods sont placés.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Règles de priorisation pour le placement des pods',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Stratégie de mise à l''échelle',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Politique de sécurité',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Règle réseau',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-01-028') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='cluster_architecture' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-01-028',v_cert_id,v_theme_id,'Comment forcer un pod à s''exécuter sur un nœud spécifique ?','easy','SINGLE_CHOICE','nodeSelector, nodeName, ou node affinity.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','nodeSelector',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','nodeName',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','affinity',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-01-029') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='cluster_architecture' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-01-029',v_cert_id,v_theme_id,'Quels sont les contrôleurs inclus dans kube-controller-manager ?','easy','SINGLE_CHOICE','Plusieurs contrôleurs tournent dans le controller manager.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Deployment controller, ReplicaSet controller, Node controller, etc.',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Seulement Deployment',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Seulement ReplicaSet',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Seulement Node',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-01-030') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='cluster_architecture' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-01-030',v_cert_id,v_theme_id,'Que fait le node controller ?','easy','SINGLE_CHOICE','Le node controller gère le cycle de vie des nœuds.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Surveille la santé des nœuds et réagit aux pannes',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Gère les pods',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Crée les services',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Gère les volumes',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-01-031') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='cluster_architecture' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-01-031',v_cert_id,v_theme_id,'À quoi sert le cloud controller manager ?','easy','SINGLE_CHOICE','CCM intègre Kubernetes avec l''API du cloud provider.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Interface avec le fournisseur cloud (load balancers, volumes)',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Gérer les pods',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Gérer les secrets',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Gérer les configmaps',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-01-032') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='cluster_architecture' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-01-032',v_cert_id,v_theme_id,'Sur quel port le kubelet expose ses métriques ?','easy','SINGLE_CHOICE','Le kubelet expose son API sur le port 10250 (HTTPS).','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','10250',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','10255',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','6443',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','8080',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-01-033') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='cluster_architecture' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-01-033',v_cert_id,v_theme_id,'Où sont stockés les manifests statiques (static pods) ?','easy','SINGLE_CHOICE','Le kubelet surveille ce répertoire pour les manifests statiques.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','/etc/kubernetes/manifests',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','/var/lib/kubelet',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','/etc/kubernetes/static-pods',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','/var/lib/kubelet/config',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-01-034') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='cluster_architecture' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-01-034',v_cert_id,v_theme_id,'Quels modes de fonctionnement kube-proxy supporte-t-il ?','easy','SINGLE_CHOICE','iptables est le mode par défaut, ipvs est plus performant.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','iptables, ipvs, userspace',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','iptables seulement',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','ipvs seulement',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','userspace seulement',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-01-035') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='cluster_architecture' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-01-035',v_cert_id,v_theme_id,'Quels container runtimes sont supportés par Kubernetes ?','easy','SINGLE_CHOICE','Kubernetes utilise l''interface CRI pour communiquer avec le runtime.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','containerd, CRI-O, Docker (via cri-dockerd)',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Docker seulement',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','containerd seulement',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','CRI-O seulement',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-01-036') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='cluster_architecture' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-01-036',v_cert_id,v_theme_id,'Qu''est-ce que le CNI (Container Network Interface) ?','easy','SINGLE_CHOICE','CNI est un standard pour configurer le réseau des conteneurs.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Plugin réseau pour les conteneurs',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Interface de stockage',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Interface de sécurité',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Interface de logging',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-01-037') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='cluster_architecture' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-01-037',v_cert_id,v_theme_id,'Quels sont des plugins CNI populaires ?','easy','SINGLE_CHOICE','Calico, Flannel, Weave, Cilium sont des plugins réseau.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Calico, Flannel, Weave, Cilium',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','iptables',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','kube-proxy',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','CoreDNS',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-01-038') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='cluster_architecture' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-01-038',v_cert_id,v_theme_id,'Qu''est-ce que le CSI (Container Storage Interface) ?','easy','SINGLE_CHOICE','CSI permet d''intégrer des solutions de stockage externes.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Standard pour les plugins de stockage',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Interface réseau',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Interface de sécurité',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Interface de logging',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-01-039') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='cluster_architecture' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-01-039',v_cert_id,v_theme_id,'Qu''est-ce que le CRI (Container Runtime Interface) ?','easy','SINGLE_CHOICE','CRI permet à kubelet de communiquer avec différents runtimes.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','API pour intégrer des container runtimes',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Interface réseau',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Interface de stockage',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Interface de sécurité',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-01-040') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='cluster_architecture' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-01-040',v_cert_id,v_theme_id,'Quelle commande initialise un cluster avec kubeadm ?','easy','SINGLE_CHOICE','kubeadm init initialise le control plane.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','kubeadm init',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','kubeadm start',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','kubeadm create',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','kubeadm cluster',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-02-001') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='workloads___scheduling' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-02-001',v_cert_id,v_theme_id,'Qu''est-ce qu''un pod ?','easy','SINGLE_CHOICE','Un pod est un groupe de conteneurs partageant le même réseau et stockage.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Le plus petit déployable, contient un ou plusieurs conteneurs',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Un nœud',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Un service',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Un volume',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-02-002') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='workloads___scheduling' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-02-002',v_cert_id,v_theme_id,'Comment créer un pod avec kubectl (impératif) ?','easy','SINGLE_CHOICE','kubectl run crée un pod.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','kubectl run monpod --image=nginx',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','kubectl create pod monpod --image=nginx',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','kubectl pod monpod --image=nginx',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','kubectl start monpod --image=nginx',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-02-003') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='workloads___scheduling' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-02-003',v_cert_id,v_theme_id,'Comment supprimer un pod ?','easy','SINGLE_CHOICE','Plusieurs façons de supprimer un pod.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','kubectl delete pod monpod',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','kubectl delete -f pod.yaml',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','kubectl delete pod --all',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-02-004') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='workloads___scheduling' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-02-004',v_cert_id,v_theme_id,'Comment ajouter un label à un pod ?','easy','SINGLE_CHOICE','On peut ajouter des labels via kubectl label ou dans le manifeste.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','kubectl label pod monpod env=prod',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','kubectl label monpod env=prod',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Dans le fichier YAML',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A et C',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-02-005') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='workloads___scheduling' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-02-005',v_cert_id,v_theme_id,'Comment lister les pods avec un label spécifique ?','easy','SINGLE_CHOICE','-l ou --selector filtre les ressources par label.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','kubectl get pods -l env=prod',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','kubectl get pods --selector env=prod',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','kubectl get pods --label env=prod',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A et B',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-02-006') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='workloads___scheduling' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-02-006',v_cert_id,v_theme_id,'À quoi sert un ReplicaSet ?','easy','SINGLE_CHOICE','Le ReplicaSet assure la haute disponibilité des pods.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Garantir un nombre spécifique de pods',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Mettre à l''échelle des pods',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Remplacer les pods défaillants',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-02-007') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='workloads___scheduling' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-02-007',v_cert_id,v_theme_id,'Quelle ressource est généralement utilisée à la place du ReplicaSet ?','easy','SINGLE_CHOICE','Les Deployments gèrent les ReplicaSets avec des mises à jour rolling.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Deployment',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','StatefulSet',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','DaemonSet',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Job',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-02-008') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='workloads___scheduling' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-02-008',v_cert_id,v_theme_id,'Que permet un Deployment ?','easy','SINGLE_CHOICE','Les Deployments offrent des fonctionnalités avancées de mise à jour.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Mises à jour rolling, rollback, scaling',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Création de pods',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Gestion des volumes',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Gestion des secrets',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-02-009') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='workloads___scheduling' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-02-009',v_cert_id,v_theme_id,'Comment mettre à l''échelle un Deployment ?','easy','SINGLE_CHOICE','Plusieurs façons de changer le nombre de réplicas.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','kubectl scale deployment mondeploy --replicas=5',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','kubectl edit deployment mondeploy',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','kubectl patch deployment mondeploy -p ''{"spec":{"replicas":5}}''',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-02-010') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='workloads___scheduling' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-02-010',v_cert_id,v_theme_id,'Comment mettre à jour l''image d''un Deployment ?','easy','SINGLE_CHOICE','set image, edit, patch sont possibles.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','kubectl set image deployment/mondeploy nginx=nginx:1.20',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','kubectl edit deployment mondeploy',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','kubectl patch deployment mondeploy -p ''{"spec":{"template":{"spec":{"containers":[{"name":"nginx","image":"nginx:1.20"}]}}}}''',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-02-011') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='workloads___scheduling' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-02-011',v_cert_id,v_theme_id,'Comment voir l''historique des rollouts ?','easy','SINGLE_CHOICE','rollout history affiche les révisions.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','kubectl rollout history deployment mondeploy',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','kubectl rollout status deployment mondeploy',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','kubectl rollout undo deployment mondeploy',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','kubectl describe deployment mondeploy',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-02-012') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='workloads___scheduling' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-02-012',v_cert_id,v_theme_id,'Comment annuler un rollout (revenir à la version précédente) ?','easy','SINGLE_CHOICE','undo revient à la version précédente ou spécifiée.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','kubectl rollout undo deployment mondeploy',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','kubectl rollout undo deployment mondeploy --to-revision=2',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','kubectl rollout restart deployment mondeploy',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A et B',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-02-013') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='workloads___scheduling' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-02-013',v_cert_id,v_theme_id,'Que fait `kubectl rollout restart deployment mondeploy` ?','easy','SINGLE_CHOICE','Restart redémarre les pods sans changer l''image.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Redémarre tous les pods du deployment',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Annule le rollout',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Met à jour l''image',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Scaling',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-02-014') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='workloads___scheduling' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-02-014',v_cert_id,v_theme_id,'Qu''est-ce qu''un DaemonSet ?','easy','SINGLE_CHOICE','DaemonSet garantit qu''un pod tourne sur chaque nœud.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Un pod sur chaque nœud (ou sous-ensemble)',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Un pod unique',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Un service de base de données',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Un volume partagé',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-02-015') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='workloads___scheduling' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-02-015',v_cert_id,v_theme_id,'Quand utiliser un DaemonSet ?','easy','SINGLE_CHOICE','DaemonSet est idéal pour les agents système par nœud.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Monitoring, logs, kube-proxy, CNI',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Applications web',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Base de données',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Cache',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-02-016') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='workloads___scheduling' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-02-016',v_cert_id,v_theme_id,'Qu''est-ce qu''un StatefulSet ?','easy','SINGLE_CHOICE','StatefulSet est utilisé pour les applications avec état (bases de données).','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Gère des pods avec identité stable et stockage persistant',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Ensemble de pods stateless',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Service de base de données',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Volume persistant',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-02-017') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='workloads___scheduling' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-02-017',v_cert_id,v_theme_id,'Les pods d''un StatefulSet ont-ils des noms uniques et prévisibles ?','easy','SINGLE_CHOICE','Les noms suivent le format <nom-statefulset>-<index>.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Oui',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Uniquement si ordre',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Uniquement si headless service',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-02-018') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='workloads___scheduling' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-02-018',v_cert_id,v_theme_id,'Quel service est généralement utilisé avec un StatefulSet ?','easy','SINGLE_CHOICE','Un headless service permet d''accéder à chaque pod individuellement.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Headless service (clusterIP: None)',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','LoadBalancer',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','NodePort',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','ClusterIP',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-02-019') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='workloads___scheduling' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-02-019',v_cert_id,v_theme_id,'À quoi sert un Job ?','easy','SINGLE_CHOICE','Un Job crée des pods qui s''exécutent jusqu''à terminaison.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Exécuter une tâche jusqu''à complétion',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Exécuter un service continu',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Planifier des tâches',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Gérer des bases de données',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-02-020') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='workloads___scheduling' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-02-020',v_cert_id,v_theme_id,'Comment créer un Job ?','easy','SINGLE_CHOICE','kubectl create job (impératif) ou fichier YAML.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','kubectl create job monjob --image=busybox -- echo ''Hello''',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','kubectl run monjob --image=busybox --restart=OnFailure -- echo ''Hello''',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','YAML avec apiVersion: batch/v1',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A et C',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-02-021') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='workloads___scheduling' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-02-021',v_cert_id,v_theme_id,'Qu''est-ce qu''un CronJob ?','easy','SINGLE_CHOICE','CronJob crée des Jobs à intervalles réguliers.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Job planifié selon un schedule cron',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Job unique',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Job récurrent',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A et C',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-02-022') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='workloads___scheduling' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-02-022',v_cert_id,v_theme_id,'Comment créer un CronJob ?','easy','SINGLE_CHOICE','kubectl create cronjob est disponible, mais YAML est plus flexible.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','kubectl create cronjob moncron --image=busybox --schedule=''*/5 * * * *'' -- echo ''Hello''',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','YAML avec apiVersion: batch/v1 kind: CronJob',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','A et B',TRUE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A seulement',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-02-023') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='workloads___scheduling' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-02-023',v_cert_id,v_theme_id,'À quoi servent les initContainers ?','easy','SINGLE_CHOICE','Les initContainers effectuent des tâches de préparation (attente de service, migration).','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','S''exécutent avant les conteneurs principaux',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','S''exécutent après les conteneurs',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','S''exécutent en parallèle',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','S''exécutent en arrière-plan',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-02-024') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='workloads___scheduling' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-02-024',v_cert_id,v_theme_id,'Les initContainers s''exécutent-ils avant ou après le démarrage des conteneurs principaux ?','easy','SINGLE_CHOICE','Ils doivent se terminer avec succès avant le démarrage des conteneurs principaux.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Avant',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Après',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','En même temps',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Dans l''ordre défini',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-02-025') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='workloads___scheduling' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-02-025',v_cert_id,v_theme_id,'Comment forcer un pod sur un nœud spécifique avec nodeSelector ?','easy','SINGLE_CHOICE','nodeSelector sélectionne les nœuds ayant le label.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','nodeSelector: disktype: ssd',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','nodeName: node1',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','affinity: nodeAffinity',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','nodeSelector: zone: prod',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-02-026') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='workloads___scheduling' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-02-026',v_cert_id,v_theme_id,'Comment définir une affinité de nœud (required) ?','easy','SINGLE_CHOICE','requiredDuringScheduling est une condition dure.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','affinity: nodeAffinity: requiredDuringSchedulingIgnoredDuringExecution',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','nodeAffinity: required',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','affinity: required',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','nodeSelector: required',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-02-027') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='workloads___scheduling' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-02-027',v_cert_id,v_theme_id,'Comment définir une anti-affinité de pod ?','easy','SINGLE_CHOICE','podAntiAffinity évite que deux pods s''exécutent sur le même nœud.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','podAntiAffinity',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','podAffinity',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','nodeAntiAffinity',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','antiAffinity',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-02-028') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='workloads___scheduling' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-02-028',v_cert_id,v_theme_id,'À quoi sert une taint sur un nœud ?','easy','SINGLE_CHOICE','Les taints empêchent les pods non tolérants d''être placés sur le nœud.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Repousser les pods qui n''ont pas la toleration correspondante',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Attirer les pods',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Limiter les ressources',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Marquer le nœud comme défaillant',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-02-029') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='workloads___scheduling' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-02-029',v_cert_id,v_theme_id,'Comment ajouter une taint à un nœud ?','easy','SINGLE_CHOICE','kubectl taint est la commande spécifique.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','kubectl taint nodes node1 key=value:NoSchedule',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','kubectl label nodes node1 taint=key=value',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','kubectl annotate nodes node1 taint=key=value',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','kubectl patch nodes node1 -p ''{"spec":{"taints":...}}''',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-02-030') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='workloads___scheduling' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-02-030',v_cert_id,v_theme_id,'Quels sont les effets des taints ?','easy','SINGLE_CHOICE','NoSchedule (dur), PreferNoSchedule (préférence), NoExecute (éviction).','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','NoSchedule, PreferNoSchedule, NoExecute',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','NoSchedule seulement',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','NoExecute seulement',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','PreferNoSchedule seulement',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-02-031') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='workloads___scheduling' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-02-031',v_cert_id,v_theme_id,'Comment définir des requêtes et limites de ressources pour un conteneur ?','easy','SINGLE_CHOICE','Les requests garantissent des ressources, les limits limitent l''utilisation.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','resources: requests: memory: ''64Mi'' cpu: ''250m'' limits: memory: ''128Mi'' cpu: ''500m''',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','limits: memory: 128Mi',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','requests: cpu: 250m',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A et B',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-02-032') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='workloads___scheduling' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-02-032',v_cert_id,v_theme_id,'Que signifie l''unité ''m'' pour CPU (ex: 250m) ?','easy','SINGLE_CHOICE','250m = 0.25 cœur CPU.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','millicore (1/1000 de cœur)',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','megacore',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','millihertz',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','mégahertz',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-02-033') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='workloads___scheduling' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-02-033',v_cert_id,v_theme_id,'Que se passe-t-il si un pod dépasse sa limite de mémoire ?','easy','SINGLE_CHOICE','Le conteneur est terminé par OOM Killer (Out Of Memory).','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','OOM kill',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Throttling',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Pod suspendu',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Pod redémarré',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-02-034') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='workloads___scheduling' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-02-034',v_cert_id,v_theme_id,'Que se passe-t-il si un pod dépasse sa limite de CPU ?','easy','SINGLE_CHOICE','Le CPU est limité (throttling) sans terminaison.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Throttling (ralentissement)',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','OOM kill',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Pod suspendu',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Pod redémarré',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-02-035') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='workloads___scheduling' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-02-035',v_cert_id,v_theme_id,'À quoi sert le HPA ?','easy','SINGLE_CHOICE','HPA utilise les métriques (CPU, mémoire, personnalisées) pour scaler.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Ajuste automatiquement le nombre de réplicas',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Ajuste les limites de ressources',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Redimensionne les nœuds',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Ajuste les requêtes',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-02-036') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='workloads___scheduling' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-02-036',v_cert_id,v_theme_id,'Quelle commande crée un HPA ?','easy','SINGLE_CHOICE','autoscale est la commande impérative pour créer un HPA.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','kubectl autoscale deployment mondeploy --min=2 --max=5 --cpu-percent=80',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','kubectl scale deployment mondeploy --replicas=3',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','kubectl create hpa',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','kubectl apply -f hpa.yaml',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-02-037') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='workloads___scheduling' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-02-037',v_cert_id,v_theme_id,'Que fait le VPA ?','easy','SINGLE_CHOICE','VPA recommande ou ajuste automatiquement les ressources des pods.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Ajuste les requests/limits des conteneurs',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Ajuste le nombre de réplicas',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Redimensionne les nœuds',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Ajuste les services',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-02-038') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='workloads___scheduling' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-02-038',v_cert_id,v_theme_id,'À quoi sert un PDB ?','easy','SINGLE_CHOICE','Le PDB protège les applications lors des opérations de maintenance (drain).','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Limiter le nombre de pods qui peuvent être volontairement perturbés',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Limiter le nombre de pods',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Assurer la haute disponibilité',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A et C',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-02-039') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='workloads___scheduling' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-02-039',v_cert_id,v_theme_id,'Quelle est la différence entre minAvailable et maxUnavailable ?','easy','SINGLE_CHOICE','Les deux ne peuvent pas être utilisés en même temps.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','minAvailable: nombre minimum de pods disponibles, maxUnavailable: nombre maximum indisponible',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Identiques',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','minAvailable pour les deployments, maxUnavailable pour les statefulsets',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','minAvailable pour les reads, maxUnavailable pour les writes',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-02-040') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='workloads___scheduling' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-02-040',v_cert_id,v_theme_id,'À quoi servent les Priority Classes ?','easy','SINGLE_CHOICE','Les pods de haute priorité peuvent évincer les pods de basse priorité.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Définir la priorité des pods pour l''ordonnancement',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Définir la priorité des services',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Définir la priorité des nœuds',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Définir la priorité des volumes',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-02-041') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='workloads___scheduling' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-02-041',v_cert_id,v_theme_id,'Comment créer une PriorityClass ?','easy','SINGLE_CHOICE','Impératif ou déclaratif.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','apiVersion: scheduling.k8s.io/v1 kind: PriorityClass',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','kubectl create priorityclass high-priority --value=1000',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','A et B',TRUE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A seulement',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-02-042') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='workloads___scheduling' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-02-042',v_cert_id,v_theme_id,'Qu''est-ce que la préemption (preemption) ?','easy','SINGLE_CHOICE','La préemption permet aux pods prioritaires de prendre la place des moins prioritaires.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Éviction de pods de basse priorité pour placer un pod de haute priorité',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Mise à l''échelle',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Redémarrage',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Migration',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-02-043') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='workloads___scheduling' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-02-043',v_cert_id,v_theme_id,'À quoi servent les topology spread constraints ?','easy','SINGLE_CHOICE','Ils aident à répartir les pods pour la haute disponibilité.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Répartir les pods uniformément entre les zones (topologies)',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Limiter les pods par nœud',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Forcer l''affinité',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Gérer les taints',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-02-044') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='workloads___scheduling' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-02-044',v_cert_id,v_theme_id,'Quel est le champ maxSkew ?','easy','SINGLE_CHOICE','maxSkew contrôle la répartition.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Différence maximale du nombre de pods entre les topologies',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Nombre maximum de pods',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Nombre minimum de pods',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Écart de ressources',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-02-045') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='workloads___scheduling' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-02-045',v_cert_id,v_theme_id,'Quel est le délai d''arrêt gracieux par défaut ?','easy','SINGLE_CHOICE','Le pod reçoit SIGTERM et a 30s pour se terminer avant SIGKILL.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','30 secondes',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','10 secondes',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','60 secondes',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','5 secondes',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-02-046') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='workloads___scheduling' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-02-046',v_cert_id,v_theme_id,'Comment modifier le délai d''arrêt gracieux ?','easy','SINGLE_CHOICE','Le champ terminationGracePeriodSeconds dans le pod spec.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','terminationGracePeriodSeconds: 60',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','gracePeriodSeconds: 60',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','shutdownGracePeriod: 60',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A et B',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-02-047') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='workloads___scheduling' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-02-047',v_cert_id,v_theme_id,'À quoi sert le hook preStop ?','easy','SINGLE_CHOICE','preStop permet de nettoyer ou de se retirer proprement d''un service.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Exécuter une commande avant l''arrêt du conteneur',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Exécuter après l''arrêt',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Exécuter au démarrage',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Exécuter en cas d''erreur',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-02-048') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='workloads___scheduling' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-02-048',v_cert_id,v_theme_id,'Que fait une readiness probe ?','easy','SINGLE_CHOICE','Si la readiness probe échoue, le pod est retiré du service.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Indique si le conteneur est prêt à recevoir du trafic',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Indique si le conteneur est vivant',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Indique si le conteneur a démarré',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Indique la charge',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-02-049') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='workloads___scheduling' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-02-049',v_cert_id,v_theme_id,'Que fait une liveness probe ?','easy','SINGLE_CHOICE','La liveness probe permet de redémarrer les conteneurs bloqués.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Redémarre le conteneur si elle échoue',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Arrête le conteneur',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Suspend le conteneur',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Log une erreur',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-02-050') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='workloads___scheduling' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-02-050',v_cert_id,v_theme_id,'Quand utiliser une startup probe ?','easy','SINGLE_CHOICE','La startup probe désactive la liveness probe jusqu''à ce qu''elle réussisse.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Pour les applications à démarrage long (empêche la liveness probe d''échouer)',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Pour les applications rapides',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Pour les jobs',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Pour les cronjobs',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-03-001') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='services___networking' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-03-001',v_cert_id,v_theme_id,'Quels sont les types de services Kubernetes ?','easy','SINGLE_CHOICE','ClusterIP (interne), NodePort (externe via port), LoadBalancer (cloud), ExternalName (alias DNS).','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','ClusterIP, NodePort, LoadBalancer, ExternalName',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','ClusterIP seulement',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','NodePort seulement',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','LoadBalancer seulement',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-03-002') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='services___networking' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-03-002',v_cert_id,v_theme_id,'Quel est le type de service par défaut ?','easy','SINGLE_CHOICE','ClusterIP expose le service uniquement à l''intérieur du cluster.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','ClusterIP',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','NodePort',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','LoadBalancer',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','ExternalName',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-03-003') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='services___networking' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-03-003',v_cert_id,v_theme_id,'Comment créer un service de type NodePort ?','easy','SINGLE_CHOICE','Plusieurs façons de créer un NodePort.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','kubectl expose deployment mondeploy --type=NodePort --port=80',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','YAML avec type: NodePort',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','kubectl create service nodeport mon-service --tcp=80:8080',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-03-004') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='services___networking' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-03-004',v_cert_id,v_theme_id,'Quelle est la plage de ports NodePort par défaut ?','easy','SINGLE_CHOICE','Par défaut, les ports NodePort sont alloués dans cette plage.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','30000-32767',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','1-65535',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','80-443',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','1024-65535',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-03-005') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='services___networking' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-03-005',v_cert_id,v_theme_id,'À quoi sert un service de type LoadBalancer ?','easy','SINGLE_CHOICE','LoadBalancer utilise le cloud provider pour créer un LB externe.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Provisionne un load balancer externe (cloud provider)',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Expose via NodePort',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Expose via ClusterIP',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Crée un proxy',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-03-006') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='services___networking' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-03-006',v_cert_id,v_theme_id,'Qu''est-ce qu''un service headless ?','easy','SINGLE_CHOICE','Headless service permet la découverte directe des pods.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','clusterIP: None',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Service sans load balancing, retourne les adresses IP des pods',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Utilisé avec StatefulSet',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-03-007') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='services___networking' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-03-007',v_cert_id,v_theme_id,'Qu''est-ce qu''un Ingress ?','easy','SINGLE_CHOICE','Ingress gère l''accès externe aux services, souvent via un contrôleur.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Expose des services HTTP/HTTPS avec routage basé sur l''URL/hôte',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Load balancer de couche 4',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Service DNS',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Proxy TCP',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-03-008') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='services___networking' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-03-008',v_cert_id,v_theme_id,'Quel contrôleur Ingress est le plus courant ?','easy','SINGLE_CHOICE','nginx-ingress est le plus répandu.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','nginx-ingress',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','traefik',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','haproxy',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','kong',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-03-009') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='services___networking' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-03-009',v_cert_id,v_theme_id,'Comment spécifier un hôte dans une règle Ingress ?','easy','SINGLE_CHOICE','Le host peut être défini dans rules et tls.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','spec: rules: - host: example.com',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','spec: tls: - hosts: - example.com',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','metadata: annotations: kubernetes.io/ingress.host: example.com',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A et B',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-03-010') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='services___networking' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-03-010',v_cert_id,v_theme_id,'Comment activer le TLS dans un Ingress ?','easy','SINGLE_CHOICE','La section tls référence un secret contenant le certificat et la clé.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','spec: tls: - hosts: - example.com secretName: mon-tls',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','spec: secretName: mon-tls',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','metadata: annotations: kubernetes.io/tls: mon-tls',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A seulement',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-03-011') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='services___networking' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-03-011',v_cert_id,v_theme_id,'À quoi sert une NetworkPolicy ?','easy','SINGLE_CHOICE','Les Network Policies sont des firewalls au niveau du pod.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Contrôler le trafic réseau entre pods et/ou avec l''extérieur',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Configurer les services',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Gérer les Ingress',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Configurer le DNS',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-03-012') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='services___networking' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-03-012',v_cert_id,v_theme_id,'Par défaut, le trafic entre pods est-il autorisé ou bloqué ?','easy','SINGLE_CHOICE','Par défaut, tout le trafic est autorisé. Les Network Policies sont de type whitelist.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Autorisé (allow all)',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Bloqué (deny all)',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Dépend du CNI',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Autorisé uniquement dans le même namespace',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-03-013') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='services___networking' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-03-013',v_cert_id,v_theme_id,'Comment créer une NetworkPolicy qui bloque tout le trafic entrant ?','easy','SINGLE_CHOICE','Une policy sans règles ingress bloque tout le trafic entrant.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','policyTypes: - Ingress',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','ingress: []',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','spec: podSelector: {} ingress: []',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-03-014') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='services___networking' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-03-014',v_cert_id,v_theme_id,'Comment autoriser le trafic entrant uniquement depuis un pod avec un label spécifique ?','easy','SINGLE_CHOICE','podSelector et namespaceSelector sont possibles.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','ingress: - from: - podSelector: matchLabels: app: frontend',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','ingress: - from: - namespaceSelector: ...',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','ingress: - from: - ipBlock: ...',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A et B',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-03-015') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='services___networking' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-03-015',v_cert_id,v_theme_id,'Quel est le nom DNS d''un service dans le même namespace ?','easy','SINGLE_CHOICE','<service-name> est suffisant dans le même namespace.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','<service-name>',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','<service-name>.<namespace>.svc.cluster.local',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','<service-name>.svc.cluster.local',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A et C',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-03-016') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='services___networking' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-03-016',v_cert_id,v_theme_id,'Comment accéder à un service depuis un autre namespace ?','easy','SINGLE_CHOICE','Le nom FQDN inclut le namespace.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','<service-name>.<namespace>.svc.cluster.local',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','<service-name>.<namespace>',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','<service-name>.svc.cluster.local',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','<service-name>.cluster.local',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-03-017') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='services___networking' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-03-017',v_cert_id,v_theme_id,'Un Ingress Controller est-il nécessaire pour utiliser un Ingress ?','easy','SINGLE_CHOICE','L''Ingress Controller implémente les règles Ingress.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Oui',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Optionnel',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Uniquement pour le TLS',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-03-018') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='services___networking' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-03-018',v_cert_id,v_theme_id,'Qu''est-ce qu''un service mesh (ex: Istio, Linkerd) ?','easy','SINGLE_CHOICE','Un service mesh ajoute des fonctionnalités comme le mTLS, la retry, le circuit breaker.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Couche d''infrastructure pour la communication entre services',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Load balancer',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Ingress controller',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','DNS',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-03-019') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='services___networking' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-03-019',v_cert_id,v_theme_id,'Qu''est-ce qu''un Endpoint (ou EndpointSlice) ?','easy','SINGLE_CHOICE','Les endpoints sont automatiquement mis à jour par le contrôleur de service.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Liste des adresses IP des pods correspondant à un service',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Point de terminaison du service',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Adresse IP du service',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Port du service',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-03-020') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='services___networking' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-03-020',v_cert_id,v_theme_id,'Quels sont les champs de policyTypes ?','easy','SINGLE_CHOICE','On peut spécifier Ingress, Egress, ou les deux.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Ingress, Egress',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Ingress seulement',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Egress seulement',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A et B',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-03-021') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='services___networking' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-03-021',v_cert_id,v_theme_id,'Comment bloquer tout le trafic sortant d''un pod ?','easy','SINGLE_CHOICE','egress: [] bloque tout le trafic sortant.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','egress: []',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','policyTypes: - Egress',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','egress: - {}',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A et B',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-03-022') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='services___networking' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-03-022',v_cert_id,v_theme_id,'Qu''est-ce qu''un service ExternalName ?','easy','SINGLE_CHOICE','ExternalName permet d''accéder à un service externe via un nom DNS local.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Crée un alias DNS vers un nom externe',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Expose un service externe',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Crée un load balancer',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A et B',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-03-023') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='services___networking' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-03-023',v_cert_id,v_theme_id,'Le type LoadBalancer nécessite-t-il un cloud provider ?','easy','SINGLE_CHOICE','LoadBalancer utilise l''API du cloud provider pour créer un LB externe.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Oui',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Non (mais il faut un contrôleur)',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Non (intégré à Kubernetes)',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Uniquement pour AWS',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-03-024') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='services___networking' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-03-024',v_cert_id,v_theme_id,'Comment configurer la réécriture de chemin (rewrite) dans nginx-ingress ?','easy','SINGLE_CHOICE','L''annotation rewrite-target est spécifique au contrôleur nginx-ingress.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','nginx.ingress.kubernetes.io/rewrite-target: /',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','ingress.kubernetes.io/rewrite-target: /',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','rewrite-target: /',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','nginx.org/rewrite-target: /',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-03-025') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='services___networking' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-03-025',v_cert_id,v_theme_id,'Quels sont les types de chemin (pathType) dans Ingress ?','easy','SINGLE_CHOICE','Exact correspond exactement, Prefix correspond au préfixe.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Exact, Prefix, ImplementationSpecific',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Exact seulement',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Prefix seulement',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','ImplementationSpecific seulement',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-03-026') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='services___networking' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-03-026',v_cert_id,v_theme_id,'Comment activer la session affinity pour un service ?','easy','SINGLE_CHOICE','ClientIP dirige les requêtes d''une même IP vers le même pod.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','sessionAffinity: ClientIP',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','sessionAffinity: ClientIP',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','service.spec.sessionAffinity: ClientIP',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A et C',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-03-027') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='services___networking' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-03-027',v_cert_id,v_theme_id,'À quoi sert externalTrafficPolicy: Local ?','easy','SINGLE_CHOICE','Local conserve l''IP source mais peut déséquilibrer le trafic.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Conserve l''IP source du client',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Équilibrage local',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Meilleures performances',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A et C',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-03-028') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='services___networking' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-03-028',v_cert_id,v_theme_id,'Comment autoriser le trafic depuis tous les pods d''un namespace spécifique ?','easy','SINGLE_CHOICE','namespaceSelector sélectionne les namespaces par label.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','from: - namespaceSelector: matchLabels: name: production',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','from: - podSelector: {}',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','from: - namespace: production',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','from: - namespaceSelector: {}',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-03-029') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='services___networking' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-03-029',v_cert_id,v_theme_id,'Comment créer un secret TLS pour Ingress ?','easy','SINGLE_CHOICE','create secret tls est la commande spécifique.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','kubectl create secret tls mon-tls --cert=chemin/cert.pem --key=chemin/key.pem',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','kubectl create secret generic mon-tls --from-file=cert.pem --from-file=key.pem',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','kubectl create secret tls mon-tls --cert=cert.pem --key=key.pem',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A et C',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-03-030') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='services___networking' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-03-030',v_cert_id,v_theme_id,'Comment autoriser le trafic depuis une plage IP externe ?','easy','SINGLE_CHOICE','ipBlock spécifie une plage CIDR.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','ingress: - from: - ipBlock: cidr: 192.168.1.0/24',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','ingress: - from: - ipBlock: 192.168.1.0/24',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','ingress: - ipBlock: 192.168.1.0/24',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A seulement',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-03-031') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='services___networking' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-03-031',v_cert_id,v_theme_id,'Quel mode kube-proxy offre les meilleures performances ?','easy','SINGLE_CHOICE','ipvs utilise le noyau Linux pour un forwarding plus efficace.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','ipvs',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','iptables',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','userspace',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','kernelspace',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-03-032') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='services___networking' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-03-032',v_cert_id,v_theme_id,'Un service headless permet-il le load balancing ?','easy','SINGLE_CHOICE','Headless renvoie la liste des adresses IP, pas de virtual IP.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Non',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Oui',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Uniquement avec StatefulSet',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Uniquement avec ExternalName',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-03-033') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='services___networking' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-03-033',v_cert_id,v_theme_id,'Peut-on utiliser un certificat wildcard avec Ingress ?','easy','SINGLE_CHOICE','Les certificats wildcard sont supportés.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Oui (*.example.com)',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Uniquement avec des contrôleurs spécifiques',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Uniquement pour les sous-domaines',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-03-034') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='services___networking' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-03-034',v_cert_id,v_theme_id,'Comment créer une NetworkPolicy qui bloque tout le trafic (ingress et egress) ?','easy','SINGLE_CHOICE','Il faut spécifier les deux policyTypes et des règles vides.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','policyTypes: - Ingress - Egress',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','ingress: [] egress: []',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','A et B',TRUE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A seulement',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-03-035') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='services___networking' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-03-035',v_cert_id,v_theme_id,'Quelle fonctionnalité a remplacé topologyKeys ?','easy','SINGLE_CHOICE','Topology Aware Routing permet de préférer les endpoints locaux.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Topology Aware Routing (Service) et topologySpreadConstraints',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Rien',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Affinity',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','NodeSelector',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-03-036') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='services___networking' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-03-036',v_cert_id,v_theme_id,'Quelle est l''API stable actuelle pour Ingress ?','easy','SINGLE_CHOICE','networking.k8s.io/v1 est la version stable depuis Kubernetes 1.19.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','networking.k8s.io/v1',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','extensions/v1beta1',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','networking.k8s.io/v1beta1',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','ingress/v1',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-03-037') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='services___networking' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-03-037',v_cert_id,v_theme_id,'ExternalName fonctionne-t-il avec un service headless ?','easy','SINGLE_CHOICE','ExternalName ne crée pas d''endpoints, juste un enregistrement CNAME.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Non',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Oui',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Uniquement avec clusterIP',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Uniquement avec NodePort',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-03-038') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='services___networking' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-03-038',v_cert_id,v_theme_id,'Comment autoriser le trafic sortant vers le serveur DNS (kube-dns) ?','easy','SINGLE_CHOICE','Il faut autoriser les requêtes DNS (port 53 UDP/TCP) vers le service kube-dns.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','egress: - to: - namespaceSelector: matchLabels: kubernetes.io/metadata.name: kube-system podSelector: matchLabels: k8s-app: kube-dns ports: - port: 53 protocol: UDP',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','egress: - to: - namespace: kube-system',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','egress: - to: - podSelector: k8s-app: kube-dns',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A seulement',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-03-039') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='services___networking' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-03-039',v_cert_id,v_theme_id,'À quoi sert le default backend dans un Ingress ?','easy','SINGLE_CHOICE','Le default backend reçoit les requêtes non correspondantes.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Trafic vers les requêtes ne correspondant à aucune règle',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Backend par défaut',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Fallback',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A et C',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-03-040') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='services___networking' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-03-040',v_cert_id,v_theme_id,'Qu''est-ce que le topology aware routing (anciennement topology aware hints) ?','easy','SINGLE_CHOICE','Améliore la latence et réduit les coûts de transfert de données.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Préfère les endpoints dans la même zone',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Répartition aléatoire',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Load balancing global',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Affinité de session',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-03-041') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='services___networking' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-03-041',v_cert_id,v_theme_id,'Où est généralement déployé un contrôleur Ingress ?','easy','SINGLE_CHOICE','Les contrôleurs sont souvent déployés dans un namespace dédié.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Dans le namespace ingress-nginx (ou similaire)',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Dans kube-system',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Dans default',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','N''importe où',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-03-042') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='services___networking' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-03-042',v_cert_id,v_theme_id,'Comment configurer le rate limiting avec nginx-ingress ?','easy','SINGLE_CHOICE','limit-rps et limit-rpm sont des annotations courantes.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','nginx.ingress.kubernetes.io/limit-rps: 10',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','nginx.ingress.kubernetes.io/rate-limit: 10',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','nginx.org/rate-limit: 10',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A seulement',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-03-043') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='services___networking' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-03-043',v_cert_id,v_theme_id,'Quel est l''avantage des EndpointSlices par rapport aux Endpoints ?','easy','SINGLE_CHOICE','Les EndpointSlices découpent les endpoints en morceaux pour éviter les limites d''étiquette.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Meilleure scalabilité (plus de 1000 endpoints)',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Plus de fonctionnalités',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Plus simple',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A et B',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-03-044') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='services___networking' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-03-044',v_cert_id,v_theme_id,'Une NetworkPolicy peut-elle cibler plusieurs namespaces ?','easy','SINGLE_CHOICE','namespaceSelector sélectionne des namespaces par label.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Oui, avec namespaceSelector',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Oui, avec podSelector uniquement',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Oui, avec ipBlock',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-03-045') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='services___networking' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-03-045',v_cert_id,v_theme_id,'Si deux chemins Ingress correspondent, lequel est utilisé ?','easy','SINGLE_CHOICE','Les chemins sont évalués du plus spécifique au moins spécifique.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Le plus long (plus spécifique) d''abord',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Le premier défini',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Ordre alphabétique',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Aléatoire',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-03-046') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='services___networking' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-03-046',v_cert_id,v_theme_id,'Comment Kubernetes vérifie-t-il la santé des pods pour un service ?','easy','SINGLE_CHOICE','Les readiness probes déterminent si le pod reçoit du trafic.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Readiness probes',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Liveness probes',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Health checks du service',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A et B',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-03-047') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='services___networking' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-03-047',v_cert_id,v_theme_id,'Un service mesh remplace-t-il Ingress ?','easy','SINGLE_CHOICE','Ingress gère le trafic entrant, service mesh gère la communication entre services.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Non, ils sont complémentaires',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Oui, le service mesh inclut Ingress',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Oui, Ingress est obsolète',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Non, Ingress est pour les entrées, service mesh pour l''intérieur',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-03-048') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='services___networking' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-03-048',v_cert_id,v_theme_id,'Qu''est-ce que la Gateway API ?','easy','SINGLE_CHOICE','Gateway API (v1beta1) offre plus de fonctionnalités qu''Ingress.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Successeur plus puissant d''Ingress',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','API pour les load balancers',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','API pour les services',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','API pour les network policies',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-03-049') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='services___networking' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-03-049',v_cert_id,v_theme_id,'Quelles sont les ressources de la Gateway API ?','easy','SINGLE_CHOICE','Gateway API introduit de nouveaux types de ressources.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Gateway, HTTPRoute, TCPRoute, etc.',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Ingress, Service',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','NetworkPolicy, EndpointSlice',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Pod, Deployment',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-03-050') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='services___networking' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-03-050',v_cert_id,v_theme_id,'À quoi sert Multus ?','easy','SINGLE_CHOICE','Multus est un méta-CNI qui permet d''attacher plusieurs CNI à un pod.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Attacher plusieurs interfaces réseau à un pod',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Remplacer Calico',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Gérer les network policies',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Configurer le DNS',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-04-001') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='storage' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-04-001',v_cert_id,v_theme_id,'Quels sont les types de volumes Kubernetes ?','easy','SINGLE_CHOICE','Kubernetes supporte de nombreux types de volumes.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','emptyDir, hostPath, configMap, secret, persistentVolumeClaim, etc.',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Seulement emptyDir',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Seulement hostPath',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Seulement persistentVolumeClaim',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-04-002') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='storage' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-04-002',v_cert_id,v_theme_id,'Qu''est-ce qu''un volume emptyDir ?','easy','SINGLE_CHOICE','emptyDir est temporaire, son contenu disparaît avec le pod.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Répertoire vide créé lorsque le pod est assigné à un nœud, partagé entre les conteneurs du pod',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Volume persistant',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Volume monté depuis l''hôte',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Volume depuis un ConfigMap',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-04-003') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='storage' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-04-003',v_cert_id,v_theme_id,'Quand utiliser hostPath ?','easy','SINGLE_CHOICE','hostPath monte un répertoire du nœud, dangereux pour les données critiques.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Accéder à des fichiers système de l''hôte (ex: docker.sock)',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Stockage persistant partagé',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Base de données',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Cache',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-04-004') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='storage' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-04-004',v_cert_id,v_theme_id,'Qu''est-ce qu''un PersistentVolume (PV) ?','easy','SINGLE_CHOICE','Un PV est une ressource de cluster (comme un nœud) représentant du stockage.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Stockage provisionné par l''administrateur, indépendant des pods',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Volume temporaire',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Volume lié à un pod',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Volume depuis un ConfigMap',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-04-005') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='storage' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-04-005',v_cert_id,v_theme_id,'Qu''est-ce qu''un PersistentVolumeClaim (PVC) ?','easy','SINGLE_CHOICE','Le PVC demande une certaine quantité de stockage à un PV.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Demande de stockage par un utilisateur/pod',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Volume persistant',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Stockage temporaire',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Configuration de stockage',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-04-006') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='storage' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-04-006',v_cert_id,v_theme_id,'Comment lier un pod à un PVC ?','easy','SINGLE_CHOICE','Il faut déclarer le volume dans le pod puis le monter.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','volumes: - name: monvol persistentVolumeClaim: claimName: monpvc',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','persistentVolumeClaim: monpvc',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','volumeMounts: - name: monvol mountPath: /data',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A et C',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-04-007') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='storage' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-04-007',v_cert_id,v_theme_id,'À quoi sert une StorageClass ?','easy','SINGLE_CHOICE','Les StorageClasses permettent le provisionnement dynamique de PV.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Définir un type de stockage (ex: ssd, slow) pour le provisionnement dynamique',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Classe de volume',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Type de PVC',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Type de PV',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-04-008') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='storage' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-04-008',v_cert_id,v_theme_id,'Quelle StorageClass est utilisée par défaut ?','easy','SINGLE_CHOICE','L''annotation désigne la StorageClass par défaut.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Celle marquée avec l''annotation storageclass.kubernetes.io/is-default-class: true',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','standard',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','default',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Aucune',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-04-009') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='storage' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-04-009',v_cert_id,v_theme_id,'Que permet le provisionnement dynamique ?','easy','SINGLE_CHOICE','Le provisionnement dynamique nécessite une StorageClass.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Créer automatiquement un PV lorsqu''un PVC est créé',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Créer un PV manuellement',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Créer un PVC',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Créer un volume',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-04-010') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='storage' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-04-010',v_cert_id,v_theme_id,'Quels sont les modes de volume possibles pour un PV ?','easy','SINGLE_CHOICE','Les modes d''accès et le mode de volume sont différents.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Filesystem (par défaut), Block',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','ReadWriteOnce, ReadOnlyMany, ReadWriteMany',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','A et B',TRUE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A seulement',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-04-011') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='storage' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-04-011',v_cert_id,v_theme_id,'Quels sont les modes d''accès pour les PV/PVC ?','easy','SINGLE_CHOICE','RWO (un seul nœud lecture-écriture), ROX (plusieurs nœuds lecture seule), RWX (plusieurs nœuds lecture-écriture).','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','ReadWriteOnce (RWO), ReadOnlyMany (ROX), ReadWriteMany (RWX)',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','ReadOnly, ReadWrite',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Shared, Exclusive',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Single, Multiple',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-04-012') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='storage' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-04-012',v_cert_id,v_theme_id,'Quelles sont les politiques de récupération (reclaim policy) d''un PV ?','easy','SINGLE_CHOICE','Retain (conserve), Delete (supprime), Recycle (déprécié).','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Retain, Delete, Recycle',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Keep, Remove, Reuse',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Persist, Delete, Recycle',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Retain, Delete, Reclaim',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-04-013') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='storage' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-04-013',v_cert_id,v_theme_id,'Qu''est-ce que le CSI (Container Storage Interface) ?','easy','SINGLE_CHOICE','CSI permet d''intégrer des solutions de stockage externes.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Standard pour les plugins de stockage',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Type de volume',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','StorageClass',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','PVC',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-04-014') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='storage' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-04-014',v_cert_id,v_theme_id,'Quels sont les statuts possibles d''un PVC ?','easy','SINGLE_CHOICE','Pending (en attente), Bound (lié à un PV), Lost (perdu).','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Pending, Bound, Lost',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Created, Bound, Deleted',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Waiting, Bound, Failed',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Pending, Available, Bound',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-04-015') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='storage' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-04-015',v_cert_id,v_theme_id,'Peut-on augmenter la taille d''un PVC après création ?','easy','SINGLE_CHOICE','L''expansion de volume nécessite le support du driver CSI.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Oui, si la StorageClass le permet (allowVolumeExpansion: true)',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Oui, toujours',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Uniquement pour les PV statiques',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-04-016') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='storage' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-04-016',v_cert_id,v_theme_id,'Qu''est-ce qu''un VolumeSnapshot ?','easy','SINGLE_CHOICE','VolumeSnapshot permet de sauvegarder l''état d''un volume.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Snapshot d''un volume persistant',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Backup de PV',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Clone de volume',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A et B',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-04-017') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='storage' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-04-017',v_cert_id,v_theme_id,'À quoi sert VolumeSnapshotClass ?','easy','SINGLE_CHOICE','VolumeSnapshotClass est l''équivalent de StorageClass pour les snapshots.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Définir les paramètres pour les snapshots (ex: driver)',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Classer les snapshots',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Définir la politique de rétention',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A et C',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-04-018') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='storage' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-04-018',v_cert_id,v_theme_id,'Qu''est-ce qu''un volume éphémère (ephemeral) ?','easy','SINGLE_CHOICE','Les volumes éphémères (ex: inline CSI) sont créés avec le pod et détruits avec lui.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Volume qui existe avec le pod, supprimé à la fin',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','emptyDir',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','CSI ephemeral inline volume',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A et C',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-04-019') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='storage' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-04-019',v_cert_id,v_theme_id,'Qu''est-ce qu''un volume local persistent (Local PV) ?','easy','SINGLE_CHOICE','Local PV est utile pour les bases de données, mais le pod est lié au nœud.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','PV utilisant le stockage local d''un nœud',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Volume partagé',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Volume réseau',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Volume cloud',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-04-020') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='storage' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-04-020',v_cert_id,v_theme_id,'Un pod utilisant un Local PV peut-il être déplacé sur un autre nœud ?','easy','SINGLE_CHOICE','Le stockage local est attaché à un nœud spécifique.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Non (lié au nœud)',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Oui',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Uniquement avec PVC',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Uniquement avec StorageClass',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-04-021') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='storage' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-04-021',v_cert_id,v_theme_id,'Quelle est la différence entre hostPath et Local PV ?','easy','SINGLE_CHOICE','Local PV est un PV standard qui peut être réclamé par PVC, hostPath est direct.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Local PV est une ressource de cluster (PV), hostPath est un volume de pod',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Identiques',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','hostPath est persistant',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Local PV est plus rapide',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-04-022') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='storage' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-04-022',v_cert_id,v_theme_id,'Comment lier un PVC à un PV spécifique ?','easy','SINGLE_CHOICE','selector ou volumeName permettent de lier à un PV particulier.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','selector: matchLabels: name: monpv',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','volumeName: monpv',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','storageClassName: standard',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A et B',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-04-023') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='storage' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-04-023',v_cert_id,v_theme_id,'Si aucune StorageClass n''est spécifiée, quelle classe est utilisée ?','easy','SINGLE_CHOICE','La StorageClass par défaut est utilisée si elle existe.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','La StorageClass par défaut du cluster',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Aucune (PVC reste pending)',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','La classe standard',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','La classe default',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-04-024') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='storage' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-04-024',v_cert_id,v_theme_id,'Que se passe-t-il si on augmente la taille d''un PVC déjà lié ?','easy','SINGLE_CHOICE','L''expansion dépend du driver de stockage.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Le PV doit supporter l''expansion, le pod peut nécessiter un redémarrage',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Le PVC est recréé',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Le PV est supprimé',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Rien',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-04-025') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='storage' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-04-025',v_cert_id,v_theme_id,'Les volumes CSI inline sont-ils persistants ?','easy','SINGLE_CHOICE','Les CSI inline volumes sont éphémères (avec le pod).','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Non (éphémères)',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Oui',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Dépend du driver',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Uniquement avec snapshot',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-04-026') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='storage' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-04-026',v_cert_id,v_theme_id,'Quel est le mode de liaison de volume par défaut pour une StorageClass ?','easy','SINGLE_CHOICE','Immediate crée le PV immédiatement, WaitForFirstConsumer attend qu''un pod utilise le PVC.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Immediate',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','WaitForFirstConsumer',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Delayed',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Deferred',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-04-027') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='storage' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-04-027',v_cert_id,v_theme_id,'Comment spécifier des options de montage (ex: noexec) pour un PV ?','easy','SINGLE_CHOICE','mountOptions dans la StorageClass ou le PV.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','mountOptions: - noexec',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','mountFlags: - noexec',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','volumeMounts: - mountOptions: noexec',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A seulement',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-04-028') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='storage' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-04-028',v_cert_id,v_theme_id,'Peut-on lier un PV à des nœuds spécifiques ?','easy','SINGLE_CHOICE','Le PV peut avoir une nodeAffinity, le pod peut aussi avoir des contraintes.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','nodeAffinity dans le PV',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','nodeSelector dans le pod',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','A et B',TRUE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A seulement',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-04-029') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='storage' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-04-029',v_cert_id,v_theme_id,'Comment spécifier des paramètres spécifiques au provisionneur (ex: type de disque) ?','easy','SINGLE_CHOICE','Le champ parameters dépend du provisionneur (ex: GCE, AWS, Azure).','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','parameters: type: pd-ssd',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','params: type: ssd',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','options: type: ssd',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A seulement',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-04-030') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='storage' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-04-030',v_cert_id,v_theme_id,'Que se passe-t-il si on supprime un PVC alors que le PV a reclaimPolicy=Retain ?','easy','SINGLE_CHOICE','Le PV n''est pas supprimé, il devient Released et peut être réutilisé.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Le PV passe à Released, les données persistent',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Le PV est supprimé',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Le PV est recyclé',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Rien',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-04-031') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='storage' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-04-031',v_cert_id,v_theme_id,'Où s''exécutent généralement les drivers CSI ?','easy','SINGLE_CHOICE','Le driver CSI a un composant de nœud (DaemonSet) et un composant de contrôle (Deployment).','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','DaemonSet (node plugin) et Deployment (controller)',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','StatefulSet',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Job',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','CronJob',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-04-032') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='storage' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-04-032',v_cert_id,v_theme_id,'Comment déclarer un volume CSI éphémère inline dans un pod ?','easy','SINGLE_CHOICE','La syntaxe est similaire à un volume CSI normal, sans PVC.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','volumes: - name: monvol csi: driver: mon-driver volumeAttributes: ...',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','ephemeral: - csi: driver: ...',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','inlineCSI: driver: ...',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A seulement',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-04-033') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='storage' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-04-033',v_cert_id,v_theme_id,'Comment chaque pod d''un StatefulSet obtient-il son propre PVC ?','easy','SINGLE_CHOICE','volumeClaimTemplates crée un PVC par réplica.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','volumeClaimTemplates',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','volumes: - persistentVolumeClaim',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Les deux',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A seulement',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-04-034') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='storage' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-04-034',v_cert_id,v_theme_id,'Comment déclencher le redimensionnement d''un PVC après modification de sa taille ?','easy','SINGLE_CHOICE','Il suffit de modifier la spec.resources.requests.storage.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','kubectl edit pvc monpvc, puis le contrôleur tente de redimensionner',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','kubectl patch pvc monpvc -p ''{"spec":{"resources":{"requests":{"storage":"10Gi"}}}}''',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Les deux',TRUE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A seulement',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-04-035') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='storage' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-04-035',v_cert_id,v_theme_id,'Si plusieurs réplicas d''un Deployment partagent-ils le même PVC ?','easy','SINGLE_CHOICE','Le même PVC est monté sur tous les réplicas (si RWO, un seul peut écrire).','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Oui (par défaut)',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Non, chaque réplica a son propre PVC',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Uniquement si shareProcessNamespace',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Dépend du volume mode',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-04-036') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='storage' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-04-036',v_cert_id,v_theme_id,'Peut-on créer un PV à partir d''un PVC existant ?','easy','SINGLE_CHOICE','Il faut utiliser un snapshot ou cloner via CSI.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Non, mais on peut créer un snapshot puis un nouveau PV',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Oui, avec kubectl create pv --from=pvc',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Oui, en copiant le YAML',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Non',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-04-037') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='storage' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-04-037',v_cert_id,v_theme_id,'Le clonage de volume (clone) est-il supporté par tous les CSI drivers ?','easy','SINGLE_CHOICE','Le clonage nécessite le support du driver CSI.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Non (dépend du driver)',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Oui, tous',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Uniquement pour les snapshots',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Uniquement pour les volumes locaux',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-04-038') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='storage' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-04-038',v_cert_id,v_theme_id,'Comment créer un PVC à partir d''un snapshot ?','easy','SINGLE_CHOICE','dataSource ou dataSourceRef (pour les cross-namespace) sont supportés.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','dataSource: kind: VolumeSnapshot name: mon-snapshot',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','dataSourceRef: kind: VolumeSnapshot name: mon-snapshot',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','snapshot: mon-snapshot',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A et B',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-04-039') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='storage' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-04-039',v_cert_id,v_theme_id,'Le nom d''un PVC doit-il être unique dans un namespace ?','easy','SINGLE_CHOICE','Les noms de ressources doivent être uniques dans leur namespace.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Oui',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Uniquement pour les PVC liés',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Uniquement pour les PVC en attente',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-04-040') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='storage' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-04-040',v_cert_id,v_theme_id,'Si la StorageClass par défaut est marquée avec ''storageclass.kubernetes.io/is-default-class: true'', que se passe-t-il si un PVC ne spécifie pas storageClassName ?','easy','SINGLE_CHOICE','Le PVC utilisera automatiquement la StorageClass par défaut.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Il utilise la classe par défaut',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Il reste pending',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Il utilise la classe standard',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Erreur',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-05-001') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='troubleshooting' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-05-001',v_cert_id,v_theme_id,'Comment voir les logs d''un pod ?','easy','SINGLE_CHOICE','kubectl logs avec options -c, --tail, --since.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','kubectl logs <pod>',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','kubectl logs <pod> -c <container>',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','kubectl logs --tail=100 <pod>',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-05-002') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='troubleshooting' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-05-002',v_cert_id,v_theme_id,'Comment streamer les logs d''un pod en temps réel ?','easy','SINGLE_CHOICE','-f ou --follow suit les logs.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','kubectl logs -f <pod>',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','kubectl logs --follow <pod>',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','kubectl attach <pod>',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A et B',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-05-003') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='troubleshooting' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-05-003',v_cert_id,v_theme_id,'Comment voir les logs des pods précédents (redémarrés) ?','easy','SINGLE_CHOICE','--previous ou -p montre les logs du dernier conteneur terminé.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','kubectl logs --previous <pod>',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','kubectl logs -p <pod>',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','kubectl logs --prev <pod>',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A et B',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-05-004') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='troubleshooting' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-05-004',v_cert_id,v_theme_id,'Comment lister les événements du cluster ?','easy','SINGLE_CHOICE','Les événements aident à comprendre pourquoi un pod ne démarre pas.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','kubectl get events',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','kubectl get events --sort-by=''.lastTimestamp''',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','kubectl describe node <node>',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-05-005') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='troubleshooting' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-05-005',v_cert_id,v_theme_id,'Comment filtrer les événements pour un pod spécifique ?','easy','SINGLE_CHOICE','describe pod montre les événements liés au pod.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','kubectl get events --field-selector involvedObject.name=<pod>',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','kubectl describe pod <pod> (inclut les événements)',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','kubectl get events | grep <pod>',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-05-006') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='troubleshooting' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-05-006',v_cert_id,v_theme_id,'Que signifie le statut ''CrashLoopBackOff'' ?','easy','SINGLE_CHOICE','CrashLoopBackOff indique que le conteneur se termine anormalement à chaque démarrage.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Le conteneur crash en boucle, Kubernetes attend avant de redémarrer',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Le pod est en cours de création',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Le pod est terminé',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Le pod est en attente de ressources',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-05-007') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='troubleshooting' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-05-007',v_cert_id,v_theme_id,'Que signifie le statut ''ImagePullBackOff'' ?','easy','SINGLE_CHOICE','Vérifier le nom de l''image, les credentials, ou la connectivité réseau.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Impossible de tirer l''image du conteneur',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','L''image est introuvable',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Erreur d''authentification',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-05-008') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='troubleshooting' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-05-008',v_cert_id,v_theme_id,'Que signifie le statut ''Pending'' ?','easy','SINGLE_CHOICE','Causes possibles : ressources insuffisantes, nœud non prêt, PVC non lié.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Le pod n''a pas encore été programmé sur un nœud',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Le pod est en cours d''exécution',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Le pod est en train de se terminer',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Le pod a échoué',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-05-009') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='troubleshooting' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-05-009',v_cert_id,v_theme_id,'Comment vérifier l''état d''un nœud ?','easy','SINGLE_CHOICE','get nodes montre l''état, describe donne les détails (conditions).','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','kubectl get nodes',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','kubectl describe node <node>',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','kubectl top node',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A et B',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-05-010') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='troubleshooting' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-05-010',v_cert_id,v_theme_id,'Quelles sont les conditions d''un nœud ?','easy','SINGLE_CHOICE','Les conditions sont des indicateurs de santé du nœud.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Ready, MemoryPressure, DiskPressure, PIDPressure, NetworkUnavailable',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Ready, NotReady, Unknown',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Healthy, Unhealthy',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Up, Down',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-05-011') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='troubleshooting' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-05-011',v_cert_id,v_theme_id,'Comment voir l''utilisation des ressources des pods ?','easy','SINGLE_CHOICE','kubectl top nécessite Metrics Server.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','kubectl top pod',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','kubectl top pod --all-namespaces',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','kubectl top pod --containers',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-05-012') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='troubleshooting' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-05-012',v_cert_id,v_theme_id,'Comment voir l''utilisation des ressources des nœuds ?','easy','SINGLE_CHOICE','top nodes montre CPU et mémoire.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','kubectl top nodes',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','kubectl top node',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','kubectl describe node',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A et B',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-05-013') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='troubleshooting' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-05-013',v_cert_id,v_theme_id,'Comment créer un pod de débogage temporaire ?','easy','SINGLE_CHOICE','kubectl debug (v1.18+) est plus puissant.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','kubectl run debug --image=busybox -it --rm --restart=Never -- /bin/sh',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','kubectl debug pod <pod> -it --image=busybox',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','A et B',TRUE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A seulement',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-05-014') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='troubleshooting' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-05-014',v_cert_id,v_theme_id,'Comment partager le network namespace d''un pod existant ?','easy','SINGLE_CHOICE','kubectl debug avec --target partage le namespace réseau.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','kubectl debug -it <pod> --image=busybox --target=<pod>',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','kubectl run debug --image=busybox --network=container:<pod>',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','kubectl exec -it <pod> -- /bin/sh',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A et B',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-05-015') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='troubleshooting' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-05-015',v_cert_id,v_theme_id,'Comment vérifier si un service fonctionne correctement ?','easy','SINGLE_CHOICE','Les endpoints doivent lister les pods.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','kubectl get endpoints <service>',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','kubectl describe service <service>',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','kubectl exec -it <pod> -- curl http://<service>',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-05-016') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='troubleshooting' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-05-016',v_cert_id,v_theme_id,'Les endpoints d''un service sont vides. Quelle pourrait être la cause ?','easy','SINGLE_CHOICE','Vérifier le selector, les labels des pods, et les readiness probes.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Le sélecteur ne correspond à aucun pod',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Les pods sont dans un autre namespace',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Les pods ne sont pas prêts',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-05-017') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='troubleshooting' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-05-017',v_cert_id,v_theme_id,'Comment tester la résolution DNS depuis un pod ?','easy','SINGLE_CHOICE','Vérifier que le pod utilise le serveur DNS du cluster (kube-dns).','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','kubectl exec -it <pod> -- nslookup kubernetes.default',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','kubectl exec -it <pod> -- cat /etc/resolv.conf',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','kubectl exec -it <pod> -- ping <service>',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-05-018') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='troubleshooting' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-05-018',v_cert_id,v_theme_id,'Quel est le nom DNS du service Kubernetes API ?','easy','SINGLE_CHOICE','Le service kubernetes dans le namespace default.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','kubernetes.default.svc.cluster.local',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','kube-apiserver.default.svc',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','api.default.svc',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','kubernetes.default',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-05-019') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='troubleshooting' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-05-019',v_cert_id,v_theme_id,'Comment vérifier l''expiration des certificats du cluster ?','easy','SINGLE_CHOICE','kubeadm certs check-expiration est la commande pratique.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','kubeadm certs check-expiration',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','openssl x509 -in /etc/kubernetes/pki/apiserver.crt -text -noout',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','kubectl get csr',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A et B',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-05-020') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='troubleshooting' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-05-020',v_cert_id,v_theme_id,'Comment renouveler les certificats avec kubeadm ?','easy','SINGLE_CHOICE','renew all renouvelle tous les certificats.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','kubeadm certs renew all',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','kubeadm upgrade apply',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','kubeadm init --renew-certs',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A et B',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-05-021') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='troubleshooting' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-05-021',v_cert_id,v_theme_id,'Comment vérifier que l''API server fonctionne ?','easy','SINGLE_CHOICE','Le endpoint /healthz retourne OK si l''API server est sain.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','kubectl cluster-info',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','kubectl get --raw /healthz',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','curl -k https://<master>:6443/healthz',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-05-022') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='troubleshooting' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-05-022',v_cert_id,v_theme_id,'Comment savoir pourquoi un pod n''est pas programmé ?','easy','SINGLE_CHOICE','Les événements du pod contiennent le message du scheduler.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','kubectl describe pod <pod> (voir Events)',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','kubectl get events --field-selector involvedObject.name=<pod>',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','kubectl logs kube-scheduler-<node> -n kube-system',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-05-023') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='troubleshooting' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-05-023',v_cert_id,v_theme_id,'Comment vérifier que le controller manager fonctionne ?','easy','SINGLE_CHOICE','Le controller manager expose un healthz.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','kubectl get --raw /healthz/healthz-kube-controller-manager',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','kubectl get pods -n kube-system | grep controller-manager',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','kubectl logs kube-controller-manager-<node> -n kube-system',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-05-024') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='troubleshooting' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-05-024',v_cert_id,v_theme_id,'Comment vérifier l''état du cluster etcd ?','easy','SINGLE_CHOICE','etcdctl endpoint health vérifie la santé.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','ETCDCTL_API=3 etcdctl endpoint health',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','kubectl get pods -n kube-system | grep etcd',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','etcdctl cluster health',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A et B',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-05-025') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='troubleshooting' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-05-025',v_cert_id,v_theme_id,'Comment sauvegarder etcd ?','easy','SINGLE_CHOICE','etcdctl snapshot save est la commande standard.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','ETCDCTL_API=3 etcdctl snapshot save snapshot.db',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','etcdctl backup',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','kubectl backup etcd',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A seulement',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-05-026') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='troubleshooting' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-05-026',v_cert_id,v_theme_id,'Comment vérifier l''état du kubelet sur un nœud ?','easy','SINGLE_CHOICE','Sur le nœud, systemctl et journalctl.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','systemctl status kubelet',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','journalctl -u kubelet -f',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','kubectl get nodes',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A et B',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-05-027') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='troubleshooting' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-05-027',v_cert_id,v_theme_id,'Où sont stockés les logs du kubelet ?','easy','SINGLE_CHOICE','Sur les systèmes systemd, journalctl est la méthode standard.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','/var/log/kubelet.log',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','journalctl -u kubelet',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','/var/log/messages',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A et B',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-05-028') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='troubleshooting' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-05-028',v_cert_id,v_theme_id,'Comment vérifier le container runtime utilisé ?','easy','SINGLE_CHOICE','kubectl get nodes -o wide montre le runtime.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','kubectl get nodes -o wide',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','kubectl describe node | grep Runtime',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','kubectl version --short',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A et B',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-05-029') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='troubleshooting' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-05-029',v_cert_id,v_theme_id,'Comment inspecter les conteneurs avec containerd ?','easy','SINGLE_CHOICE','crictl est l''outil CRI pour interagir avec le runtime.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','crictl ps',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','crictl inspect <container>',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','docker ps (si Docker)',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-05-030') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='troubleshooting' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-05-030',v_cert_id,v_theme_id,'Comment vérifier la connectivité réseau entre deux pods ?','easy','SINGLE_CHOICE','Utiliser ping, curl, ou netcat depuis un pod.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','kubectl exec pod1 -- ping <pod2-ip>',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','kubectl exec pod1 -- curl http://<pod2-ip>:<port>',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','kubectl exec pod1 -- nslookup <service>',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-05-031') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='troubleshooting' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-05-031',v_cert_id,v_theme_id,'Pourquoi une NetworkPolicy peut-elle bloquer le trafic ?','easy','SINGLE_CHOICE','Une fois une NetworkPolicy créée, tout le trafic non autorisé est bloqué.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Par défaut, les policies sont en whitelist (rien n''est autorisé si une policy existe)',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','La policy peut être mal configurée',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Le CNI peut ne pas supporter les policies',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-05-032') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='troubleshooting' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-05-032',v_cert_id,v_theme_id,'Pourquoi un PVC reste-t-il en statut Pending ?','easy','SINGLE_CHOICE','kubectl describe pvc monpvc montre la raison.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Aucun PV disponible',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','La StorageClass n''existe pas',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Le provisionneur dynamique ne fonctionne pas',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-05-033') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='troubleshooting' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-05-033',v_cert_id,v_theme_id,'Comment vérifier qu''un volume est monté correctement ?','easy','SINGLE_CHOICE','Vérifier le point de montage et l''espace disque.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','kubectl exec <pod> -- df -h',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','kubectl exec <pod> -- mount | grep <path>',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','kubectl describe pod <pod> | grep Mounts',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-05-034') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='troubleshooting' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-05-034',v_cert_id,v_theme_id,'Comment vérifier les ResourceQuotas dans un namespace ?','easy','SINGLE_CHOICE','Les ResourceQuotas limitent les ressources dans un namespace.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','kubectl get resourcequota',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','kubectl describe resourcequota',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','kubectl get quota',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-05-035') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='troubleshooting' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-05-035',v_cert_id,v_theme_id,'Que fait un LimitRange ?','easy','SINGLE_CHOICE','LimitRange s''applique au niveau du namespace.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Définit des valeurs par défaut/min/max pour les ressources des conteneurs',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Limite le nombre de pods',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Limite le nombre de services',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Limite le nombre de PVC',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-05-036') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='troubleshooting' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-05-036',v_cert_id,v_theme_id,'Que sont les APF (API Priority and Fairness) ?','easy','SINGLE_CHOICE','APF améliore la stabilité de l''API server sous charge.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Mécanisme pour prioriser les requêtes API',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Protection contre le flooding',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','A et B',TRUE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Uniquement pour les administrateurs',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-05-037') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='troubleshooting' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-05-037',v_cert_id,v_theme_id,'Comment obtenir la sortie en YAML d''une ressource ?','easy','SINGLE_CHOICE','-o yaml ou --output=yaml.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','kubectl get <type> <nom> -o yaml',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','kubectl get <type> <nom> --output=yaml',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','kubectl describe <type> <nom> -o yaml',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A et B',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-05-038') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='troubleshooting' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-05-038',v_cert_id,v_theme_id,'Comment surveiller en temps réel les changements de ressources ?','easy','SINGLE_CHOICE','-w ou --watch surveille les événements.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','kubectl get pods -w',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','kubectl get pods --watch',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','kubectl get pods -o wide -w',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-05-039') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='troubleshooting' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-05-039',v_cert_id,v_theme_id,'Quelle est la différence entre kubectl get et kubectl describe ?','easy','SINGLE_CHOICE','describe est utile pour le dépannage.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','describe montre plus de détails (events, conditions)',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','get montre l''état résumé',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','describe est plus verbeux',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-05-040') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='troubleshooting' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-05-040',v_cert_id,v_theme_id,'Que fait kubectl explain ?','easy','SINGLE_CHOICE','explain est très utile pour écrire des manifests.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Affiche la documentation des champs d''une ressource',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Explique la ressource',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','kubectl explain pod.spec.containers',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-05-041') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='troubleshooting' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-05-041',v_cert_id,v_theme_id,'Comment mettre à jour un champ d''une ressource en ligne de commande ?','easy','SINGLE_CHOICE','patch est utile pour les modifications stratégiques.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','kubectl patch pod monpod -p ''{"spec":{"containers":[{"name":"nginx","image":"nginx:1.20"}]}}''',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','kubectl edit pod monpod',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','kubectl replace -f fichier.yaml',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A et B',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-05-042') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='troubleshooting' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-05-042',v_cert_id,v_theme_id,'Comment changer l''image d''un deployment avec kubectl set ?','easy','SINGLE_CHOICE','set image est pratique pour les mises à jour rapides.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','kubectl set image deployment/mondeploy nginx=nginx:1.20',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','kubectl set image deployment mondeploy nginx=nginx:1.20',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','kubectl set deployment mondeploy image nginx=nginx:1.20',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A et B',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-05-043') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='troubleshooting' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-05-043',v_cert_id,v_theme_id,'Que fait kubectl cordon <node> ?','easy','SINGLE_CHOICE','cordon est utilisé avant maintenance.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Marque le nœud comme non schedulable',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Empêche les nouveaux pods d''être placés sur ce nœud',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','N''affecte pas les pods existants',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-05-044') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='troubleshooting' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-05-044',v_cert_id,v_theme_id,'Que fait kubectl drain <node> ?','easy','SINGLE_CHOICE','drain prépare le nœud pour maintenance.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Évacue tous les pods du nœud',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Marque le nœud comme non schedulable',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Supprime les pods (respecte les PDB)',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-05-045') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='troubleshooting' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-05-045',v_cert_id,v_theme_id,'Comment ajouter une taint à un nœud ?','easy','SINGLE_CHOICE','kubectl taint nodes <node> <key>=<value>:<effect>.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','kubectl taint nodes node1 key=value:NoSchedule',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','kubectl taint node node1 key=value:NoSchedule',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','kubectl taint node1 key=value:NoSchedule',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A et B',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-05-046') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='troubleshooting' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-05-046',v_cert_id,v_theme_id,'kubectl top nécessite-t-il un add-on ?','easy','SINGLE_CHOICE','Metrics Server doit être installé pour kubectl top.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Oui (Metrics Server)',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Uniquement pour les nœuds',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Uniquement pour les pods',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-05-047') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='troubleshooting' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-05-047',v_cert_id,v_theme_id,'Comment activer le profiling sur kube-proxy ?','easy','SINGLE_CHOICE','Le profiling expose des métriques de performance.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','--profiling=true',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','kubectl proxy --profiling',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Modifier le manifeste du pod',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A et C',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-05-048') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='troubleshooting' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-05-048',v_cert_id,v_theme_id,'Où sont configurés les audit logs de l''API server ?','easy','SINGLE_CHOICE','Les audit logs enregistrent les requêtes API.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Fichier de configuration de l''API server (--audit-policy-file)',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','kube-apiserver.yaml',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','kubectl edit configmap',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A et B',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-05-049') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='troubleshooting' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-05-049',v_cert_id,v_theme_id,'Comment ajouter un conteneur de debug temporaire à un pod existant ?','easy','SINGLE_CHOICE','kubectl debug (v1.18+) crée un conteneur éphémère dans le pod.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','kubectl debug -it <pod> --image=busybox',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','kubectl run debug --image=busybox --share-processes=<pod>',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','kubectl exec -it <pod> -- /bin/sh',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A seulement',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-05-050') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='troubleshooting' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-05-050',v_cert_id,v_theme_id,'Les conteneurs éphémères sont-ils persistants après redémarrage du pod ?','easy','SINGLE_CHOICE','Ils sont temporaires et utiles pour le debugging.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Non',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Oui',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Uniquement si spécifié',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Dépend du pod',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-06-001') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-06-001',v_cert_id,v_theme_id,'Quels sont les composants de RBAC ?','easy','SINGLE_CHOICE','RBAC utilise des rôles et des liaisons.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Role, ClusterRole, RoleBinding, ClusterRoleBinding',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','User, Group, ServiceAccount',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Policy, Binding',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A et B',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-06-002') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-06-002',v_cert_id,v_theme_id,'Quelle est la différence entre un Role et un ClusterRole ?','easy','SINGLE_CHOICE','ClusterRole peut être utilisé pour des ressources non-namespace ou lié à un namespace.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Role est namespace-scoped, ClusterRole est cluster-scoped',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Role pour les ressources namespace, ClusterRole pour les ressources cluster',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','A et B',TRUE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Role est plus restrictif',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-06-003') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-06-003',v_cert_id,v_theme_id,'Un ClusterRoleBinding peut-il lier un ClusterRole à des sujets dans un namespace spécifique ?','easy','SINGLE_CHOICE','ClusterRoleBinding s''applique à tout le cluster.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Non (ClusterRoleBinding est cluster-wide)',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Oui, en spécifiant le namespace',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Oui, mais seulement pour les utilisateurs',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Non, utiliser RoleBinding',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-06-004') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-06-004',v_cert_id,v_theme_id,'À quoi sert un ServiceAccount ?','easy','SINGLE_CHOICE','Les pods utilisent le ServiceAccount par défaut de leur namespace.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Identité pour les pods',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Authentification auprès de l''API',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Gérer les permissions',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-06-005') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-06-005',v_cert_id,v_theme_id,'Quel est le ServiceAccount par défaut dans un namespace ?','easy','SINGLE_CHOICE','Chaque namespace a un ServiceAccount nommé ''default''.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','default',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','kubernetes',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','system:default',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A seulement',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-06-006') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-06-006',v_cert_id,v_theme_id,'Comment créer un secret générique (Opaque) ?','easy','SINGLE_CHOICE','Plusieurs sources pour créer un secret.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','kubectl create secret generic monsecret --from-literal=password=123',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','kubectl create secret generic monsecret --from-file=./fichier',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','kubectl create secret generic monsecret --from-env-file=env.txt',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-06-007') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-06-007',v_cert_id,v_theme_id,'Comment monter un secret comme volume dans un pod ?','easy','SINGLE_CHOICE','Déclarer le volume secret puis le monter.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','volumes: - name: monvol secret: secretName: monsecret',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','volumeMounts: - name: monvol mountPath: /etc/secrets',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','A et B',TRUE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A seulement',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-06-008') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-06-008',v_cert_id,v_theme_id,'Les secrets sont-ils chiffrés par défaut dans etcd ?','easy','SINGLE_CHOICE','Par défaut, les secrets sont stockés en base64 (non chiffrés). Il faut activer le chiffrement etcd.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Non',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Oui',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Uniquement si configuré',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Uniquement pour les secrets TLS',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-06-009') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-06-009',v_cert_id,v_theme_id,'Quelle ressource contrôle le trafic réseau entre les pods ?','easy','SINGLE_CHOICE','NetworkPolicy définit des règles de pare-feu.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','NetworkPolicy',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Ingress',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Service',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Endpoint',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-06-010') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-06-010',v_cert_id,v_theme_id,'Quelle ressource a remplacé PodSecurityPolicy ?','easy','SINGLE_CHOICE','PSA est intégré à Kubernetes, d''autres alternatives existent.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Pod Security Admission (PSA)',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','SecurityContext',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','OPA Gatekeeper',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A et C',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-06-011') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-06-011',v_cert_id,v_theme_id,'Quels sont les niveaux de Pod Security Standards ?','easy','SINGLE_CHOICE','Privileged (aucune restriction), Baseline (restrictions minimales), Restricted (strict).','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Privileged, Baseline, Restricted',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','High, Medium, Low',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Secure, Normal, Lax',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Enforce, Audit, Warn',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-06-012') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-06-012',v_cert_id,v_theme_id,'Comment configurer PSA sur un namespace ?','easy','SINGLE_CHOICE','Les labels de namespace contrôlent PSA.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Labels: pod-security.kubernetes.io/enforce: baseline',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Annotations: pod-security.kubernetes.io/enforce: baseline',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','PodSecurityPolicy',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A et B',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-06-013') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-06-013',v_cert_id,v_theme_id,'Comment exécuter un conteneur en tant qu''utilisateur non root ?','easy','SINGLE_CHOICE','runAsNonRoot: true empêche l''exécution en root.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','securityContext: runAsUser: 1000',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','securityContext: runAsNonRoot: true',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','A et B',TRUE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A seulement',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-06-014') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-06-014',v_cert_id,v_theme_id,'Comment empêcher l''escalade de privilèges ?','easy','SINGLE_CHOICE','allowPrivilegeEscalation: false est crucial pour la sécurité.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','securityContext: allowPrivilegeEscalation: false',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','securityContext: privileged: false',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','securityContext: capabilities: drop: [ALL]',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A et C',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-06-015') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-06-015',v_cert_id,v_theme_id,'Comment supprimer toutes les capabilities Linux d''un conteneur ?','easy','SINGLE_CHOICE','Dropping ALL est une bonne pratique.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','securityContext: capabilities: drop: [ALL]',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','securityContext: capabilities: drop: ["ALL"]',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','securityContext: capabilities: add: []',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A et B',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-06-016') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-06-016',v_cert_id,v_theme_id,'Que fait securityContext: readOnlyRootFilesystem: true ?','easy','SINGLE_CHOICE','Les écritures doivent se faire sur des volumes montés.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Monte le système de fichiers racine en lecture seule',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Empêche les écritures dans le conteneur',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Améliore la sécurité',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-06-017') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-06-017',v_cert_id,v_theme_id,'Comment appliquer un profil AppArmor à un pod ?','easy','SINGLE_CHOICE','L''annotation est utilisée (beta).','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','annotations: container.apparmor.security.beta.kubernetes.io/<container>: localhost/<profil>',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','securityContext: apparmor: <profil>',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','A seulement',TRUE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','B seulement',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-06-018') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-06-018',v_cert_id,v_theme_id,'Comment restreindre les appels système avec seccomp ?','easy','SINGLE_CHOICE','RuntimeDefault est le profil par défaut.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','securityContext: seccompProfile: type: RuntimeDefault',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','securityContext: seccompProfile: type: Localhost localhostProfile: profiles/audit.json',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','A et B',TRUE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A seulement',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-06-019') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-06-019',v_cert_id,v_theme_id,'Comment créer un secret TLS pour Ingress ?','easy','SINGLE_CHOICE','create secret tls est la méthode recommandée.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','kubectl create secret tls mon-tls --cert=cert.pem --key=key.pem',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','kubectl create secret generic mon-tls --from-file=tls.crt=cert.pem --from-file=tls.key=key.pem',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','A et B',TRUE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A seulement',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-06-020') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-06-020',v_cert_id,v_theme_id,'Comment configurer un secret pour tirer des images d''un registre privé ?','easy','SINGLE_CHOICE','Créer le secret puis le référencer dans le pod.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','kubectl create secret docker-registry regcred --docker-server=... --docker-username=...',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','imagePullSecrets: - name: regcred',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','A et B',TRUE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A seulement',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-06-021') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-06-021',v_cert_id,v_theme_id,'Comment accéder à l''API depuis un pod avec le ServiceAccount ?','easy','SINGLE_CHOICE','Le token est automatiquement monté si automountServiceAccountToken: true (par défaut).','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Utiliser le token monté dans /var/run/secrets/kubernetes.io/serviceaccount/token',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','kubectl proxy',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','curl -H ''Authorization: Bearer $(cat /var/run/secrets/.../token)'' https://kubernetes.default/api',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A et C',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-06-022') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-06-022',v_cert_id,v_theme_id,'Qu''est-ce qu''un APIService ?','easy','SINGLE_CHOICE','APIService permet d''ajouter des API personnalisées (ex: metrics.k8s.io).','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Enregistrement d''une API étendue',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Service pour l''API server',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Load balancer',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Proxy',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-06-023') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-06-023',v_cert_id,v_theme_id,'Quels sont les modes d''authentification supportés par Kubernetes ?','easy','SINGLE_CHOICE','Plusieurs mécanismes peuvent être activés en même temps.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Client certificates, bearer tokens, OIDC, webhook, etc.',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Seulement client certificates',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Seulement tokens',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Seulement OIDC',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-06-024') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-06-024',v_cert_id,v_theme_id,'Quels sont les modes d''autorisation ?','easy','SINGLE_CHOICE','RBAC est le mode par défaut et recommandé.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','RBAC, ABAC, Webhook, Node',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','RBAC seulement',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','ABAC seulement',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Webhook seulement',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-06-025') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-06-025',v_cert_id,v_theme_id,'À quoi sert le mode Node authorization ?','easy','SINGLE_CHOICE','Node authorization est utilisé par le kubelet pour interagir avec l''API.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Autoriser les kubelets à lire les secrets et pods de leurs nœuds',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Authentifier les utilisateurs',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Gérer les RBAC',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Rien',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-06-026') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-06-026',v_cert_id,v_theme_id,'À quoi servent les admission controllers ?','easy','SINGLE_CHOICE','MutatingAdmissionWebhook et ValidatingAdmissionWebhook sont courants.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Intercepter les requêtes avant persistance',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Valider ou muter les ressources',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','A et B',TRUE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Remplacer RBAC',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-06-027') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-06-027',v_cert_id,v_theme_id,'Que permet OPA Gatekeeper ?','easy','SINGLE_CHOICE','Gatekeeper est un admission controller basé sur OPA.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Politiques de validation avancées (Rego)',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Remplacer RBAC',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Gérer les secrets',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Audit des logs',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-06-028') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-06-028',v_cert_id,v_theme_id,'Comment activer les audit logs ?','easy','SINGLE_CHOICE','Les flags sont dans le manifeste de l''API server.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Spécifier --audit-policy-file et --audit-log-path dans l''API server',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','kubectl enable audit',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','ConfigMap',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A seulement',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-06-029') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-06-029',v_cert_id,v_theme_id,'Comment chiffrer les secrets dans etcd ?','easy','SINGLE_CHOICE','Définir un fichier de configuration et passer le flag à l''API server.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Configuration EncryptionConfiguration',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','--encryption-provider-config',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','A et B',TRUE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A seulement',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-06-030') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-06-030',v_cert_id,v_theme_id,'Où se trouve le fichier kubeconfig par défaut ?','easy','SINGLE_CHOICE','L''utilisateur a ~/.kube/config, l''admin peut avoir /etc/kubernetes/admin.conf.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','$HOME/.kube/config',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','/etc/kubernetes/admin.conf',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','/var/lib/kubelet/kubeconfig',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A et B',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-06-031') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-06-031',v_cert_id,v_theme_id,'Comment ajouter un contexte pour un autre cluster ?','easy','SINGLE_CHOICE','Il faut d''abord définir le cluster et l''utilisateur.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','kubectl config set-context mon-context --cluster=moncluster --user=monuser --namespace=monnamespace',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','kubectl config use-context mon-context',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','kubectl config set-cluster',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A et C',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-06-032') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-06-032',v_cert_id,v_theme_id,'Comment approuver un CSR ?','easy','SINGLE_CHOICE','kubectl certificate approve est la commande.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','kubectl certificate approve <nom-csr>',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','kubectl approve csr <nom>',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','kubectl csr approve <nom>',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A seulement',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-06-033') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-06-033',v_cert_id,v_theme_id,'Comment créer un CSR pour un utilisateur ?','easy','SINGLE_CHOICE','Le CSR est créé manuellement puis soumis à Kubernetes.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Générer une clé privée et une requête CSR, puis kubectl create -f csr.yaml',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','openssl req -new -key user.key -out user.csr',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','A et B',TRUE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A seulement',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-06-034') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-06-034',v_cert_id,v_theme_id,'Comment le kubelet s''authentifie-t-il auprès de l''API server ?','easy','SINGLE_CHOICE','Le kubelet utilise un certificat client par défaut.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Client certificate (kubelet.crt)',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Token',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','ServiceAccount',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A et B',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-06-035') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-06-035',v_cert_id,v_theme_id,'Quel mode d''autorisation utilise le kubelet ?','easy','SINGLE_CHOICE','Le mode Node autorise le kubelet à lire ses propres ressources.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Node authorization',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','RBAC',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','ABAC',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Webhook',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-06-036') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-06-036',v_cert_id,v_theme_id,'Les manifestes des static pods sont stockés où ?','easy','SINGLE_CHOICE','Le kubelet surveille ce répertoire pour les static pods (API server, controller manager, etc.).','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','/etc/kubernetes/manifests',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','/var/lib/kubelet/config',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','/etc/kubernetes/static',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A seulement',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-06-037') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-06-037',v_cert_id,v_theme_id,'Qu''est-ce que le securityContext au niveau du pod vs conteneur ?','easy','SINGLE_CHOICE','Le pod spec peut avoir un securityContext (ex: fsGroup).','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Pod securityContext s''applique à tous les conteneurs, conteneur securityContext est plus spécifique',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Ils se combinent',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','A et B',TRUE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Pod securityContext n''existe pas',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-06-038') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-06-038',v_cert_id,v_theme_id,'Les Windows containers supportent-ils les securityContext ?','easy','SINGLE_CHOICE','Windows a des limitations (ex: pas de runAsNonRoot).','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Partiellement',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Oui complètement',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Non',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Uniquement runAsUser',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-06-039') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-06-039',v_cert_id,v_theme_id,'Un mutating webhook peut-il modifier les ressources avant création ?','easy','SINGLE_CHOICE','Les mutating webhooks peuvent ajouter des sidecars, des labels, etc.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Oui',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Seulement pour les pods',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Seulement pour les services',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-06-040') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-06-040',v_cert_id,v_theme_id,'Un validating webhook peut-il bloquer une ressource ?','easy','SINGLE_CHOICE','Un validating webhook peut rejeter la requête.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Oui',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Seulement avertir',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Uniquement en audit',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-07-001') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='helm___operators' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-07-001',v_cert_id,v_theme_id,'Qu''est-ce que Helm ?','easy','SINGLE_CHOICE','Helm gère les charts (templates Kubernetes).','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Package manager pour Kubernetes',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Orchestrateur',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','CI/CD',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Monitoring',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-07-002') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='helm___operators' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-07-002',v_cert_id,v_theme_id,'Qu''est-ce qu''un chart Helm ?','easy','SINGLE_CHOICE','Un chart est une collection de fichiers décrivant un ensemble de ressources.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Ensemble de templates Kubernetes',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Un package',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Une release',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A et B',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-07-003') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='helm___operators' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-07-003',v_cert_id,v_theme_id,'Quelle commande installe un chart Helm ?','easy','SINGLE_CHOICE','helm install déploie une release.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','helm install <release> <chart>',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','helm install --name <release> <chart>',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','helm create <release>',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A et B',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-07-004') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='helm___operators' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-07-004',v_cert_id,v_theme_id,'Comment lister les releases Helm ?','easy','SINGLE_CHOICE','helm list montre les releases installées.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','helm list',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','helm ls',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','helm status',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A et B',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-07-005') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='helm___operators' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-07-005',v_cert_id,v_theme_id,'Comment mettre à jour une release Helm ?','easy','SINGLE_CHOICE','helm upgrade met à jour la release.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','helm upgrade <release> <chart>',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','helm update <release>',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','helm refresh <release>',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A seulement',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-07-006') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='helm___operators' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-07-006',v_cert_id,v_theme_id,'Comment désinstaller une release Helm ?','easy','SINGLE_CHOICE','uninstall et delete (ancien) suppriment la release.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','helm uninstall <release>',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','helm delete <release>',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','helm remove <release>',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A et B',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-07-007') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='helm___operators' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-07-007',v_cert_id,v_theme_id,'Comment passer des valeurs personnalisées à Helm ?','easy','SINGLE_CHOICE','--set pour les valeurs simples, -f pour un fichier.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','--set key=value',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','-f values.yaml',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','--values values.yaml',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-07-008') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='helm___operators' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-07-008',v_cert_id,v_theme_id,'Où sont stockées les releases Helm ?','easy','SINGLE_CHOICE','Helm v3 stocke les releases dans des secrets (plus sécurisé).','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Secrets dans le namespace du release',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','ConfigMaps (ancien)',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','A et B',TRUE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Dans etcd',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-07-009') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='helm___operators' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-07-009',v_cert_id,v_theme_id,'Comment créer un nouveau chart Helm ?','easy','SINGLE_CHOICE','helm create génère un squelette de chart.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','helm create monchart',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','helm init monchart',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','helm new monchart',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A seulement',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-07-010') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='helm___operators' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-07-010',v_cert_id,v_theme_id,'Quelle commande valide un chart Helm ?','easy','SINGLE_CHOICE','lint vérifie la syntaxe, template génère les manifests.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','helm lint',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','helm template --debug',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','helm install --dry-run',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-07-011') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='helm___operators' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-07-011',v_cert_id,v_theme_id,'Comment ajouter un dépôt Helm ?','easy','SINGLE_CHOICE','repo add ajoute, repo update rafraîchit l''index.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','helm repo add <nom> <url>',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','helm repo update',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','helm repo list',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A et B',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-07-012') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='helm___operators' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-07-012',v_cert_id,v_theme_id,'Comment rechercher un chart dans les dépôts ?','easy','SINGLE_CHOICE','search hub pour Artifact Hub, search repo pour les dépôts configurés.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','helm search hub <terme>',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','helm search repo <terme>',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','helm search <terme>',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A et B',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-07-013') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='helm___operators' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-07-013',v_cert_id,v_theme_id,'Qu''est-ce qu''un repository Helm ?','easy','SINGLE_CHOICE','Les dépôts HTTP ou OCI stockent les charts.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Serveur d''index de charts',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Registry OCI',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','A et B',TRUE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Un registre Docker',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-07-014') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='helm___operators' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-07-014',v_cert_id,v_theme_id,'Qu''est-ce que le templating dans Helm ?','easy','SINGLE_CHOICE','Les templates utilisent des fonctions, des pipelines, des conditions.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Utilisation de Go templates pour générer les manifests',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Langage de template',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','A et B',TRUE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Remplacer les valeurs',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-07-015') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='helm___operators' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-07-015',v_cert_id,v_theme_id,'Comment accéder à une valeur de .Values dans un template ?','easy','SINGLE_CHOICE','La syntaxe Go template utilise {{ .Values.key }}.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','{{ .Values.key }}',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','{{ .Values.key }}',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','${Values.key}',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A et B',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-07-016') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='helm___operators' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-07-016',v_cert_id,v_theme_id,'Qu''est-ce que la fonction ''include'' dans Helm ?','easy','SINGLE_CHOICE','include permet de réutiliser des blocs de template.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Inclure un autre template',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Importer un fichier',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','A et B',TRUE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Remplacer',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-07-017') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='helm___operators' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-07-017',v_cert_id,v_theme_id,'Que fait l''instruction ''tpl'' dans Helm ?','easy','SINGLE_CHOICE','tpl permet d''interpréter une chaîne contenant des directives de template.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Évalue une chaîne comme un template',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Crée un template',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Charge un fichier',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A seulement',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-07-018') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='helm___operators' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-07-018',v_cert_id,v_theme_id,'Comment définir des valeurs par défaut dans un chart ?','easy','SINGLE_CHOICE','values.yaml contient les valeurs par défaut.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','values.yaml',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','requirements.yaml',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Chart.yaml',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A seulement',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-07-019') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='helm___operators' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-07-019',v_cert_id,v_theme_id,'Quel fichier contient les métadonnées du chart (nom, version) ?','easy','SINGLE_CHOICE','Chart.yaml est obligatoire.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Chart.yaml',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','values.yaml',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','requirements.yaml',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','metadata.yaml',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-07-020') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='helm___operators' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-07-020',v_cert_id,v_theme_id,'Qu''est-ce qu''un Operator Kubernetes ?','easy','SINGLE_CHOICE','Les Operators automatisent les opérations (backup, upgrade, scaling).','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Extension pour gérer des applications complexes (état)',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Controller personnalisé',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Utilise des Custom Resources (CRD)',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-07-021') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='helm___operators' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-07-021',v_cert_id,v_theme_id,'Quel outil permet de créer des Operators ?','easy','SINGLE_CHOICE','Operator SDK et Kubebuilder sont les plus courants.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Operator SDK',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Kubebuilder',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Metacontroller',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-07-022') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='helm___operators' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-07-022',v_cert_id,v_theme_id,'Qu''est-ce qu''un Custom Resource Definition (CRD) ?','easy','SINGLE_CHOICE','Les CRD permettent de créer des ressources personnalisées.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Définition d''une nouvelle ressource Kubernetes',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Extension de l''API',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','A et B',TRUE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Type de secret',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-07-023') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='helm___operators' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-07-023',v_cert_id,v_theme_id,'Comment créer un CRD ?','easy','SINGLE_CHOICE','kubectl create -f crd.yaml.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Fichier YAML avec kind: CustomResourceDefinition',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','kubectl create crd',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','A et B',TRUE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A seulement',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-07-024') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='helm___operators' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-07-024',v_cert_id,v_theme_id,'Qu''est-ce que le contrôleur d''un Operator ?','easy','SINGLE_CHOICE','Le contrôleur est le cœur de l''Operator.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Boucle qui surveille les ressources personnalisées',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Réconcilie l''état désiré avec l''état actuel',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','A et B',TRUE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Un pod',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-07-025') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='helm___operators' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-07-025',v_cert_id,v_theme_id,'Où s''exécute généralement un Operator ?','easy','SINGLE_CHOICE','L''Operator s''exécute comme un pod dans le cluster.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Dans un pod du cluster',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Hors cluster',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Sur chaque nœud',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A seulement',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-07-026') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='helm___operators' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-07-026',v_cert_id,v_theme_id,'Quel est l''avantage d''un Operator par rapport à Helm ?','easy','SINGLE_CHOICE','Helm est pour le déploiement, Operator pour la gestion du cycle de vie.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Gère l''état (reconciliation)',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Peut effectuer des actions automatisées (backup, upgrade)',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Plus adapté aux applications stateful',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-07-027') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='helm___operators' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-07-027',v_cert_id,v_theme_id,'Qu''est-ce que Operator Lifecycle Manager (OLM) ?','easy','SINGLE_CHOICE','OLM est un composant de Operator Framework.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Gestionnaire d''Operators',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Installe et met à jour les Operators',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','A et B',TRUE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Un registry',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-07-028') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='helm___operators' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-07-028',v_cert_id,v_theme_id,'Qu''est-ce qu''un CatalogSource dans OLM ?','easy','SINGLE_CHOICE','CatalogSource pointe vers un registry contenant les Operators.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Source de bundles d''Operators',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Dépôt d''Operators',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','A et B',TRUE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','CRD',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-07-029') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='helm___operators' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-07-029',v_cert_id,v_theme_id,'Peut-on combiner Helm et Operator ?','easy','SINGLE_CHOICE','Beaucoup d''Operators sont distribués sous forme de Helm charts.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Oui (ex: Helm chart pour déployer l''Operator)',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Uniquement avec OLM',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Uniquement avec Operator SDK',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='CKA-07-030') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='helm___operators' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'CKA-07-030',v_cert_id,v_theme_id,'Quelle commande génère les manifests sans installer ?','easy','SINGLE_CHOICE','template et install --dry-run produisent les YAML.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','helm template <release> <chart>',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','helm install --dry-run <release> <chart>',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','helm lint',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A et B',TRUE,3);
    END IF;
END $$;
-- ── KOTLIN (289 questions) ──────
DO $$
DECLARE
    v_cert_id TEXT := 'kotlin';
    v_theme_id UUID; v_q_id UUID; v_opt_id UUID;
BEGIN
    IF NOT EXISTS (SELECT 1 FROM certifications WHERE id = v_cert_id) THEN
        RAISE NOTICE 'Certification % absente', v_cert_id; RETURN;
    END IF;
    INSERT INTO certification_themes (id, certification_id, code, label, question_count, display_order)
    VALUES (uuid_generate_v4(), v_cert_id, 'null_safety', 'Null Safety', 0, 0)
    ON CONFLICT (certification_id, code) DO NOTHING;
    INSERT INTO certification_themes (id, certification_id, code, label, question_count, display_order)
    VALUES (uuid_generate_v4(), v_cert_id, 'coroutines', 'Coroutines', 0, 0)
    ON CONFLICT (certification_id, code) DO NOTHING;
    INSERT INTO certification_themes (id, certification_id, code, label, question_count, display_order)
    VALUES (uuid_generate_v4(), v_cert_id, 'functional_programming', 'Functional Programming', 0, 0)
    ON CONFLICT (certification_id, code) DO NOTHING;
    INSERT INTO certification_themes (id, certification_id, code, label, question_count, display_order)
    VALUES (uuid_generate_v4(), v_cert_id, 'object_oriented', 'Object-oriented', 0, 0)
    ON CONFLICT (certification_id, code) DO NOTHING;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-NS-001') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='null_safety' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-NS-001',v_cert_id,v_theme_id,'Comment déclarer une variable nullable ?','easy','SINGLE_CHOICE','Le ? après le type indique la nullabilité.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','var name: String? = null',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','var name: String = null',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','var name: String? = ""',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','var name: String = ""',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-NS-002') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='null_safety' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-NS-002',v_cert_id,v_theme_id,'Quelle est la superclasse de tous les types nullables ?','easy','SINGLE_CHOICE','Any? est le supertype de tous les types nullables.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Any?',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Any',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Nothing?',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Unit?',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-NS-003') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='null_safety' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-NS-003',v_cert_id,v_theme_id,'String? est un sous-type de String ?','easy','SINGLE_CHOICE','Nullable n''est pas sous-type de non-nullable.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Non',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Oui',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Oui avec conversion',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Dépend du contexte',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-NS-004') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='null_safety' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-NS-004',v_cert_id,v_theme_id,'Que retourne str?.length si str est null ?','easy','SINGLE_CHOICE','L''appel sécurisé retourne null.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','null',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','0',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Exception',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Unit',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-NS-005') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='null_safety' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-NS-005',v_cert_id,v_theme_id,'Que produit str?.length ?: 0 si str est null ?','medium','SINGLE_CHOICE','Elvis fournit une valeur par défaut.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','0',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','null',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Exception',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Unit',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-NS-006') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='null_safety' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-NS-006',v_cert_id,v_theme_id,'Que fait person?.address?.city ?','medium','SINGLE_CHOICE','Chaînage sécurisé : s''arrête au premier null.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Accès sécurisé chaîné',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Accès direct',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Lance NPE',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Retourne null si un maillon est null',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-NS-007') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='null_safety' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-NS-007',v_cert_id,v_theme_id,'L''opérateur Elvis peut-il lancer une exception ?','easy','SINGLE_CHOICE','Elvis peut lancer une exception : ?: throw Exception()','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Oui, throw Exception()',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Oui, mais seulement IllegalArgumentException',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Oui, mais seulement NPE',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-NS-008') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='null_safety' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-NS-008',v_cert_id,v_theme_id,'Elvis est-il associatif à droite ?','hard','SINGLE_CHOICE','a ?: b ?: c est équivalent à a ?: (b ?: c)','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Oui',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Associatif à gauche',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Ne s''applique pas',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-NS-009') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='null_safety' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-NS-009',v_cert_id,v_theme_id,'Que se passe-t-il avec str!!.length si str est null ?','easy','SINGLE_CHOICE','L''opérateur !! force la non-nullité et lance NPE.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','NullPointerException',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Retourne 0',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Ignore',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Erreur compilation',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-NS-010') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='null_safety' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-NS-010',v_cert_id,v_theme_id,'Peut-on enchaîner !! ?','hard','SINGLE_CHOICE','On peut chaîner !! mais dangereux.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Oui, person!!.address!!.city',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Oui mais déconseillé',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Uniquement avec ?',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-NS-011') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='null_safety' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-NS-011',v_cert_id,v_theme_id,'Dans if (str != null) { str.length } le smart cast fonctionne-t-il ?','medium','SINGLE_CHOICE','Smart cast après vérification de null.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Oui',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Oui uniquement avec val',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Oui uniquement avec var',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-NS-012') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='null_safety' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-NS-012',v_cert_id,v_theme_id,'Smart cast fonctionne-t-il avec var ?','hard','SINGLE_CHOICE','Pour var, smart cast possible si pas de modification potentielle.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Oui, si non modifiée entre temps',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Oui toujours',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Uniquement dans les conditions',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-NS-013') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='null_safety' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-NS-013',v_cert_id,v_theme_id,'lateinit var peut-elle être nullable ?','medium','SINGLE_CHOICE','lateinit ne supporte pas les types nullables.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Non',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Oui',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Oui avec ?',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Oui avec null',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-NS-014') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='null_safety' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-NS-014',v_cert_id,v_theme_id,'Comment vérifier si une propriété lateinit est initialisée ?','hard','SINGLE_CHOICE','::name.isInitialized (depuis Kotlin 1.2).','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','::property.isInitialized',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','property == null',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','property != null',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','isInitialized(property)',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-NS-015') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='null_safety' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-NS-015',v_cert_id,v_theme_id,'Peut-on utiliser lateinit avec des types primitifs ?','hard','SINGLE_CHOICE','lateinit ne supporte pas les types primitifs.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Non',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Oui',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Oui avec Int?',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Oui avec Int',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-NS-016') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='null_safety' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-NS-016',v_cert_id,v_theme_id,'Que sont les platform types ?','hard','SINGLE_CHOICE','Les types Java sont des platform types (String!).','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Types venant de Java, nullabilité inconnue',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Types Kotlin',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Types primitifs',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Types génériques',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-NS-017') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='null_safety' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-NS-017',v_cert_id,v_theme_id,'Peut-on déclarer un platform type en Kotlin ?','hard','SINGLE_CHOICE','Les platform types sont uniquement inférés depuis Java.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Non, seulement via Java',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Oui, avec !',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Oui, avec ?',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Oui, avec nothing',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-NS-018') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='null_safety' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-NS-018',v_cert_id,v_theme_id,'Quelles annotations Java sont reconnues par Kotlin ?','hard','SINGLE_CHOICE','Kotlin comprend les annotations de nullabilité.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','@Nullable, @NotNull, @NonNull',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','@Null, @NonNull',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','@Nullable seulement',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Aucune',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-NS-019') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='null_safety' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-NS-019',v_cert_id,v_theme_id,'Kotlin a-t-il ses propres annotations de nullabilité ?','hard','SINGLE_CHOICE','kotlin.annotations.jvm','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Oui, @Nullable et @NotNull',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Oui, @Null et @NonNull',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Oui, @NullableString',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-NS-020') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='null_safety' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-NS-020',v_cert_id,v_theme_id,'Que fait requireNotNull ?','hard','SINGLE_CHOICE','requireNotNull(value) { message }','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Retourne la valeur non-null ou lève IllegalArgumentException',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Retourne null',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Lance NPE',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Ignore null',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-NS-021') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='null_safety' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-NS-021',v_cert_id,v_theme_id,'Différence entre requireNotNull et checkNotNull ?','hard','SINGLE_CHOICE','require = IllegalArgumentException, check = IllegalStateException.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','checkNotNull lève IllegalStateException',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','checkNotNull lève IllegalArgumentException',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Identiques',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','checkNotNull retourne null',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-NS-022') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='null_safety' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-NS-022',v_cert_id,v_theme_id,'Que fait l''opérateur as? ?','hard','SINGLE_CHOICE','as? évite ClassCastException.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Cast sécurisé, retourne null si échec',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Cast forcé',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Cast générique',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Cast nullable',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-NS-023') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='null_safety' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-NS-023',v_cert_id,v_theme_id,'Quel est le type de retour de as? ?','hard','SINGLE_CHOICE','as? retourne un nullable du type cible.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Type cible?',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Type cible',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Any?',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Unit?',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-NS-024') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='null_safety' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-NS-024',v_cert_id,v_theme_id,'Que fait .filterNotNull() sur une collection ?','hard','SINGLE_CHOICE','Retourne une liste sans éléments null.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Supprime les éléments null',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Garde les null',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Convertit les null',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Ignore',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-NS-025') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='null_safety' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-NS-025',v_cert_id,v_theme_id,'Que fait mapNotNull ?','hard','SINGLE_CHOICE','mapNotNull { transform } combine map et filterNotNull.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Map puis filtre les null',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Map seulement',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Filter seulement',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Map et flatMap',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-NS-026') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='null_safety' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-NS-026',v_cert_id,v_theme_id,'List<String> peut-elle contenir null ?','hard','SINGLE_CHOICE','List<String> ne peut pas contenir null.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Non',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Oui',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Oui avec List<String?>',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Dépend',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-NS-027') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='null_safety' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-NS-027',v_cert_id,v_theme_id,'Comment autoriser null dans une collection ?','hard','SINGLE_CHOICE','Utiliser le type nullable du paramètre.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','List<String?>',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','List<String>',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','List<Any?>',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A et C',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-NS-028') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='null_safety' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-NS-028',v_cert_id,v_theme_id,'Quel est l''équivalent de str?.let { it.length } ?','hard','SINGLE_CHOICE','let s''exécute seulement si non null.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','if (str != null) str.length else null',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','str!!.length',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','str?.length',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','str?.length ?: 0',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-NS-029') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='null_safety' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-NS-029',v_cert_id,v_theme_id,'Que fait str?.run { length } ?','hard','SINGLE_CHOICE','run n''est appelé que si str non null.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Exécute run si non null',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Exécute toujours',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Lance NPE',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Retourne null',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-NS-030') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='null_safety' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-NS-030',v_cert_id,v_theme_id,'Que retourne str?.apply { } ?','hard','SINGLE_CHOICE','apply retourne le récepteur, donc str ou null.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','str si non null, sinon null',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Résultat du lambda',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Unit',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Rien',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-NS-031') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='null_safety' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-NS-031',v_cert_id,v_theme_id,'Comment déclarer une API Java comme nullable ?','hard','SINGLE_CHOICE','L''annotation @Nullable indique la nullabilité.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','@Nullable',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','@Null',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','@NullableApi',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Aucune',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-NS-032') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='null_safety' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-NS-032',v_cert_id,v_theme_id,'Sans annotation, un type Java devient ?','hard','SINGLE_CHOICE','Les types Java non annotés sont des platform types.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Platform type',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Nullable',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Non-nullable',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Any',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-NS-033') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='null_safety' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-NS-033',v_cert_id,v_theme_id,'Peut-on supprimer les platform types ?','hard','SINGLE_CHOICE','Des flags du compilateur peuvent améliorer la nullabilité.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Oui avec -Xtype-enhancement-improvements',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Oui avec annotation',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Uniquement en Java',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-NS-034') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='null_safety' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-NS-034',v_cert_id,v_theme_id,'Nothing? est un sous-type de ?','hard','SINGLE_CHOICE','Nothing? est le sous-type des types nullables.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Tous les types nullables',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Tous les types',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Nothing',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Any',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-NS-035') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='null_safety' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-NS-035',v_cert_id,v_theme_id,'Quelle est la valeur de Nothing? ?','hard','SINGLE_CHOICE','Nothing? a une seule valeur : null.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','null',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Nothing',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Unit',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Aucune',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-NS-036') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='null_safety' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-NS-036',v_cert_id,v_theme_id,'Peut-on appeler une fonction d''extension sur un nullable ?','hard','SINGLE_CHOICE','fun String?.isNullOrBlank(): Boolean','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Oui, définir sur T?',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Oui, avec @Nullable',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Uniquement pour les primitifs',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-NS-037') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='null_safety' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-NS-037',v_cert_id,v_theme_id,'Que vaut null.isNullOrBlank() ?','hard','SINGLE_CHOICE','null.isNullOrBlank() retourne true.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','true',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','false',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','null',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Exception',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-NS-038') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='null_safety' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-NS-038',v_cert_id,v_theme_id,'Que permet kotlin.contracts ?','hard','SINGLE_CHOICE','Contracts améliore l''analyse de nullabilité.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Informe le compilateur sur le comportement',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Créer des contrats',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Optimiser',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-NS-039') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='null_safety' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-NS-039',v_cert_id,v_theme_id,'Que déclare contract { returns() implies (value != null) } ?','hard','SINGLE_CHOICE','Le contract informe que la fonction garantit la non-nullité.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Si fonction retourne, valeur non nulle',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Si valeur non nulle, fonction retourne',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Toujours vrai',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Toujours faux',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-NS-040') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='null_safety' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-NS-040',v_cert_id,v_theme_id,'Quand utiliser @UnsafeVariance ?','hard','SINGLE_CHOICE','Utilisé pour les types invariants.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Forcer la variance contraire à la déclaration',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Rendre safe',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Éviter les warnings',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Optimiser',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-NS-041') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='null_safety' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-NS-041',v_cert_id,v_theme_id,'T dans une classe générique est-il nullable ?','hard','SINGLE_CHOICE','T est nullable par défaut (équivalent à T?).','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Oui, par défaut',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Oui, avec T?',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Dépend',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-NS-042') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='null_safety' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-NS-042',v_cert_id,v_theme_id,'Comment rendre T non-nullable ?','hard','SINGLE_CHOICE','T & Any ou <T : Any> pour borne supérieure non-nullable.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','T & Any',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','T?',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','T!!',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','T: Any',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-NS-043') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='null_safety' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-NS-043',v_cert_id,v_theme_id,'Le compilateur peut-il inférer non-null pour les paramètres ?','hard','SINGLE_CHOICE','Inférence de non-null pour les paramètres dans certaines conditions.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Oui, depuis Kotlin 1.3',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Oui, avec annotation',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Uniquement pour les retours',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-NS-044') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='null_safety' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-NS-044',v_cert_id,v_theme_id,'Dans une data class, les composants peuvent-ils être nullables ?','hard','SINGLE_CHOICE','Les data classes acceptent des propriétés nullables.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Oui',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Oui, avec ?',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Oui, avec lateinit',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-NS-045') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='null_safety' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-NS-045',v_cert_id,v_theme_id,'Que fait obj?.let { } ?: run { } ?','hard','SINGLE_CHOICE','Combinaison de safe call et Elvis.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Exécute let si non null, sinon run',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Exécute toujours let',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Exécute toujours run',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Erreur',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-NS-046') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='null_safety' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-NS-046',v_cert_id,v_theme_id,'Que retourne a?.b?.c?.d ?','hard','SINGLE_CHOICE','Chaînage sécurisé : s''arrête au premier null.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','null si un maillon est null',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','d toujours',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Exception',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Unit',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-NS-047') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='null_safety' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-NS-047',v_cert_id,v_theme_id,'Que fait str?.length ?: throw IllegalArgumentException() ?','hard','SINGLE_CHOICE','Elvis peut lancer une exception personnalisée.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Lance exception si str est null',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Retourne 0',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Retourne null',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Lance NPE',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-NS-048') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='null_safety' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-NS-048',v_cert_id,v_theme_id,'Quand préférer lateinit à nullable ?','hard','SINGLE_CHOICE','lateinit évite les vérifications de null inutiles.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Quand la valeur sera définie avant usage',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Toujours',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Jamais',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Pour les primitifs',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-NS-049') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='null_safety' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-NS-049',v_cert_id,v_theme_id,'Peut-on utiliser when pour les nullables ?','hard','SINGLE_CHOICE','when (nullable) { null -> ... else -> ... }','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Oui, case null',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Oui, avec when (value == null)',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Oui, avec when { null -> }',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-NS-050') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='null_safety' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-NS-050',v_cert_id,v_theme_id,'Que fait when (value) { is String -> ... else -> ... } si value est null ?','hard','SINGLE_CHOICE','null ne passe pas is String, va dans else.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Va dans else',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Va dans is String',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Lance NPE',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Erreur compilation',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-NS-051') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='null_safety' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-NS-051',v_cert_id,v_theme_id,'Que fait for (item in nullableList ?: emptyList()) ?','hard','SINGLE_CHOICE','Elvis fournit une liste vide si null.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Itère sur emptyList si null',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Itère sur nullableList si non null',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','A et B',TRUE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Erreur',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-NS-052') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='null_safety' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-NS-052',v_cert_id,v_theme_id,'Comment définir une extension pour nullable ?','hard','SINGLE_CHOICE','Le récepteur nullable permet l''extension.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','fun String?.myExtension() { }',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','fun String.myExtension() { }',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','fun myExtension(String?) { }',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','fun String? = ...',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-NS-053') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='null_safety' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-NS-053',v_cert_id,v_theme_id,'Que retourne nullableArray?.get(0) ?: -1 ?','hard','SINGLE_CHOICE','Le safe call échoue si tableau null, l''index peut être invalide.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','-1 si nullableArray null ou array vide',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','-1 seulement si null',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','null',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Exception',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-NS-054') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='null_safety' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-NS-054',v_cert_id,v_theme_id,'requireNotNull(value) { "message" } lance quelle exception ?','hard','SINGLE_CHOICE','requireNotNull lève IllegalArgumentException.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','IllegalArgumentException',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','IllegalStateException',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','NullPointerException',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','RuntimeException',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-NS-055') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='null_safety' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-NS-055',v_cert_id,v_theme_id,'checkNotNull(value) { "message" } lance quelle exception ?','hard','SINGLE_CHOICE','checkNotNull lève IllegalStateException.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','IllegalStateException',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','IllegalArgumentException',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','NullPointerException',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','RuntimeException',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-NS-056') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='null_safety' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-NS-056',v_cert_id,v_theme_id,'!! est-il plus performant que ?. ?','hard','SINGLE_CHOICE','!! n''ajoute pas de vérification dans le bytecode.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Oui, pas de vérification',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Non, plus lent',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Identique',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Dépend',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-NS-057') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='null_safety' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-NS-057',v_cert_id,v_theme_id,'Pourquoi le smart cast peut échouer sur var ?','hard','SINGLE_CHOICE','Entre la vérification et l''utilisation, la var peut changer.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','La variable peut être modifiée',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Le type n''est pas connu',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Le compilateur ne supporte pas',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Uniquement pour les val',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-NS-058') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='null_safety' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-NS-058',v_cert_id,v_theme_id,'Comment forcer le smart cast sur var ?','hard','SINGLE_CHOICE','Copier dans une val locale pour smart cast.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','val local = var',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','var as? Type',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','var!!',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Impossible',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-NS-059') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='null_safety' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-NS-059',v_cert_id,v_theme_id,'arrayOfNulls<String>(5) crée un tableau de ?','hard','SINGLE_CHOICE','arrayOfNulls retourne un tableau d''éléments nullables.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','String?',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','String',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Any',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Nothing',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-NS-060') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='null_safety' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-NS-060',v_cert_id,v_theme_id,'mapOf("a" to null) est-il autorisé ?','hard','SINGLE_CHOICE','Le type de la map doit être V? pour accepter null.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Oui, si le type de valeur est nullable',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Oui, toujours',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Non, car null n''est pas autorisé',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-NS-061') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='null_safety' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-NS-061',v_cert_id,v_theme_id,'Sélectionnez TOUTES les affirmations correctes concernant l''opérateur de safe call (?.) en Kotlin :','medium','SINGLE_CHOICE','L''opérateur de safe call (?.) est utilisé pour éviter les NullPointerException en Kotlin. Il peut être appliqué à des méthodes et des propriétés, et retourne null si l''objet est null. Cependant, il ne modifie pas le type de l''objet à non-nullable.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Permet d''éviter les NullPointerException',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Peut être utilisé avec des méthodes et des propriétés',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Retourne null si l''objet est null, sinon appelle la méthode/propriété',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Modifie le type de l''objet à non-nullable',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-NS-063') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='null_safety' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-NS-063',v_cert_id,v_theme_id,'Quelles sont les deux affirmations vraies concernant l''utilisation de lateinit en Kotlin ?','medium','SINGLE_CHOICE','lateinit ne peut pas être utilisé avec des types primitifs et doit être initialisé avant d''être utilisé. Il ne peut pas être utilisé avec des propriétés val, mais permet de déclarer une propriété non-nullable sans initialisation immédiate.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Peut être utilisé avec des types primitifs',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Doit être initialisé avant d''être utilisé',TRUE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Peut être utilisé avec des propriétés val',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Permet de déclarer une propriété non-nullable sans initialisation immédiate',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-NS-064') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='null_safety' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-NS-064',v_cert_id,v_theme_id,'Quelle est la condition requise pour que Kotlin effectue un smart cast sur une variable nullable ?','hard','SINGLE_CHOICE','Pour que Kotlin effectue un smart cast sur une variable nullable, le compilateur doit déterminer que la variable ne peut pas être null dans un bloc de code spécifique. Cela se produit généralement après une vérification non-null.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','La variable doit être déclarée comme non-nullable',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','La variable doit être initialisée avec une valeur non-null',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Le compilateur doit déterminer que la variable ne peut pas être null dans un bloc de code',TRUE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','La variable doit être mutable',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-NS-065') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='null_safety' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-NS-065',v_cert_id,v_theme_id,'Quelles sont les deux affirmations vraies concernant les types plateformes en Kotlin ?','easy','SINGLE_CHOICE','Les types plateformes en Kotlin sont utilisés pour interagir avec des bibliothèques Java. Ils peuvent être nulls même si non-nullable dans Kotlin, ce qui permet une meilleure intégration avec le code Java existant. Ils ne sont pas déclarés avec un suffixe ''?'' et n''ont pas de méthodes spécifiques à la plateforme.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Sont utilisés pour interagir avec des bibliothèques Java',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Peuvent être nulls même si non-nullable dans Kotlin',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Sont déclarés avec le suffixe ''?''',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Permettent l''utilisation de méthodes spécifiques à la plateforme',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-NS-065') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='null_safety' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-NS-065',v_cert_id,v_theme_id,'Sélectionnez TOUTES les affirmations correctes concernant l''opérateur de safe call (?.) :','medium','SINGLE_CHOICE','L''opérateur de safe call permet d''éviter les exceptions NullPointerException en retournant null si l''objet est null (Option A et D sont correctes). Il peut être utilisé avec des méthodes et des propriétés (Option B est correcte). Cependant, il peut être utilisé avec les fonctions (Option C est incorrecte).','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Permet d''éviter les exceptions NullPointerException',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Peut être utilisé avec des méthodes et des propriétés',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','N''est pas utilisable avec les fonctions',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Retourne null si l''objet est null',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-NS-066') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='null_safety' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-NS-066',v_cert_id,v_theme_id,'Quelle est l''utilité principale de l''opérateur Elvis (?:) ?','easy','SINGLE_CHOICE','L''opérateur Elvis permet de définir une valeur par défaut si la variable est null (Option A est correcte). Les autres options ne sont pas correctes.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Permet de définir une valeur par défaut si la variable est null',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Effectue un cast sécurisé entre types',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Permet de faire des appels sûrs à des méthodes',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Affiche un message d''erreur si la variable est null',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-NS-067') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='null_safety' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-NS-067',v_cert_id,v_theme_id,'Quelles sont les DEUX affirmations vraies concernant le mot-clé lateinit ?','hard','SINGLE_CHOICE','Le mot-clé lateinit permet de déclarer des propriétés non-nullables sans initialisation immédiate (Option C est correcte). Il peut être utilisé avec des propriétés val (Option D est correcte). Les autres options ne sont pas correctes.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Peut être utilisé avec des types primitifs',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Nécessite l''initialisation avant utilisation',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Permet de déclarer des propriétés non-nullables sans initialisation immédiate',TRUE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Peut être utilisé avec des propriétés val',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-NS-068') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='null_safety' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-NS-068',v_cert_id,v_theme_id,'Quelle est la condition pour que Kotlin effectue un smart cast ?','medium','SINGLE_CHOICE','Kotlin effectue un smart cast lorsqu''une variable est vérifiée avec is et utilisée dans un bloc if (Option A est correcte). Les autres options ne sont pas correctes.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Lorsqu''une variable est vérifiée avec is et utilisée dans un bloc if',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Lorsqu''une variable est assignée à une autre variable non-null',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Lorsqu''une variable est déclarée comme lateinit',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Lorsqu''une variable est utilisée dans une boucle',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-NS-069') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='null_safety' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-NS-069',v_cert_id,v_theme_id,'Quelles sont les DEUX affirmations vraies concernant les types de plateforme (platform types) ?','hard','SINGLE_CHOICE','Les types de plateforme sont utilisés pour interagir avec du code Java non-nullable (Option A est correcte). Ils permettent d''éviter les vérifications de nullité (Option D est correcte). Les autres options ne sont pas correctes.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Sont utilisés pour interagir avec du code Java non-nullable',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Peuvent être convertis en types nullable Kotlin sans problème',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Sont représentés avec un suffixe ''?'' dans la signature de méthode Java',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Permettent d''éviter les vérifications de nullité',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-NS-070') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='null_safety' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-NS-070',v_cert_id,v_theme_id,'Sélectionnez TOUTES les affirmations correctes concernant le type nullable :','medium','SINGLE_CHOICE','Option A est correcte car un type nullable en Kotlin est déclaré avec un signe de point d''interrogation après le type. Option B est correcte car une variable nullable peut être affectée à null. Option C est incorrecte car tous les types en Kotlin ne sont pas non-nullables par défaut, ils peuvent être déclarés comme nullable. Option D est incorrecte car une variable nullable nécessite une conversion explicite pour être utilisée dans des opérations arithmétiques.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Un type nullable peut être déclaré avec un signe de point d''interrogation après le type',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Un type nullable peut être affecté à null',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Tous les types en Kotlin sont non-nullables par défaut',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Un type nullable peut être utilisé dans des opérations arithmétiques sans conversion',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-NS-071') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='null_safety' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-NS-071',v_cert_id,v_theme_id,'Quelle est la syntaxe correcte pour une safe call en Kotlin ?','easy','SINGLE_CHOICE','Option A est correcte car la syntaxe pour une safe call en Kotlin utilise le point d''interrogation après la variable. Option B est incorrecte car le point d''interrogation ne peut pas être placé après la propriété. Option C est incorrecte car le double point d''exclamation n''est pas utilisé pour les safe calls. Option D est incorrecte car le double point d''interrogation n''est pas utilisé pour les safe calls.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','variable?.property',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','variable.property?',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','variable?::property',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','variable?.property?',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-NS-072') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='null_safety' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-NS-072',v_cert_id,v_theme_id,'Quelles sont les deux propositions vraies concernant le mot-clé lateinit en Kotlin ?','hard','SINGLE_CHOICE','Option A est incorrecte car lateinit ne peut être utilisé que pour des propriétés var. Option B est correcte car une propriété lateinit doit effectivement être initialisée avant son utilisation. Option C est incorrecte car lateinit ne peut pas être utilisé avec des types primitifs, qui sont non-nullables par défaut. Option D est correcte car une fois initialisée, une propriété lateinit ne peut plus être nulle.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','lateinit peut être utilisé pour des propriétés var et val',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Une propriété lateinit doit être initialisée avant son utilisation',TRUE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','lateinit peut être utilisé avec des types primitifs',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Une propriété lateinit ne peut pas être nulle après son initialisation',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-NS-073') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='null_safety' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-NS-073',v_cert_id,v_theme_id,'Quelle est la valeur retournée par l''expression `a ?: b` si a est non-null ?','medium','SINGLE_CHOICE','Option A est correcte car l''opérateur Elvis retourne la valeur de a si elle n''est pas null. Option B est incorrecte car b est retourné uniquement si a est null. Option C est incorrecte car l''expression ne retournera jamais null si a n''est pas null. Option D est incorrecte car l''expression ne provoque aucune erreur de compilation si a n''est pas null.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','a',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','b',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','null',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','erreur de compilation',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-NS-074') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='null_safety' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-NS-074',v_cert_id,v_theme_id,'Quelles sont les deux affirmations correctes concernant le smart cast en Kotlin ?','easy','SINGLE_CHOICE','Option A est incorrecte car le smart cast nécessite parfois une vérification supplémentaire, comme un if. Option B est incorrecte car le smart cast avec des types nullable nécessite une vérification explicite. Option C est correcte car le smart cast est effectué lorsque Kotlin peut déduire le type d''une variable dans une condition if. Option D est incorrecte car le smart cast ne convertit pas n''importe quel type en un autre, il vérifie et utilise le type déduit.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Le smart cast est automatique et ne nécessite aucune action du programmeur',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Le smart cast peut être utilisé avec des types nullable sans vérification supplémentaire',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Le smart cast est effectué lorsqu''une variable est utilisée dans une condition if avec un type spécifique',TRUE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Le smart cast peut être utilisé pour convertir n''importe quel type en un autre',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-NS-075') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='null_safety' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-NS-075',v_cert_id,v_theme_id,'Sélectionnez TOUTES les affirmations correctes concernant l''opérateur de safe call (?.) :','medium','SINGLE_CHOICE','L''opérateur de safe call (?.) est utilisé pour éviter les NullPointerException en vérifiant si l''objet est null avant d''accéder à ses membres. Il peut être utilisé avec des méthodes, des propriétés et même les fonctions lambda. Si l''objet est null, l''expression entière retourne null.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Permet d''éviter les NullPointerException',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Peut être utilisé avec des méthodes et des propriétés',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','N''est pas utilisable avec les fonctions lambda',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Retourne null si l''objet est null',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-NS-076') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='null_safety' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-NS-076',v_cert_id,v_theme_id,'Quelle est la fonction principale de l''opérateur Elvis (?:) ?','easy','SINGLE_CHOICE','L''opérateur Elvis (?:) permet de retourner une valeur par défaut si la première expression est null. C''est utile pour éviter les NullPointerException et fournir une valeur alternative.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Permet de retourner une valeur par défaut si la première expression est null',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Effectue une vérification de nullité avant d''exécuter une action',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Remplace la valeur d''une variable par null',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Force l''exécution d''un bloc de code',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-NS-077') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='null_safety' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-NS-077',v_cert_id,v_theme_id,'Quelles sont les deux principales restrictions liées à l''utilisation de lateinit ?','hard','SINGLE_CHOICE','lateinit ne peut pas être utilisé avec des types primitifs, mais doit être initialisé avant d''être utilisé. Il ne peut pas être utilisé dans des classes data, car ces classes nécessitent une initialisation immédiate de toutes les propriétés. Il ne doit pas être marqué comme final.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Ne peut pas être utilisé avec des types primitifs',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Doit être initialisé avant d''être utilisé',TRUE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Ne peut pas être utilisé dans des classes data',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Doit être marqué comme final',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-NS-078') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='null_safety' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-NS-078',v_cert_id,v_theme_id,'Quelle est la condition pour que Kotlin effectue un smart cast ?','medium','SINGLE_CHOICE','Kotlin effectue un smart cast lorsqu''une variable est vérifiée avec une expression if, permettant de lever la nullabilité temporairement dans le bloc if.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Lorsqu''une variable est vérifiée avec une expression if',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Toujours, après chaque assignation de valeur',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Lorsque la variable est déclarée comme nullable',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Après une fonction qui retourne un type non null',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-NS-079') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='null_safety' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-NS-079',v_cert_id,v_theme_id,'Quelles sont les deux caractéristiques des platform types dans Kotlin ?','hard','SINGLE_CHOICE','Les platform types peuvent être nullables ou non-nullables selon le contexte et sont principalement utilisés dans les interactions avec Java. Ils permettent d''éviter les NullPointerException en fournissant des informations sur la nullabilité dans le code Kotlin.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Peuvent être nullables ou non-nullables selon le contexte',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Sont utilisés uniquement dans les interactions avec Java',TRUE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Permettent d''éviter les NullPointerException',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Ne peuvent pas être utilisés dans des expressions lambda',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-NS-080') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='null_safety' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-NS-080',v_cert_id,v_theme_id,'Sélectionnez TOUTES les affirmations correctes concernant l''opérateur de safe call (?.) en Kotlin :','medium','SINGLE_CHOICE','L''opérateur de safe call (?.) est utilisé pour éviter les exceptions NullPointerException en Kotlin, ce qui le rend correct. Il peut être utilisé avec des méthodes et des propriétés, donc cette option est également correcte. Cependant, l''opérateur de safe call retourne la valeur de la méthode ou de la propriété si l''objet est non nul, pas null. Donc, cette option est incorrecte. Enfin, l''opérateur de safe call peut être utilisé avec des variables non nulles pour accéder aux propriétés ou méthodes, donc cette option est incorrecte.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','L''opérateur de safe call permet d''éviter les exceptions NullPointerException.',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Il peut être utilisé avec des méthodes et des propriétés.',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','L''opérateur de safe call retourne null si l''objet est non nul.',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Il ne peut être utilisé qu''avec des variables de type nullable.',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-COR-001') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='coroutines' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-COR-001',v_cert_id,v_theme_id,'Qu''est-ce qu''une coroutine en Kotlin ?','easy','SINGLE_CHOICE','Les coroutines sont des instances de calcul suspendable, plus légères que les threads.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Instance de calcul suspendable',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Thread léger',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Alternative aux threads',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-COR-002') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='coroutines' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-COR-002',v_cert_id,v_theme_id,'Quelle bibliothèque ajoute le support des coroutines ?','easy','SINGLE_CHOICE','kotlinx.coroutines est la bibliothèque officielle.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','kotlinx.coroutines',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','kotlin.coroutines',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','kotlinx.async',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','kotlin.concurrent',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-COR-003') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='coroutines' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-COR-003',v_cert_id,v_theme_id,'Quel mot-clé marque une fonction suspendable ?','easy','SINGLE_CHOICE','suspend est le mot-clé pour les fonctions pouvant suspendre l''exécution.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','suspend',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','async',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','await',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','delay',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-COR-004') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='coroutines' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-COR-004',v_cert_id,v_theme_id,'Peut-on appeler une fonction suspend depuis une fonction normale ?','medium','SINGLE_CHOICE','Une fonction suspend doit être appelée depuis une coroutine ou runBlocking.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Non, seulement depuis une autre suspend',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Oui',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Oui, avec runBlocking',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A et C',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-COR-005') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='coroutines' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-COR-005',v_cert_id,v_theme_id,'Quel builder lance une nouvelle coroutine sans retour ?','easy','SINGLE_CHOICE','launch lance une coroutine et retourne un Job.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','launch',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','async',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','runBlocking',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','withContext',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-COR-006') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='coroutines' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-COR-006',v_cert_id,v_theme_id,'Quel builder lance une coroutine et retourne un résultat ?','easy','SINGLE_CHOICE','async retourne Deferred<T> pour récupérer le résultat.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','async',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','launch',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','runBlocking',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','produce',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-COR-007') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='coroutines' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-COR-007',v_cert_id,v_theme_id,'Que fait runBlocking ?','medium','SINGLE_CHOICE','runBlocking est un pont entre code synchrone et asynchrone.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Bloque le thread jusqu''à fin de la coroutine',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Lance une coroutine non-bloquante',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Crée un scope',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Annule les coroutines',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-COR-008') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='coroutines' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-COR-008',v_cert_id,v_theme_id,'À quoi sert CoroutineScope ?','medium','SINGLE_CHOICE','CoroutineScope fournit un contexte pour les coroutines.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Gérer le cycle de vie des coroutines',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Créer des coroutines',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Annuler des coroutines',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-COR-009') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='coroutines' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-COR-009',v_cert_id,v_theme_id,'Comment créer un CoroutineScope personnalisé ?','hard','SINGLE_CHOICE','CoroutineScope(Dispatchers.IO) ou MainScope() pour Android.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','CoroutineScope(context)',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','GlobalScope',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','MainScope()',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A et C',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-COR-010') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='coroutines' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-COR-010',v_cert_id,v_theme_id,'Quels sont les dispatchers principaux ?','easy','SINGLE_CHOICE','Dispatchers.Default (CPU), IO (réseau/fichier), Main (UI), Unconfined.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Default, IO, Main, Unconfined',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Default, IO, UI, Background',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Default, Network, Disk, Main',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','CPU, IO, UI, Common',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-COR-011') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='coroutines' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-COR-011',v_cert_id,v_theme_id,'Quel dispatcher est optimisé pour les opérations CPU intensives ?','medium','SINGLE_CHOICE','Default utilise le pool commun pour les calculs.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Dispatchers.Default',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Dispatchers.IO',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Dispatchers.Main',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Dispatchers.Unconfined',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-COR-012') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='coroutines' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-COR-012',v_cert_id,v_theme_id,'Quel dispatcher est adapté aux opérations réseau/fichier ?','medium','SINGLE_CHOICE','IO est conçu pour les opérations bloquantes I/O.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Dispatchers.IO',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Dispatchers.Default',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Dispatchers.Main',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Dispatchers.Unconfined',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-COR-013') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='coroutines' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-COR-013',v_cert_id,v_theme_id,'Qu''est-ce que Dispatchers.Unconfined ?','hard','SINGLE_CHOICE','Unconfined commence dans le thread appelant, puis change selon suspension.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Coroutine non confinée, s''exécute dans le thread appelant',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Thread dédié',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Pool illimité',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','UI thread',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-COR-014') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='coroutines' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-COR-014',v_cert_id,v_theme_id,'À quoi sert withContext ?','medium','SINGLE_CHOICE','withContext(Dispatchers.IO) change le contexte d''exécution.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Changer le dispatcher d''une coroutine',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Lancer une nouvelle coroutine',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Attendre un résultat',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Annuler une coroutine',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-COR-015') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='coroutines' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-COR-015',v_cert_id,v_theme_id,'withContext est-il suspend ?','hard','SINGLE_CHOICE','withContext est une fonction suspend qui retourne le résultat.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Oui',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Parfois',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Dépend du dispatcher',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-COR-016') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='coroutines' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-COR-016',v_cert_id,v_theme_id,'Que retourne launch ?','medium','SINGLE_CHOICE','launch retourne un Job pour gérer la coroutine.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Job',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Deferred<T>',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Unit',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','CoroutineScope',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-COR-017') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='coroutines' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-COR-017',v_cert_id,v_theme_id,'Comment attendre la fin d''un Job ?','hard','SINGLE_CHOICE','join() suspend la coroutine jusqu''à la fin du Job.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','job.join()',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','job.await()',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','job.wait()',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','job.complete()',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-COR-018') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='coroutines' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-COR-018',v_cert_id,v_theme_id,'Comment annuler une coroutine ?','hard','SINGLE_CHOICE','cancel() annule la coroutine et ses enfants.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','job.cancel()',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','job.stop()',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','job.interrupt()',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','job.kill()',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-COR-019') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='coroutines' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-COR-019',v_cert_id,v_theme_id,'Que retourne async ?','medium','SINGLE_CHOICE','async retourne Deferred<T> qui étend Job.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Deferred<T>',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Job',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Unit',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','CoroutineScope',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-COR-020') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='coroutines' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-COR-020',v_cert_id,v_theme_id,'Comment obtenir le résultat d''un Deferred ?','hard','SINGLE_CHOICE','await() suspend la coroutine jusqu''au résultat.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','deferred.await()',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','deferred.get()',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','deferred.result()',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','deferred.value()',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-COR-021') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='coroutines' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-COR-021',v_cert_id,v_theme_id,'Les coroutines sont-elles coopératives pour l''annulation ?','hard','SINGLE_CHOICE','L''annulation est coopérative : il faut vérifier isActive.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Oui, vérifient l''état d''annulation',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Non, annulation forcée',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Oui, automatiquement',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Non, ne peuvent pas être annulées',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-COR-022') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='coroutines' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-COR-022',v_cert_id,v_theme_id,'Comment rendre une coroutine annulable ?','hard','SINGLE_CHOICE','Plusieurs méthodes pour vérifier l''état d''annulation.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','ensureActive()',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','yield()',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','check(isActive)',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-COR-023') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='coroutines' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-COR-023',v_cert_id,v_theme_id,'À quoi sert NonCancellable ?','hard','SINGLE_CHOICE','withContext(NonCancellable) pour les opérations de nettoyage.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Exécuter du code non annulable',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Empêcher l''annulation',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Nettoyage après annulation',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A et C',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-COR-024') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='coroutines' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-COR-024',v_cert_id,v_theme_id,'Comment limiter la durée d''une coroutine ?','hard','SINGLE_CHOICE','withTimeout lance TimeoutCancellationException, withTimeoutOrNull retourne null.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','withTimeout',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','withTimeoutOrNull',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','timeout',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A et B',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-COR-025') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='coroutines' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-COR-025',v_cert_id,v_theme_id,'Que fait withTimeoutOrNull ?','hard','SINGLE_CHOICE','withTimeoutOrNull retourne null au lieu de lancer une exception.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Retourne null si timeout',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Lance exception',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Ignore timeout',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Retry',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-COR-026') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='coroutines' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-COR-026',v_cert_id,v_theme_id,'À quoi sert Channel ?','hard','SINGLE_CHOICE','Channel permet l''envoi et la réception de données entre coroutines.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Communication entre coroutines',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','File d''attente',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Streaming',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A et B',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-COR-027') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='coroutines' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-COR-027',v_cert_id,v_theme_id,'Comment envoyer un message sur un Channel ?','hard','SINGLE_CHOICE','send (suspend) ou offer (non-suspend).','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','channel.send(value)',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','channel.offer(value)',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','channel.put(value)',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A et B',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-COR-028') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='coroutines' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-COR-028',v_cert_id,v_theme_id,'Comment recevoir un message d''un Channel ?','hard','SINGLE_CHOICE','receive (suspend) ou poll (non-suspend).','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','channel.receive()',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','channel.poll()',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','channel.take()',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A et B',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-COR-029') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='coroutines' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-COR-029',v_cert_id,v_theme_id,'Quel type de Channel a une capacité illimitée ?','hard','SINGLE_CHOICE','UNLIMITED crée un channel sans limite de taille.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Channel.UNLIMITED',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Channel.RENDEZVOUS',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Channel.CONFLATED',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Channel.BUFFERED',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-COR-030') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='coroutines' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-COR-030',v_cert_id,v_theme_id,'Quel type de Channel a une capacité de 0 (rendez-vous) ?','hard','SINGLE_CHOICE','RENDEZVOUS : le send bloque jusqu''à receive.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Channel.RENDEZVOUS',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Channel.UNLIMITED',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Channel.CONFLATED',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Channel.BUFFERED',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-COR-031') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='coroutines' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-COR-031',v_cert_id,v_theme_id,'Que fait Channel.CONFLATED ?','hard','SINGLE_CHOICE','CONFLATED conserve seulement le dernier élément envoyé.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Ne garde que le dernier élément',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Capacité infinie',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Capacité 0',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Buffer par défaut',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-COR-032') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='coroutines' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-COR-032',v_cert_id,v_theme_id,'Qu''est-ce que Flow ?','hard','SINGLE_CHOICE','Flow est un stream asynchrone qui émet plusieurs valeurs.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Stream asynchrone',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Cold stream',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Collection reactive',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-COR-033') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='coroutines' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-COR-033',v_cert_id,v_theme_id,'Comment créer un Flow simple ?','hard','SINGLE_CHOICE','Plusieurs façons de créer des flows.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','flow { emit(value) }',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','flowOf(values)',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','asFlow()',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-COR-034') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='coroutines' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-COR-034',v_cert_id,v_theme_id,'Quel opérateur transforme chaque élément ?','hard','SINGLE_CHOICE','map applique une transformation à chaque élément.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','map',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','filter',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','transform',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','collect',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-COR-035') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='coroutines' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-COR-035',v_cert_id,v_theme_id,'Comment collecter les valeurs d''un Flow ?','hard','SINGLE_CHOICE','collect est l''opérateur terminal principal.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','collect',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','launchIn',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','onEach',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A et B',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-COR-036') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='coroutines' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-COR-036',v_cert_id,v_theme_id,'Comment gérer la backpressure dans Flow ?','hard','SINGLE_CHOICE','Plusieurs stratégies pour gérer les émissions rapides.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','buffer',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','conflate',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','collectLatest',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-COR-037') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='coroutines' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-COR-037',v_cert_id,v_theme_id,'Sur quel dispatcher s''exécute un Flow ?','hard','SINGLE_CHOICE','Flow conserve le contexte du collecteur (pas de conservation).','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Celui du collecteur',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Celui du producteur',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Dispatchers.Default',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Dispatchers.IO',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-COR-038') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='coroutines' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-COR-038',v_cert_id,v_theme_id,'Comment changer le contexte d''un Flow ?','hard','SINGLE_CHOICE','flowOn change le contexte pour les opérations upstream.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','flowOn',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','withContext',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','launchOn',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','contextOn',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-COR-039') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='coroutines' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-COR-039',v_cert_id,v_theme_id,'Qu''est-ce que SharedFlow ?','hard','SINGLE_CHOICE','SharedFlow est un hot flow partagé entre plusieurs collecteurs.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Flow chaud (hot)',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Flow froid (cold)',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','StateFlow',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','CallbackFlow',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-COR-040') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='coroutines' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-COR-040',v_cert_id,v_theme_id,'Comment créer un SharedFlow ?','hard','SINGLE_CHOICE','MutableSharedFlow ou shareIn sur un Flow existant.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','MutableSharedFlow',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','SharedFlow()',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','flow.shareIn',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A et C',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-COR-041') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='coroutines' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-COR-041',v_cert_id,v_theme_id,'Qu''est-ce que StateFlow ?','hard','SINGLE_CHOICE','StateFlow est un SharedFlow qui conserve la dernière valeur.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','SharedFlow avec état',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Flow froid',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Channel',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','CallbackFlow',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-COR-042') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='coroutines' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-COR-042',v_cert_id,v_theme_id,'Comment créer un StateFlow ?','hard','SINGLE_CHOICE','MutableStateFlow ou stateIn sur un Flow.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','MutableStateFlow(initial)',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','StateFlow()',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','flow.stateIn',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A et C',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-COR-043') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='coroutines' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-COR-043',v_cert_id,v_theme_id,'Avantage de StateFlow sur LiveData ?','hard','SINGLE_CHOICE','StateFlow est plus puissant et flexible.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Pas besoin de cycle de vie',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Plus d''opérateurs',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Coroutines natives',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-COR-044') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='coroutines' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-COR-044',v_cert_id,v_theme_id,'Comment gérer les exceptions dans une coroutine ?','hard','SINGLE_CHOICE','Plusieurs mécanismes selon le besoin.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','try/catch',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','CoroutineExceptionHandler',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','SupervisorJob',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-COR-045') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='coroutines' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-COR-045',v_cert_id,v_theme_id,'Comment ajouter un CoroutineExceptionHandler ?','hard','SINGLE_CHOICE','Le handler est ajouté dans le contexte de la coroutine.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','CoroutineExceptionHandler { _, throwable -> }',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','lancer avec handler',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','scope + handler',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A et C',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-COR-046') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='coroutines' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-COR-046',v_cert_id,v_theme_id,'À quoi sert SupervisorJob ?','hard','SINGLE_CHOICE','SupervisorJob permet aux coroutines enfants de continuer après échec d''une autre.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Isoler les échecs entre coroutines',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Accélérer l''exécution',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Annuler tout',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Limiter les threads',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-COR-047') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='coroutines' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-COR-047',v_cert_id,v_theme_id,'Quelle est la différence entre coroutineScope et supervisorScope ?','hard','SINGLE_CHOICE','supervisorScope isole les échecs, coroutineScope les propage.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','supervisorScope ne propage pas les échecs',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','coroutineScope propage les échecs',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Identiques',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A et B',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-COR-048') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='coroutines' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-COR-048',v_cert_id,v_theme_id,'Qu''est-ce que la concurrence structurée ?','hard','SINGLE_CHOICE','Les enfants sont automatiquement annulés avec le parent.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Les coroutines enfants sont liées au parent',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Les coroutines sont indépendantes',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Les threads sont liés',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Aucune',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-COR-049') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='coroutines' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-COR-049',v_cert_id,v_theme_id,'Que se passe-t-il si une coroutine enfant échoue ?','hard','SINGLE_CHOICE','Dans coroutineScope, un échec annule tout.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Annulation du parent et des autres enfants',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Rien',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Seul l''enfant est annulé',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Retry automatique',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-COR-050') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='coroutines' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-COR-050',v_cert_id,v_theme_id,'Quelle dépendance pour les coroutines sur Android ?','hard','SINGLE_CHOICE','Plusieurs dépendances pour l''intégration Android.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','kotlinx-coroutines-android',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','kotlinx-coroutines-core',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','androidx.lifecycle:lifecycle-viewmodel-ktx',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A et C',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-COR-051') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='coroutines' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-COR-051',v_cert_id,v_theme_id,'Quel scope est lié au ViewModel ?','hard','SINGLE_CHOICE','viewModelScope est annulé quand le ViewModel est détruit.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','viewModelScope',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','lifecycleScope',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','coroutineScope',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','mainScope',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-COR-052') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='coroutines' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-COR-052',v_cert_id,v_theme_id,'Quel scope est lié au cycle de vie ?','hard','SINGLE_CHOICE','lifecycleScope est annulé quand le Lifecycle se termine.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','lifecycleScope',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','viewModelScope',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','coroutineScope',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','globalScope',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-COR-053') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='coroutines' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-COR-053',v_cert_id,v_theme_id,'Comment lancer une coroutine pendant le cycle de vie ?','hard','SINGLE_CHOICE','Plusieurs APIs selon la version.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','lifecycleScope.launch',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','repeatOnLifecycle',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','launchWhenStarted',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-COR-054') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='coroutines' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-COR-054',v_cert_id,v_theme_id,'Comment tester des coroutines ?','hard','SINGLE_CHOICE','kotlinx-coroutines-test fournit ces outils.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','runTest',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','TestCoroutineDispatcher',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','StandardTestDispatcher',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-COR-055') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='coroutines' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-COR-055',v_cert_id,v_theme_id,'Que fait runTest ?','hard','SINGLE_CHOICE','runTest avance le temps automatiquement.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Exécute les coroutines en temps virtuel',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Accélère le temps',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Ignore les délais',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-COR-056') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='coroutines' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-COR-056',v_cert_id,v_theme_id,'Comment déboguer les coroutines ?','hard','SINGLE_CHOICE','Propriété système ou DebugProbes pour les noms.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','-Dkotlinx.coroutines.debug',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','DebugProbes',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Logging',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A et B',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-COR-057') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='coroutines' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-COR-057',v_cert_id,v_theme_id,'Comment nommer une coroutine pour le debug ?','hard','SINGLE_CHOICE','CoroutineName dans le contexte.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','CoroutineName("name")',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','launch(CoroutineName("name"))',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','withContext(CoroutineName("name"))',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-COR-058') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='coroutines' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-COR-058',v_cert_id,v_theme_id,'À quoi sert Mutex ?','hard','SINGLE_CHOICE','Mutex évite les accès concurrents.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Exclusion mutuelle dans les coroutines',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Thread-safe',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Synchronisation',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-COR-059') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='coroutines' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-COR-059',v_cert_id,v_theme_id,'Comment acquérir un Mutex ?','hard','SINGLE_CHOICE','lock() suspend, withLock est la forme recommandée.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','mutex.lock()',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','mutex.withLock { }',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','mutex.acquire()',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A et B',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-COR-060') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='coroutines' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-COR-060',v_cert_id,v_theme_id,'À quoi sert Semaphore ?','hard','SINGLE_CHOICE','Semaphore gère plusieurs permits.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Limiter le nombre d''accès concurrents',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Exclusion mutuelle',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','File d''attente',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A et C',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-COR-061') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='coroutines' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-COR-061',v_cert_id,v_theme_id,'Comment utiliser un Semaphore ?','hard','SINGLE_CHOICE','withPermit est la forme recommandée.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','semaphore.withPermit { }',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','semaphore.acquire() / release()',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','semaphore.take() / give()',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A et B',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-COR-062') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='coroutines' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-COR-062',v_cert_id,v_theme_id,'À quoi sert select ?','hard','SINGLE_CHOICE','select attend la première opération prête.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Attendre le premier résultat de plusieurs canaux',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Choisir entre plusieurs opérations',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Pattern matching',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A et B',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-COR-063') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='coroutines' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-COR-063',v_cert_id,v_theme_id,'Comment utiliser select avec des channels ?','hard','SINGLE_CHOICE','onReceive ou onSend dans le bloc select.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','select<Int> { channel1.onReceive { it } }',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','select { channel1.onReceive { } }',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','select { channel1.receive { } }',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','select(channel1) { }',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-COR-064') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='coroutines' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-COR-064',v_cert_id,v_theme_id,'Qu''est-ce qu''un actor ?','hard','SINGLE_CHOICE','Actor encapsule un état et un channel de messages.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Coroutine avec mailbox',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Pattern de concurrence',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Channel avec traitement',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-COR-065') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='coroutines' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-COR-065',v_cert_id,v_theme_id,'Comment créer un actor ?','hard','SINGLE_CHOICE','actor est un builder (expérimental).','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','actor { }',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','launch avec channel',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','CoroutineScope.actor',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A et C',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-COR-066') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='coroutines' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-COR-066',v_cert_id,v_theme_id,'À quoi sert callbackFlow ?','hard','SINGLE_CHOICE','callbackFlow transforme les callbacks en Flow.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Convertir des callbacks en Flow',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','API asynchrone',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Listener',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-COR-067') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='coroutines' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-COR-067',v_cert_id,v_theme_id,'Comment utiliser callbackFlow ?','hard','SINGLE_CHOICE','callbackFlow utilise send et awaitClose.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','callbackFlow { send(value); awaitClose { } }',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','flow { emit(value) }',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','channelFlow { }',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A et C',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-COR-068') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='coroutines' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-COR-068',v_cert_id,v_theme_id,'Différence entre channelFlow et flow ?','hard','SINGLE_CHOICE','channelFlow produit un hot flow partagé.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','channelFlow peut être collecté par plusieurs',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','flow est cold, channelFlow hot',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Identiques',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A et B',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-COR-069') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='coroutines' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-COR-069',v_cert_id,v_theme_id,'Les coroutines sont-elles plus performantes que les threads ?','hard','SINGLE_CHOICE','Les coroutines ont un overhead mémoire bien plus faible.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Oui, beaucoup plus légères',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Non, plus lourdes',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Identiques',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Pour l''I/O, oui',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-COR-070') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='coroutines' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-COR-070',v_cert_id,v_theme_id,'Faut-il éviter GlobalScope ?','hard','SINGLE_CHOICE','GlobalScope est déconseillé sauf cas très particuliers.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Oui, difficile à gérer',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Non, pratique',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Oui, sauf pour les singletons',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Non, recommandé',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-COR-071') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='coroutines' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-COR-071',v_cert_id,v_theme_id,'Sélectionnez TOUTES les affirmations correctes concernant les builders de coroutines :','medium','SINGLE_CHOICE','launch lance une coroutine dans le contexte courant et retourne un Job, donc c''est correct. async lance une coroutine et retourne un Deferred, donc c''est correct. runBlocking bloque le thread courant jusqu''à la fin de la coroutine, donc c''est correct. withContext change le contexte et attend la fin du bloc, donc c''est correct.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','launch lance une coroutine dans le contexte courant et retourne un Job',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','async lance une coroutine et retourne un Deferred',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','runBlocking bloque le thread courant jusqu''à la fin de la coroutine',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','withContext change le contexte et attend la fin du bloc',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-COR-072') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='coroutines' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-COR-072',v_cert_id,v_theme_id,'Quelle est la principale différence entre Dispatchers.IO et Dispatchers.Default ?','easy','SINGLE_CHOICE','Dispatchers.IO est conçu pour les opérations I/O, tandis que Dispatchers.Default est destiné au calcul intensif. Donc, la première option est correcte.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Dispatchers.IO est pour les opérations I/O, Dispatchers.Default est pour le calcul intensif',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Dispatchers.IO est pour le calcul intensif, Dispatchers.Default est pour les opérations I/O',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Aucune différence, ils sont interchangeables',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Dispatchers.IO utilise plus de threads que Dispatchers.Default',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-COR-073') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='coroutines' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-COR-073',v_cert_id,v_theme_id,'Quelles sont les DEUX propositions vraies concernant un Job dans Kotlin coroutines ?','hard','SINGLE_CHOICE','Un Job peut être annulé, donc c''est correct. Un Job est toujours lancé dans le contexte global, donc c''est incorrect. Un Job peut être attendu avec await(), donc c''est correct. Un Job est immuable après sa création, donc c''est incorrect.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Un Job peut être annulé',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Un Job est toujours lancé dans le contexte global',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Un Job peut être attendu avec await()',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Un Job est immuable après sa création',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-COR-074') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='coroutines' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-COR-074',v_cert_id,v_theme_id,'Quel type de Channel est utilisé pour gérer des éléments avec une capacité limitée ?','medium','SINGLE_CHOICE','Channel.BUFFERED est utilisé pour gérer des éléments avec une capacité limitée, donc c''est correct.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Channel.UNLIMITED',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Channel.CONFLATED',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Channel.BUFFERED',TRUE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Channel.RENDEZVOUS',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-COR-075') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='coroutines' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-COR-075',v_cert_id,v_theme_id,'Sélectionnez TOUTES les affirmations correctes concernant Flow :','hard','SINGLE_CHOICE','Flow est un flux de données asynchrone, donc c''est correct. Flow peut être transformé avec des opérateurs comme map ou filter, donc c''est correct. Flow est toujours chaud (hot), donc c''est incorrect. Flow peut être collecté avec launchIn ou collect, donc c''est correct.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Flow est un flux de données asynchrone',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Flow peut être transformé avec des opérateurs comme map ou filter',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Flow est toujours chaud (hot)',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Flow peut être collecté avec launchIn ou collect',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-COR-076') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='coroutines' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-COR-076',v_cert_id,v_theme_id,'Sélectionnez TOUTES les affirmations correctes concernant Dispatchers :','medium','SINGLE_CHOICE','Dispatchers.IO est utilisé pour les opérations d''entrée/sortie, Dispatchers.Default est optimisé pour les calculs CPU intensifs, et Dispatchers.Main est utilisé dans Android pour l''UI. Dispatchers.Unconfined peut changer de thread pendant son exécution, ce qui n''est pas toujours souhaité pour des tâches longues.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Dispatchers.IO est utilisé pour les opérations d''entrée/sortie',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Dispatchers.Default est optimisé pour les calculs CPU intensifs',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Dispatchers.Main est utilisé dans Android pour l''UI',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Dispatchers.Unconfined peut changer de thread pendant son exécution',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-COR-077') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='coroutines' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-COR-077',v_cert_id,v_theme_id,'Quelle coroutine builder est utilisée pour lancer une coroutine dans le contexte principal ?','easy','SINGLE_CHOICE','runBlocking est utilisé pour lancer une coroutine dans le contexte principal et attendre sa fin.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','launch',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','async',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','runBlocking',TRUE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','withContext',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-COR-078') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='coroutines' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-COR-078',v_cert_id,v_theme_id,'Quelles sont les DEUX propositions vraies concernant Job :','medium','SINGLE_CHOICE','Job est utilisé pour représenter une tâche en cours d''exécution et peut être annulé avec la méthode cancel(). Job n''est pas un type de Dispatcher, mais il peut être lancé avec launch().','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Job est utilisé pour représenter une tâche en cours d''exécution',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Job peut être annulé avec la méthode cancel()',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Job est un type de Dispatcher',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Job peut être lancé avec launch()',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-COR-079') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='coroutines' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-COR-079',v_cert_id,v_theme_id,'Quelle est la principale différence entre un Channel et une SharedFlow ?','hard','SINGLE_CHOICE','Channel ne supporte pas la rétention des valeurs, SharedFlow peut les conserver. Channel est asynchrone et peut avoir plusieurs émetteurs, tandis que SharedFlow est principalement utilisé pour la diffusion de données à plusieurs consommateurs.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Channel est conçu pour des communications unidirectionnelles, SharedFlow est bidirectionnelle',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Channel ne supporte pas la rétention des valeurs, SharedFlow peut les conserver',TRUE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Channel est asynchrone, SharedFlow est synchrone',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Channel peut avoir plusieurs émetteurs, SharedFlow ne le peut pas',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-COR-080') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='coroutines' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-COR-080',v_cert_id,v_theme_id,'Sélectionnez TOUTES les affirmations correctes concernant CoroutineScope :','easy','SINGLE_CHOICE','CoroutineScope est utilisé pour la gestion de la durée de vie des coroutines, peut être annulé avec cancel(), et peut lancer des coroutines avec launch(). CoroutineScope n''est pas un type de Dispatcher.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','CoroutineScope est utilisé pour la gestion de la durée de vie des coroutines',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','CoroutineScope peut être annulé avec cancel()',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','CoroutineScope est un type de Dispatcher',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','CoroutineScope peut lancer des coroutines avec launch()',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-COR-081') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='coroutines' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-COR-081',v_cert_id,v_theme_id,'Sélectionnez TOUTES les affirmations correctes concernant les coroutine builders en Kotlin :','medium','SINGLE_CHOICE','launch est correct car il lance une nouvelle coroutine et retourne un Job. async est également correct car il lance une nouvelle coroutine et retourne un Deferred. runBlocking est incorrect car, bien qu''il puisse être utilisé pour bloquer le thread actuel, il n''est pas un coroutine builder. withContext est incorrect car, bien qu''il puisse changer le contexte de l''exécution, il ne crée pas une nouvelle coroutine.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','launch lance une nouvelle coroutine et retourne un Job.',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','async lance une nouvelle coroutine et retourne un Deferred.',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','runBlocking est utilisé pour bloquer le thread actuel jusqu''à la fin de la coroutine.',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','withContext change le contexte de l''exécution sans créer une nouvelle coroutine.',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-COR-082') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='coroutines' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-COR-082',v_cert_id,v_theme_id,'Quelle est la principale différence entre Dispatchers.IO et Dispatchers.Default ?','easy','SINGLE_CHOICE','Dispatchers.IO est correct car il est utilisé pour les opérations de E/S bloquantes, tandis que Dispatchers.Default est correct car il est utilisé pour le calcul intensif. Les autres options sont incorrectes car elles inversent ou généralisent les utilisations spécifiques de ces dispatchers.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Dispatchers.IO est utilisé pour les opérations de E/S bloquantes, tandis que Dispatchers.Default est utilisé pour le calcul intensif.',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Dispatchers.IO est utilisé pour le calcul intensif, tandis que Dispatchers.Default est utilisé pour les opérations de E/S bloquantes.',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Dispatchers.IO et Dispatchers.Default sont interchangeables pour toutes les tâches.',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Dispatchers.IO est utilisé pour le multithreading, tandis que Dispatchers.Default est utilisé pour les coroutines.',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-COR-083') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='coroutines' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-COR-083',v_cert_id,v_theme_id,'Sélectionnez TOUTES les affirmations correctes concernant les coroutine builders :','medium','SINGLE_CHOICE','launch lance une coroutine dans le contexte courant et ne retourne pas de valeur, donc c''est correct. async retourne un Deferred qui peut être attendu, aussi correct. runBlocking est utilisé pour bloquer le thread courant jusqu''à la fin de la coroutine, donc c''est correct. withContext change le contexte mais ne lance pas une nouvelle coroutine, donc incorrect.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','launch lance une coroutine dans le contexte courant',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','async retourne un Deferred qui peut être attendu',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','runBlocking est utilisé pour bloquer le thread courant jusqu''à la fin de la coroutine',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','withContext change le contexte et attend la fin de la coroutine',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-COR-084') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='coroutines' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-COR-084',v_cert_id,v_theme_id,'Quelle est la principale différence entre Dispatchers.IO et Dispatchers.Default ?','easy','SINGLE_CHOICE','Dispatchers.IO est conçu pour les opérations de E/S, tandis que Dispatchers.Default est conçu pour le calcul intensif. Aucune différence n''est correcte car ils ont des utilisations spécifiques.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Dispatchers.IO est pour les opérations de E/S, Dispatchers.Default est pour le calcul intensif',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Dispatchers.IO est pour les calculs intensifs, Dispatchers.Default est pour les opérations de E/S',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Aucune différence, ils sont interchangeables',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Dispatchers.IO utilise des threads plus nombreux que Dispatchers.Default',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-COR-085') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='coroutines' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-COR-085',v_cert_id,v_theme_id,'Quelles sont les DEUX propositions vraies concernant les Channels ?','hard','SINGLE_CHOICE','Les Channels sont thread-safe, donc c''est correct. Ils peuvent être utilisés pour la communication entre coroutines, aussi correct. Ils ne sont pas limités à un seul producteur et consommateur, donc incorrect. Les Channels peuvent être utilisés pour des messages de type suspend, donc incorrect.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Les Channels sont thread-safe',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Les Channels peuvent être utilisés pour la communication entre coroutines',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Les Channels sont limités à un seul producteur et consommateur',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Les Channels ne peuvent pas être utilisé pour des messages de type suspend',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-COR-086') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='coroutines' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-COR-086',v_cert_id,v_theme_id,'Quelle est la différence entre CoroutineScope et GlobalScope ?','medium','SINGLE_CHOICE','CoroutineScope est lié à un contexte spécifique, tandis que GlobalScope n''est pas lié à aucun contexte spécifique. Aucune différence n''est correcte car ils ont des utilisations différentes.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','CoroutineScope est lié à un contexte spécifique, GlobalScope n''est pas lié',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','GlobalScope est lié à un contexte spécifique, CoroutineScope n''est pas lié',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Aucune différence, ils sont interchangeables',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','CoroutineScope est plus performant que GlobalScope',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-COR-087') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='coroutines' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-COR-087',v_cert_id,v_theme_id,'Sélectionnez TOUTES les affirmations correctes concernant la gestion de l''annulation des coroutines :','easy','SINGLE_CHOICE','Une coroutine peut être annulée via un Job, donc c''est correct. L''annulation d''une coroutine n''interrompt pas immédiatement son exécution, donc incorrect. Une coroutine peut être configurée pour ne pas être annulable, donc c''est correct. L''annulation d''une coroutine peut être interceptée avec try/catch, donc c''est correct.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Une coroutine peut être annulée via un Job',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','L''annulation d''une coroutine interrompt immédiatement son exécution',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Une coroutine peut être configurée pour ne pas être annulable',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','L''annulation d''une coroutine peut être interceptée avec try/catch',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-COR-088') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='coroutines' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-COR-088',v_cert_id,v_theme_id,'Sélectionnez TOUTES les affirmations correctes concernant les coroutine builders :','medium','SINGLE_CHOICE','launch lance une coroutine dans le contexte courant et retourne un Job, donc c''est correct. async lance une coroutine et retourne un Deferred, aussi correct. runBlocking bloque le thread courant jusqu''à la fin de la coroutine, donc c''est incorrect. withContext change le contexte de la coroutine et retourne son résultat, donc c''est correct.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','launch lance une coroutine dans le contexte courant et retourne un Job',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','async lance une coroutine et retourne un Deferred',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','runBlocking bloque le thread courant jusqu''à la fin de la coroutine',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','withContext change le contexte de la coroutine et retourne son résultat',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-COR-089') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='coroutines' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-COR-089',v_cert_id,v_theme_id,'Quelle est la principale différence entre Dispatchers.IO et Dispatchers.Default ?','easy','SINGLE_CHOICE','Dispatchers.IO est utilisé pour les opérations I/O, tandis que Dispatchers.Default est utilisé pour le calcul intensif.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Dispatchers.IO est utilisé pour les opérations I/O, tandis que Dispatchers.Default est utilisé pour le calcul intensif',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Dispatchers.IO est utilisé pour le calcul intensif, tandis que Dispatchers.Default est utilisé pour les opérations I/O',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Aucune différence, elles sont interchangeables',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Dispatchers.IO est plus rapide que Dispatchers.Default',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-COR-091') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='coroutines' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-COR-091',v_cert_id,v_theme_id,'Quelle est la principale différence entre un Channel et une SharedFlow ?','hard','SINGLE_CHOICE','Un Channel est conçu pour les communications unidirectionnelles, tandis qu''une SharedFlow est conçue pour une diffusion à plusieurs abonnés.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Un Channel est conçu pour les communications unidirectionnelles, tandis qu''une SharedFlow est conçue pour une diffusion à plusieurs abonnés',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Un Channel est conçu pour la gestion de backpressure, tandis qu''une SharedFlow ne le fait pas',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Un Channel est conçu pour les opérations I/O, tandis qu''une SharedFlow est conçue pour le calcul intensif',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Aucune différence, elles sont interchangeables',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-COR-092') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='coroutines' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-COR-092',v_cert_id,v_theme_id,'Sélectionnez TOUTES les affirmations correctes concernant CoroutineScope :','easy','SINGLE_CHOICE','CoroutineScope permet de gérer la durée de vie des coroutines, donc c''est correct. CoroutineScope peut être annulé avec cancel(), donc c''est correct. CoroutineScope est utilisé pour exécuter des coroutines, donc c''est correct. CoroutineScope peut être annulé, donc cette option est incorrecte.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','CoroutineScope permet de gérer la durée de vie des coroutines',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','CoroutineScope peut être annulé avec cancel()',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','CoroutineScope est utilisé pour exécuter des coroutines',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','CoroutineScope ne peut pas être annulé',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-FUN-001') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='functional_programming' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-FUN-001',v_cert_id,v_theme_id,'Quelle est la syntaxe d''une lambda ?','easy','SINGLE_CHOICE','{ x -> x + 1 } est une lambda.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','{ param -> expression }',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','(param) -> expression',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','lambda param = expression',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','function(param) { expression }',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-FUN-002') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='functional_programming' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-FUN-002',v_cert_id,v_theme_id,'Comment référencer un paramètre unique dans une lambda ?','easy','SINGLE_CHOICE','it est le nom implicite du paramètre unique.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','it',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','this',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','value',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','param',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-FUN-003') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='functional_programming' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-FUN-003',v_cert_id,v_theme_id,'Qu''est-ce qu''une fonction d''ordre supérieur ?','easy','SINGLE_CHOICE','Higher-order function manipule des fonctions.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Fonction qui prend une fonction en paramètre',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Fonction qui retourne une fonction',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Fonction générique',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A et B',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-FUN-004') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='functional_programming' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-FUN-004',v_cert_id,v_theme_id,'Comment déclarer un paramètre fonction ?','medium','SINGLE_CHOICE','(Int, Int) -> Int est le type de la fonction.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','fun operate(a: Int, b: Int, op: (Int, Int) -> Int)',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','fun operate(a: Int, b: Int, op: Function<Int, Int, Int>)',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','fun operate(a: Int, b: Int, op: Int -> Int -> Int)',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','fun operate(a: Int, b: Int, op: (Int, Int): Int)',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-FUN-005') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='functional_programming' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-FUN-005',v_cert_id,v_theme_id,'Que fait map sur une collection ?','easy','SINGLE_CHOICE','map applique une transformation à chaque élément.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Transforme chaque élément',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Filtre les éléments',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Réduit la collection',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Trie la collection',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-FUN-006') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='functional_programming' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-FUN-006',v_cert_id,v_theme_id,'Que fait filter sur une collection ?','easy','SINGLE_CHOICE','filter conserve les éléments vérifiant le prédicat.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Garde les éléments satisfaisant une condition',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Supprime les éléments',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Transforme les éléments',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Ordonne les éléments',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-FUN-007') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='functional_programming' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-FUN-007',v_cert_id,v_theme_id,'Que fait reduce ?','medium','SINGLE_CHOICE','reduce combine les éléments avec une opération associative.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Accumule les éléments en un résultat',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Réduit la taille',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Supprime des éléments',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Transforme',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-FUN-008') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='functional_programming' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-FUN-008',v_cert_id,v_theme_id,'Différence entre reduce et fold ?','hard','SINGLE_CHOICE','fold accepte une valeur initiale, reduce utilise le premier élément.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','fold a une valeur initiale, reduce non',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','reduce a une valeur initiale, fold non',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Identiques',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','fold pour les listes vides',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-FUN-009') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='functional_programming' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-FUN-009',v_cert_id,v_theme_id,'Que fait flatMap ?','hard','SINGLE_CHOICE','flatMap transforme chaque élément en collection puis aplatit.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Map puis aplatit',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Filtre puis aplatit',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Reduce puis aplatit',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Transforme seulement',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-FUN-010') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='functional_programming' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-FUN-010',v_cert_id,v_theme_id,'Que produit listOf(1,2).flatMap { listOf(it, it*2) } ?','hard','SINGLE_CHOICE','1 → [1,2], 2 → [2,4] → [1,2,2,4].','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','[1,2,2,4]',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','[1,2]',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','[2,4]',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','[1,2,4]',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-FUN-011') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='functional_programming' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-FUN-011',v_cert_id,v_theme_id,'Que fait groupBy ?','hard','SINGLE_CHOICE','groupBy retourne une Map<Key, List<Element>>.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Groupe les éléments par clé',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Ordonne les éléments',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Supprime les doublons',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Filtre',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-FUN-012') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='functional_programming' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-FUN-012',v_cert_id,v_theme_id,'Que fait associate ?','hard','SINGLE_CHOICE','associate { it to it*2 } crée une Map.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Crée une Map à partir d''une collection',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Associe des valeurs',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Joint des collections',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Fusionne',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-FUN-013') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='functional_programming' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-FUN-013',v_cert_id,v_theme_id,'Que fait zip ?','hard','SINGLE_CHOICE','list1.zip(list2) retourne des paires (a,b).','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Combine deux collections en paires',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Compresse',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Zippe',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A et C',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-FUN-014') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='functional_programming' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-FUN-014',v_cert_id,v_theme_id,'Que retourne partition ?','hard','SINGLE_CHOICE','partition sépare les éléments selon un prédicat.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Pair de collections (vrais, faux)',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Liste de booléens',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Map',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Set',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-FUN-015') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='functional_programming' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-FUN-015',v_cert_id,v_theme_id,'Qu''est-ce qu''une Sequence ?','hard','SINGLE_CHOICE','Sequence évalue les opérations paresseusement.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Collection paresseuse',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Collection eager',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Liste',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Set',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-FUN-016') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='functional_programming' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-FUN-016',v_cert_id,v_theme_id,'Avantage de Sequence sur List ?','hard','SINGLE_CHOICE','Sequence permet le traitement paresseux, idéal pour grandes collections.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Moins de mémoire pour grands volumes',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Plus rapide',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Plus simple',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A et B',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-FUN-017') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='functional_programming' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-FUN-017',v_cert_id,v_theme_id,'Comment créer une Sequence ?','hard','SINGLE_CHOICE','Plusieurs façons de créer des sequences.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','list.asSequence()',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','sequence { }',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','generateSequence',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-FUN-018') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='functional_programming' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-FUN-018',v_cert_id,v_theme_id,'Que fait takeWhile ?','hard','SINGLE_CHOICE','takeWhile s''arrête à la première condition fausse.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Prend les éléments tant que condition vraie',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Prend tous les éléments',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Ignore les premiers',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Filtre',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-FUN-019') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='functional_programming' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-FUN-019',v_cert_id,v_theme_id,'Que fait dropWhile ?','hard','SINGLE_CHOICE','dropWhile ignore jusqu''à la première condition fausse.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Ignore les éléments tant que condition vraie',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Prend les éléments',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Supprime tout',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Garde les premiers',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-FUN-020') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='functional_programming' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-FUN-020',v_cert_id,v_theme_id,'Que fait chunked ?','hard','SINGLE_CHOICE','list.chunked(3) crée des sous-listes de 3 éléments.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Découpe en sous-listes de taille donnée',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Regroupe par taille',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Transforme',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Filtre',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-FUN-021') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='functional_programming' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-FUN-021',v_cert_id,v_theme_id,'Différence entre chunked et windowed ?','hard','SINGLE_CHOICE','windowed permet le chevauchement (step).','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','windowed a un chevauchement possible',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','chunked sans chevauchement',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Identiques',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A et B',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-FUN-022') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='functional_programming' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-FUN-022',v_cert_id,v_theme_id,'fold peut-il s''appliquer sur une liste vide ?','hard','SINGLE_CHOICE','fold fonctionne sur liste vide grâce à la valeur initiale.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Oui, retourne la valeur initiale',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Non, exception',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Oui, null',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Dépend',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-FUN-023') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='functional_programming' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-FUN-023',v_cert_id,v_theme_id,'Que retourne runningFold ?','hard','SINGLE_CHOICE','runningFold retourne toutes les valeurs d''accumulation.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Liste des valeurs intermédiaires',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Valeur finale',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Map',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Set',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-FUN-024') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='functional_programming' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-FUN-024',v_cert_id,v_theme_id,'Comment trier par une propriété ?','easy','SINGLE_CHOICE','sortedBy retourne une nouvelle liste triée.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','sortedBy { it.property }',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','sortBy { it.property }',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','orderBy { it.property }',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A et B',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-FUN-025') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='functional_programming' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-FUN-025',v_cert_id,v_theme_id,'Que fait distinct ?','easy','SINGLE_CHOICE','distinct retourne une liste sans doublons.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Supprime les doublons',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Garde les doublons',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Transforme',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Compte',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-FUN-026') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='functional_programming' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-FUN-026',v_cert_id,v_theme_id,'Que fait distinctBy ?','hard','SINGLE_CHOICE','distinctBy { it.property } garde le premier pour chaque clé.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Supprime les doublons selon une clé',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Supprime tous les doublons',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Garde un élément par clé',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A et C',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-FUN-027') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='functional_programming' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-FUN-027',v_cert_id,v_theme_id,'Que retourne maxByOrNull ?','hard','SINGLE_CHOICE','maxByOrNull évite les exceptions sur liste vide.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Élément max selon sélecteur, ou null',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Élément max',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Valeur max',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Index max',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-FUN-028') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='functional_programming' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-FUN-028',v_cert_id,v_theme_id,'minByOrNull fait quoi ?','hard','SINGLE_CHOICE','minByOrNull est la version sûre.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Élément min selon sélecteur, ou null',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Élément min',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Valeur min',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Index min',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-FUN-029') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='functional_programming' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-FUN-029',v_cert_id,v_theme_id,'firstOrNull diffère de first par ?','hard','SINGLE_CHOICE','firstOrNull évite l''exception.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Retourne null au lieu de NoSuchElementException',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Retourne le dernier',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Retourne une liste',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Identique',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-FUN-030') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='functional_programming' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-FUN-030',v_cert_id,v_theme_id,'Que fait singleOrNull ?','hard','SINGLE_CHOICE','singleOrNull attend exactement 0 ou 1 élément.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Retourne l''unique élément ou null',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Retourne le premier',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Retourne le dernier',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Retourne tous',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-FUN-031') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='functional_programming' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-FUN-031',v_cert_id,v_theme_id,'Que fait any ?','easy','SINGLE_CHOICE','any retourne true si au moins un élément satisfait.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Vérifie si un élément satisfait la condition',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Vérifie si tous les éléments satisfont',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Compte les éléments',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Prend le premier',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-FUN-032') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='functional_programming' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-FUN-032',v_cert_id,v_theme_id,'Que fait all ?','easy','SINGLE_CHOICE','all retourne true si tous les éléments satisfont.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Vérifie si tous les éléments satisfont',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Vérifie si un élément satisfait',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Compte les éléments',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Filtre',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-FUN-033') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='functional_programming' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-FUN-033',v_cert_id,v_theme_id,'Que fait none ?','hard','SINGLE_CHOICE','none est l''inverse de any.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Vérifie si aucun élément ne satisfait',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Vérifie si tous satisfont',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Vérifie si un satisfait',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Retourne le contraire de any',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-FUN-034') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='functional_programming' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-FUN-034',v_cert_id,v_theme_id,'Que fait count ?','easy','SINGLE_CHOICE','count peut être sans paramètre ou avec prédicat.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Compte les éléments satisfaisant une condition',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Compte tous les éléments',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Retourne le nombre',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-FUN-035') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='functional_programming' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-FUN-035',v_cert_id,v_theme_id,'Que fait forEach ?','easy','SINGLE_CHOICE','forEach exécute une action pour chaque élément.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Applique une action à chaque élément',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Transforme les éléments',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Filtre les éléments',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Réduit',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-FUN-036') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='functional_programming' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-FUN-036',v_cert_id,v_theme_id,'Différence entre onEach et forEach ?','hard','SINGLE_CHOICE','onEach permet le chaînage.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','onEach retourne la collection',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','forEach retourne Unit',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Identiques',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A et B',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-FUN-037') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='functional_programming' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-FUN-037',v_cert_id,v_theme_id,'Que retourne withIndex ?','hard','SINGLE_CHOICE','withIndex donne accès à l''index et la valeur.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Collection d''IndexedValue',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Liste d''indices',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Map',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Set',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-FUN-038') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='functional_programming' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-FUN-038',v_cert_id,v_theme_id,'Que fait associateBy ?','hard','SINGLE_CHOICE','associateBy { it.id } crée une Map id → objet.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Crée une Map avec la clé fournie',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Associe par valeur',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Joint',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Groupe',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-FUN-039') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='functional_programming' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-FUN-039',v_cert_id,v_theme_id,'Que fait associateWith ?','hard','SINGLE_CHOICE','associateWith { it.length } crée Map élément → longueur.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Crée une Map avec la valeur dérivée',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Associe par clé',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Joint',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Groupe',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-FUN-040') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='functional_programming' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-FUN-040',v_cert_id,v_theme_id,'Que fait unzip ?','hard','SINGLE_CHOICE','unzip transforme List<Pair<A,B>> en Pair<List<A>,List<B>>.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Sépare une liste de paires en deux listes',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Combine deux listes',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Zip inverse',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A et C',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-FUN-041') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='functional_programming' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-FUN-041',v_cert_id,v_theme_id,'Que fait slice ?','hard','SINGLE_CHOICE','slice(1..3) retourne les éléments aux indices donnés.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Extrait une plage d''indices',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Coupe la liste',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Sépare',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Filtre',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-FUN-042') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='functional_programming' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-FUN-042',v_cert_id,v_theme_id,'Que fait drop ?','hard','SINGLE_CHOICE','drop(2) ignore les 2 premiers éléments.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Ignore les n premiers éléments',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Prend les n premiers',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Supprime les n derniers',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Garde les n premiers',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-FUN-043') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='functional_programming' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-FUN-043',v_cert_id,v_theme_id,'Que fait take ?','hard','SINGLE_CHOICE','take(2) prend les 2 premiers éléments.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Prend les n premiers éléments',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Ignore les n premiers',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Prend les n derniers',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Prend tous',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-FUN-044') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='functional_programming' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-FUN-044',v_cert_id,v_theme_id,'Que fait takeLast ?','hard','SINGLE_CHOICE','takeLast(2) prend les 2 derniers éléments.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Prend les n derniers éléments',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Prend les n premiers',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Ignore les n derniers',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Prend tous',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-FUN-045') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='functional_programming' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-FUN-045',v_cert_id,v_theme_id,'Que fait dropLast ?','hard','SINGLE_CHOICE','dropLast(2) ignore les 2 derniers éléments.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Ignore les n derniers éléments',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Ignore les n premiers',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Prend les n derniers',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Prend tous',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-FUN-046') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='functional_programming' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-FUN-046',v_cert_id,v_theme_id,'Que fait filterIsInstance<T>() ?','hard','SINGLE_CHOICE','filterIsInstance<String>() garde les String.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Filtre les éléments d''un type donné',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Filtre par instance',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Cast',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A et B',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-FUN-047') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='functional_programming' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-FUN-047',v_cert_id,v_theme_id,'Que fait filterNotNull ?','hard','SINGLE_CHOICE','filterNotNull retourne une liste non-nullable.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Supprime les éléments null',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Garde les null',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Transforme null',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Ignore',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-FUN-048') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='functional_programming' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-FUN-048',v_cert_id,v_theme_id,'Que fait mapIndexed ?','hard','SINGLE_CHOICE','mapIndexed { index, value -> ... }','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Map avec accès à l''index',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Map sans index',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Filtre',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Reduce',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-FUN-049') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='functional_programming' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-FUN-049',v_cert_id,v_theme_id,'Que fait forEachIndexed ?','hard','SINGLE_CHOICE','forEachIndexed { index, value -> }','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','forEach avec index',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','map avec index',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','filter avec index',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','reduce avec index',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-FUN-050') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='functional_programming' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-FUN-050',v_cert_id,v_theme_id,'Que fait sumOf ?','hard','SINGLE_CHOICE','sumOf { it.length } somme les longueurs.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Somme des valeurs transformées',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Somme simple',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Moyenne',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Compte',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-FP-001') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='functional_programming' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-FP-001',v_cert_id,v_theme_id,'Sélectionnez TOUTES les affirmations correctes concernant les fonctions d''ordre supérieur en Kotlin :','medium','SINGLE_CHOICE','A est correct car une fonction d''ordre supérieur peut prendre une autre fonction en paramètre. B est incorrect car les fonctions d''ordre supérieur peuvent retourner une autre fonction. C est correct car les fonctions lambda sont des exemples de fonctions d''ordre supérieur. D est correct car une fonction d''ordre supérieur peut être stockée dans une variable.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Une fonction d''ordre supérieur peut prendre une autre fonction en paramètre.',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Une fonction d''ordre supérieur ne peut pas retourner une autre fonction.',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Les fonctions lambda sont des exemples de fonctions d''ordre supérieur.',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Une fonction d''ordre supérieur peut être stockée dans une variable.',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-FP-002') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='functional_programming' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-FP-002',v_cert_id,v_theme_id,'Quelle méthode est utilisée pour transformer chaque élément d''une collection en Kotlin ?','easy','SINGLE_CHOICE','A est correct car la méthode map est utilisée pour transformer chaque élément d''une collection en Kotlin. Les autres options sont incorrectes car elles servent à des opérations différentes : filter pour filtrer les éléments, reduce pour réduire la collection à une seule valeur, et flatMap pour transformer et aplatir les éléments.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','map',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','filter',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','reduce',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','flatMap',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-FP-004') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='functional_programming' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-FP-004',v_cert_id,v_theme_id,'Quelle est la principale différence entre une List et une Sequence en Kotlin ?','medium','SINGLE_CHOICE','A est correct car une List est évaluée immédiatement, tandis qu''une Sequence est évaluée de manière paresseuse. Les autres options sont incorrectes car elles ne reflètent pas les principales différences entre une List et une Sequence.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Une List est évaluée immédiatement, tandis qu''une Sequence est évaluée de manière paresseuse.',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Une List peut contenir des éléments null, tandis qu''une Sequence non.',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Une List est mutable, tandis qu''une Sequence est immutable.',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Une List utilise moins de mémoire que une Sequence.',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-FP-005') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='functional_programming' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-FP-005',v_cert_id,v_theme_id,'Quelles sont les deux affirmations correctes concernant filterIsInstance en Kotlin :','easy','SINGLE_CHOICE','A est incorrect car filterIsInstance retourne une List non nullable. B est correct car filterIsInstance filtre les éléments d''une collection en fonction du type spécifié. C est incorrect car filterIsInstance ne peut être utilisé qu''avec des collections de type Any. D est correct car filterIsInstance retourne une Sequence.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','filterIsInstance retourne une List de type nullable.',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','filterIsInstance filtre les éléments d''une collection en fonction du type spécifié.',TRUE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','filterIsInstance peut être utilisé avec n''importe quel type de collection.',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','filterIsInstance retourne une Sequence.',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-FP-005') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='functional_programming' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-FP-005',v_cert_id,v_theme_id,'Sélectionnez TOUTES les affirmations correctes concernant les fonctions d''ordre supérieur en Kotlin :','medium','SINGLE_CHOICE','Les fonctions d''ordre supérieur peuvent prendre une autre fonction en paramètre (A est correct). Elles ne sont pas limitées à retourner une fonction, donc B est incorrect. Les lambdas en Kotlin sont des fonctions d''ordre supérieur (C est correct). Elles peuvent également être stockées dans des variables (D est correct).','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Les fonctions d''ordre supérieur peuvent prendre une autre fonction en paramètre.',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Les fonctions d''ordre supérieur ne peuvent pas retourner une fonction.',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Les lambdas en Kotlin sont des fonctions d''ordre supérieur.',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Les fonctions d''ordre supérieur peuvent être stockées dans des variables.',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-FP-006') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='functional_programming' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-FP-006',v_cert_id,v_theme_id,'Quelle est la fonction Kotlin utilisée pour transformer chaque élément d''une collection en une autre forme ?','easy','SINGLE_CHOICE','La fonction map est utilisée pour transformer chaque élément d''une collection en une autre forme (A est correct).','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','map',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','filter',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','reduce',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','flatMap',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-FP-007') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='functional_programming' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-FP-007',v_cert_id,v_theme_id,'Quelles sont les DEUX affirmations vraies concernant la différence entre reduce et fold en Kotlin ?','hard','SINGLE_CHOICE','reduce nécessite un élément neutre (A est incorrect). fold nécessite un élément neutre (B est correct). reduce ne peut pas être utilisé sur des collections vides sans élément neutre (C est incorrect). fold peut être utilisé sur des collections vides avec un élément neutre (D est correct).','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','reduce nécessite un élément neutre.',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','fold nécessite un élément neutre.',TRUE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','reduce peut être utilisé sur des collections vides.',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','fold peut être utilisé sur des collections vides.',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-FP-008') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='functional_programming' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-FP-008',v_cert_id,v_theme_id,'Quelle est la principale différence entre une Sequence et une List en Kotlin ?','medium','SINGLE_CHOICE','Une Sequence est évaluée de manière différée, une List est évaluée immédiatement (B est correct).','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Une Sequence est évaluée immédiatement, une List est évaluée de manière différée.',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Une Sequence est évaluée de manière différée, une List est évaluée immédiatement.',TRUE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Une Sequence est mutable, une List est immutable.',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Une Sequence peut contenir des éléments nulls, une List ne le peut pas.',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-FP-009') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='functional_programming' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-FP-009',v_cert_id,v_theme_id,'Quelle fonction Kotlin est utilisée pour retourner une collection contenant des éléments distincts basés sur un critère spécifique ?','easy','SINGLE_CHOICE','distinctBy est utilisée pour retourner une collection contenant des éléments distincts basés sur un critère spécifique (B est correct).','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','distinct',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','distinctBy',TRUE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','unique',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','filterUnique',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-FP-010') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='functional_programming' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-FP-010',v_cert_id,v_theme_id,'Sélectionnez TOUTES les affirmations correctes concernant les fonctions d''ordre supérieur en Kotlin :','medium','SINGLE_CHOICE','Les options A, B et D sont correctes. Les fonctions d''ordre supérieur en Kotlin peuvent effectivement accepter des fonctions en tant que paramètres, retourner des fonctions et favoriser une programmation déclarative. L''option C est incorrecte car les fonctions d''ordre supérieur peuvent être utilisées avec des lambdas.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Les fonctions d''ordre supérieur peuvent accepter des fonctions en tant que paramètres.',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Les fonctions d''ordre supérieur peuvent retourner des fonctions.',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Les fonctions d''ordre supérieur ne peuvent pas être utilisées avec des lambdas.',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Les fonctions d''ordre supérieur permettent une programmation déclarative.',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-FP-011') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='functional_programming' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-FP-011',v_cert_id,v_theme_id,'Quelle est la différence entre map et flatMap en Kotlin ?','easy','SINGLE_CHOICE','L''option D est correcte. flatMap transforme chaque élément en une liste, puis aplatit ces listes en une seule collection. Les options A et E sont incorrectes car map ne transforme pas les éléments en listes, et B est incorrect car map retourne une collection d''éléments transformés, pas de listes.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','map transforme chaque élément de la collection en un autre élément, tandis que flatMap peut transformer et aplatir les éléments.',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','map retourne une collection de listes, tandis que flatMap retourne une seule liste.',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','map et flatMap sont interchangeables dans la plupart des cas.',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','flatMap transforme chaque élément en une liste, puis aplatit ces listes en une seule collection.',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-FP-012') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='functional_programming' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-FP-012',v_cert_id,v_theme_id,'Quelles sont les DEUX propositions vraies concernant reduce et fold en Kotlin ?','hard','SINGLE_CHOICE','Les options B et D sont correctes. fold nécessite un paramètre initial, ce qui lui permet de fonctionner même sur des collections vides. De plus, fold peut retourner un type différent du type des éléments de la collection, ce qui est utile pour accumuler des résultats dans un autre type. Les options A et C sont incorrectes car reduce lance une exception sur des collections vides, et les deux fonctions ne sont pas interchangeables dans tous les cas.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','reduce lance une exception si la collection est vide.',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','fold nécessite un paramètre initial.',TRUE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','reduce et fold sont interchangeables dans tous les cas.',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','fold peut retourner un type différent du type des éléments de la collection.',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-FP-013') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='functional_programming' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-FP-013',v_cert_id,v_theme_id,'Quelle est la principale différence entre une List et une Sequence en Kotlin ?','medium','SINGLE_CHOICE','L''option A est correcte. Une List est évaluée immédiatement, tandis qu''une Sequence est évaluée de manière différée, ce qui permet des opérations plus efficaces sur de grandes collections. Les options B et C sont incorrectes car une List peut contenir des éléments null, et il n''y a pas de garantie que l''une soit toujours plus rapide que l''autre. L''option D est incorrecte car une Sequence peut être convertie en List à l''aide de la méthode asList().','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Une List est évaluée immédiatement, tandis qu''une Sequence est évaluée de manière différée.',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Une List peut contenir des éléments null, tandis qu''une Sequence ne le peut pas.',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Une List est toujours plus rapide que une Sequence.',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Une Sequence ne peut pas être convertie en List.',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-FP-014') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='functional_programming' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-FP-014',v_cert_id,v_theme_id,'Quelle méthode est utilisée pour supprimer les éléments en double d''une collection en Kotlin, en se basant sur une clé spécifique ?','easy','SINGLE_CHOICE','L''option A est correcte. distinctBy est la méthode utilisée pour supprimer les éléments en double d''une collection en Kotlin, en se basant sur une clé spécifique. Les options B et C sont incorrectes car elles ne font pas partie de l''API Kotlin standard. L''option D est également incorrecte car filterUnique n''existe pas dans l''API Kotlin.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','distinctBy',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','unique',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','removeDuplicates',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','filterUnique',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-FP-015') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='functional_programming' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-FP-015',v_cert_id,v_theme_id,'Sélectionnez TOUTES les affirmations correctes concernant les fonctions d''ordre supérieur dans Kotlin :','medium','SINGLE_CHOICE','A est correct car une fonction d''ordre supérieur peut effectivement prendre une autre fonction en paramètre. B est incorrect car les fonctions d''ordre supérieur peuvent retourner une autre fonction. C est correct car les fonctions anonymes, également appelées lambdas, peuvent être utilisées comme arguments pour les fonctions d''ordre supérieur. D est incorrect car les fonctions d''ordre supérieur sont largement utilisées dans divers contextes, pas seulement dans les bibliothèques standard.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Une fonction d''ordre supérieur peut prendre une autre fonction en paramètre.',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Une fonction d''ordre supérieur ne peut pas retourner une autre fonction.',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Les fonctions anonymes peuvent être utilisées comme arguments pour les fonctions d''ordre supérieur.',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Les fonctions d''ordre supérieur ne peuvent être utilisées que dans les bibliothèques standard.',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-FP-016') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='functional_programming' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-FP-016',v_cert_id,v_theme_id,'Quelle est la principale différence entre une List et une Sequence en Kotlin ?','easy','SINGLE_CHOICE','A est correct car une Sequence en Kotlin est évaluée de manière lazy, ce qui signifie qu''elle n''est pas évaluée jusqu''à ce que ses éléments soient réellement nécessaires. B est incorrect car la différence principale n''est pas liée à l''utilisation de la mémoire. C est incorrect car la vitesse dépend du contexte et des opérations effectuées. D est incorrect car une Sequence peut être convertie en List à l''aide de la méthode asList().','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Une Sequence est évaluée de manière lazy, tandis qu''une List est évaluée immédiatement.',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Une Sequence utilise moins de mémoire qu''une List.',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Une Sequence est toujours plus rapide qu''une List.',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Une Sequence ne peut pas être convertie en List.',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-FP-017') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='functional_programming' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-FP-017',v_cert_id,v_theme_id,'Quelles sont les deux principales différences entre la méthode reduce et la méthode fold dans Kotlin ?','hard','SINGLE_CHOICE','A est incorrect car reduce nécessite effectivement un élément neutre initial. B est correct car fold peut spécifier un type de retour différent grâce à son paramètre initial, ce qui n''est pas le cas avec reduce. C est incorrect car reduce lève une exception sur une collection vide, contrairement à fold qui peut gérer ce cas avec un élément neutre initial. D est incorrect car la performance dépend du contexte et des opérations effectuées.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','reduce a besoin d''un élément neutre initial, tandis que fold non.',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','fold peut être utilisé avec des types de retour différents, contrairement à reduce.',TRUE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','reduce fonctionne sur une collection vide sans lever d''exception, tandis que fold lève une exception.',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','fold est plus performante que reduce dans tous les cas.',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-OOP-001') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='object_oriented' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-OOP-001',v_cert_id,v_theme_id,'Quelle est la visibilité par défaut en Kotlin ?','easy','SINGLE_CHOICE','Par défaut, les membres sont public.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','public',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','private',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','internal',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','protected',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-OOP-002') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='object_oriented' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-OOP-002',v_cert_id,v_theme_id,'Quel mot-clé est utilisé pour l''héritage ?','easy','SINGLE_CHOICE','class B : A()','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A',':',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','extends',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','implements',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','inherits',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-OOP-003') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='object_oriented' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-OOP-003',v_cert_id,v_theme_id,'Les classes sont-elles final par défaut ?','easy','SINGLE_CHOICE','Les classes sont final par défaut, il faut open pour hériter.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Oui',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Uniquement les data classes',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Uniquement les sealed classes',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-OOP-004') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='object_oriented' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-OOP-004',v_cert_id,v_theme_id,'Quel mot-clé rend une classe héritable ?','medium','SINGLE_CHOICE','open permet l''héritage.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','open',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','public',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','abstract',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','final',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-OOP-005') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='object_oriented' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-OOP-005',v_cert_id,v_theme_id,'Comment appeler le constructeur parent ?','medium','SINGLE_CHOICE','super() dans le constructeur secondaire.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','super()',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','parent()',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','superClass()',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','superConstructor()',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-OOP-006') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='object_oriented' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-OOP-006',v_cert_id,v_theme_id,'Une interface peut-elle avoir des propriétés ?','easy','SINGLE_CHOICE','Les interfaces peuvent avoir des propriétés abstraites ou avec implémentation.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Oui, abstraites ou avec getter',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Oui, avec champs',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Oui, seulement des constantes',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-OOP-007') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='object_oriented' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-OOP-007',v_cert_id,v_theme_id,'Une interface peut-elle avoir des méthodes avec corps ?','medium','SINGLE_CHOICE','Kotlin permet les méthodes par défaut dans les interfaces.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Oui, depuis Kotlin',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Oui, avec default',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Oui, avec static',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-OOP-008') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='object_oriented' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-OOP-008',v_cert_id,v_theme_id,'Quel mot-clé pour une classe abstraite ?','easy','SINGLE_CHOICE','abstract class MyClass','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','abstract',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','open',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','sealed',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','interface',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-OOP-009') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='object_oriented' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-OOP-009',v_cert_id,v_theme_id,'Une classe abstraite peut-elle avoir un constructeur ?','medium','SINGLE_CHOICE','Les classes abstraites peuvent avoir des constructeurs.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Oui',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Uniquement primaire',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Uniquement secondaire',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-OOP-010') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='object_oriented' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-OOP-010',v_cert_id,v_theme_id,'Une sealed class peut-elle avoir plusieurs instances ?','hard','SINGLE_CHOICE','Les sealed classes ont des sous-classes multiples.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Oui, via ses sous-classes',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Non, singleton',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Oui, directement',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Non, une seule',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-OOP-011') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='object_oriented' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-OOP-011',v_cert_id,v_theme_id,'Les sous-classes d''une sealed class doivent être où ?','hard','SINGLE_CHOICE','Les sous-classes doivent être dans le même fichier.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Dans le même fichier',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Dans le même package',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','N''importe où',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Dans le même module',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-OOP-012') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='object_oriented' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-OOP-012',v_cert_id,v_theme_id,'Quelles méthodes une data class génère-t-elle ?','easy','SINGLE_CHOICE','Data class génère toutes ces méthodes.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','equals, hashCode, toString, copy, componentN',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','equals, hashCode seulement',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','toString seulement',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Aucune',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-OOP-013') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='object_oriented' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-OOP-013',v_cert_id,v_theme_id,'Une data class peut-elle être open ?','medium','SINGLE_CHOICE','Les data classes sont final, ne peuvent pas être open.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Non, final par défaut',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Oui, avec open',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Oui, avec abstract',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Non, jamais',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-OOP-014') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='object_oriented' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-OOP-014',v_cert_id,v_theme_id,'Qu''est-ce qu''un object declaration ?','hard','SINGLE_CHOICE','object MySingleton { } crée un singleton.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Singleton',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Classe anonyme',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Companion object',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Objet normal',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-OOP-015') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='object_oriented' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-OOP-015',v_cert_id,v_theme_id,'À quoi sert companion object ?','hard','SINGLE_CHOICE','companion object remplace les statiques Java.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Membres statiques',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Singleton',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Factory',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A et C',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-OOP-016') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='object_oriented' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-OOP-016',v_cert_id,v_theme_id,'Peut-on nommer un companion object ?','hard','SINGLE_CHOICE','companion object Factory { }','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Oui, companion object Named { }',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Oui, avec @Named',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Oui, avec name',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-OOP-017') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='object_oriented' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-OOP-017',v_cert_id,v_theme_id,'Que signifie internal ?','medium','SINGLE_CHOICE','internal est visible dans le même module.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Visible dans le module',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Visible dans le package',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Visible partout',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Visible dans la classe',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-OOP-018') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='object_oriented' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-OOP-018',v_cert_id,v_theme_id,'protected dans un fichier top-level ?','hard','SINGLE_CHOICE','protected n''est pas autorisé pour les déclarations top-level.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Non autorisé',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Autorisé',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Équivalent à internal',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Équivalent à private',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-OOP-019') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='object_oriented' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-OOP-019',v_cert_id,v_theme_id,'En Kotlin, une propriété a-t-elle un champ par défaut ?','hard','SINGLE_CHOICE','Les propriétés ont un backing field si aucun getter personnalisé.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Oui, backing field',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Oui, si getter/setter par défaut',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Uniquement pour val',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-OOP-020') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='object_oriented' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-OOP-020',v_cert_id,v_theme_id,'Comment accéder au backing field dans un setter ?','hard','SINGLE_CHOICE','field représente le champ de stockage.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','field',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','value',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','this.field',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','backingField',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-OOP-021') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='object_oriented' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-OOP-021',v_cert_id,v_theme_id,'Qu''est-ce qu''une propriété déléguée ?','hard','SINGLE_CHOICE','Delegation using ''by''.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Délègue son getter/setter',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Propriété déléguée à un autre objet',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Pattern de délégation',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-OOP-022') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='object_oriented' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-OOP-022',v_cert_id,v_theme_id,'Quels sont les délégués standards ?','hard','SINGLE_CHOICE','lazy, observable, vetoable, etc.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','lazy, observable, vetoable',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','lazy, lateinit, by map',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','lazy, notNull, by Delegates',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A et C',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-OOP-023') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='object_oriented' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-OOP-023',v_cert_id,v_theme_id,'Que fait by lazy ?','hard','SINGLE_CHOICE','lazy n''initialise qu''à la première lecture.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Initialisation paresseuse',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Initialisation immédiate',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Thread-safe par défaut',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A et C',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-OOP-024') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='object_oriented' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-OOP-024',v_cert_id,v_theme_id,'Quels sont les modes de lazy ?','hard','SINGLE_CHOICE','LazyThreadSafetyMode.SYNCHRONIZED par défaut.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','SYNCHRONIZED, PUBLICATION, NONE',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','LAZY, EAGER, DEFAULT',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','THREAD_SAFE, NOT_THREAD_SAFE',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','DEFAULT, ATOMIC',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-OOP-025') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='object_oriented' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-OOP-025',v_cert_id,v_theme_id,'Comment implémenter la délégation en Kotlin ?','hard','SINGLE_CHOICE','by délègue l''implémentation à l''objet.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','class Derived(b: Base) : Base by b',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','class Derived extends Base',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','class Derived implements Base',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','class Derived : Base',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-OOP-026') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='object_oriented' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-OOP-026',v_cert_id,v_theme_id,'Peut-on surcharger une méthode déléguée ?','hard','SINGLE_CHOICE','La classe peut surcharger les méthodes déléguées.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Oui, redéfinir dans la classe',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Oui, avec override',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Oui, mais attention',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-OOP-027') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='object_oriented' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-OOP-027',v_cert_id,v_theme_id,'Par défaut, une classe interne est-elle statique ?','hard','SINGLE_CHOICE','Les classes internes sont static par défaut (nested).','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Oui, static par défaut',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Non, non-static',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Oui, avec inner',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Non, avec static',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-OOP-028') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='object_oriented' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-OOP-028',v_cert_id,v_theme_id,'Comment créer une classe interne non-statique ?','hard','SINGLE_CHOICE','inner class accède aux membres de la classe externe.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','inner class Inner',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','class Inner',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','static class Inner',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','nonstatic class Inner',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-OOP-029') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='object_oriented' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-OOP-029',v_cert_id,v_theme_id,'Comment accéder à this de la classe externe ?','hard','SINGLE_CHOICE','this@Outer qualifié.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','this@Outer',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','super@Outer',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','outer.this',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Outer.this',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-OOP-030') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='object_oriented' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-OOP-030',v_cert_id,v_theme_id,'Une enum class peut-elle avoir des propriétés ?','hard','SINGLE_CHOICE','enum class Direction { NORTH, SOUTH; val degrees: Int }','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Oui',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Oui, seulement des constantes',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Oui, avec constructeur',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-OOP-031') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='object_oriented' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-OOP-031',v_cert_id,v_theme_id,'Peut-on ajouter des méthodes à une enum ?','hard','SINGLE_CHOICE','Les enums peuvent avoir des méthodes.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Oui',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Oui, avec abstract',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Oui, mais seulement des fonctions d''extension',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-OOP-032') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='object_oriented' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-OOP-032',v_cert_id,v_theme_id,'À quoi sert une inline class ?','hard','SINGLE_CHOICE','Inline class (value class) évite l''allocation.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Wrapper sans overhead',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Classe immuable',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Data class',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Sealed class',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-OOP-033') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='object_oriented' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-OOP-033',v_cert_id,v_theme_id,'Quelle annotation pour une inline class ?','hard','SINGLE_CHOICE','@JvmInline value class Password(val value: String)','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','@JvmInline',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','@Inline',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','@Value',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','@Data',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-OOP-034') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='object_oriented' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-OOP-034',v_cert_id,v_theme_id,'Une interface peut-elle être sealed ?','hard','SINGLE_CHOICE','sealed interface Result','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Oui',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Oui, avec restrictions',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Uniquement avec permits',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-OOP-035') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='object_oriented' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-OOP-035',v_cert_id,v_theme_id,'À quoi sert typealias ?','hard','SINGLE_CHOICE','typealias UserMap = Map<String, User>','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Donner un nom alternatif à un type',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Créer un nouveau type',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Étendre un type',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Réduire un type',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-OOP-036') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='object_oriented' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-OOP-036',v_cert_id,v_theme_id,'Comment supporter la déstructuration pour une classe ?','hard','SINGLE_CHOICE','Data class ou componentN manuels.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','operator fun componentN()',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','data class automatique',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','A et B',TRUE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Aucune',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-OOP-037') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='object_oriented' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-OOP-037',v_cert_id,v_theme_id,'Quel mot-clé pour surcharger + ?','hard','SINGLE_CHOICE','operator fun plus(other: T): T','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','plus',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','add',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','sum',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','concat',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-OOP-038') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='object_oriented' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-OOP-038',v_cert_id,v_theme_id,'Quel mot-clé pour surcharger [] ?','hard','SINGLE_CHOICE','operator fun get(index: Int): T','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','get',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','set',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','index',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','access',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-OOP-039') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='object_oriented' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-OOP-039',v_cert_id,v_theme_id,'Quelle est la relation entre equals et hashCode ?','hard','SINGLE_CHOICE','Contrat standard de hashCode.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Si equals true, hashCode doit être égal',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Si hashCode égal, equals doit être true',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Aucune relation',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A et B',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-OOP-040') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='object_oriented' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-OOP-040',v_cert_id,v_theme_id,'La méthode copy générée est-elle shallow ou deep ?','hard','SINGLE_CHOICE','copy fait une copie superficielle des propriétés.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Shallow (copie superficielle)',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Deep (copie profonde)',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Les deux',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Configurable',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-OBJ-001') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='object_oriented' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-OBJ-001',v_cert_id,v_theme_id,'Sélectionnez TOUTES les affirmations correctes concernant l''héritage en Kotlin :','medium','SINGLE_CHOICE','Option B est correcte car une classe peut implémenter plusieurs interfaces. Option D est correcte car Kotlin permet à une classe d''hériter d''une interface, mais pas directement de plusieurs classes. Option A est incorrecte car Kotlin ne supporte pas l''héritage multiple de classes. Option C est incorrecte pour la même raison que A.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Une classe peut hériter de plusieurs classes.',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Une classe peut implémenter plusieurs interfaces.',TRUE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','L''héritage multiple est supporté par Kotlin.',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Une classe peut hériter d''une interface.',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-OBJ-002') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='object_oriented' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-OBJ-002',v_cert_id,v_theme_id,'Quelle est la principale différence entre une interface et une classe abstraite en Kotlin ?','easy','SINGLE_CHOICE','Option C est correcte car une interface en Kotlin ne peut avoir que des méthodes abstraites et des propriétés, tandis qu''une classe abstraite peut avoir des méthodes concrètes et des propriétés. Les autres options sont incorrectes car une interface peut avoir des propriétés, une classe abstraite peut avoir des constructeurs et ne peut pas être instanciée.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Une interface peut avoir des propriétés, une classe abstraite non.',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Une classe abstraite peut avoir des constructeurs, une interface non.',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Une interface ne peut pas avoir de méthodes concrètes, une classe abstraite oui.',TRUE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Une interface peut être instanciée, une classe abstraite non.',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-OBJ-003') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='object_oriented' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-OBJ-003',v_cert_id,v_theme_id,'Quelles sont les DEUX principales caractéristiques d''une data class en Kotlin ?','medium','SINGLE_CHOICE','Option A est correcte car une data class génère automatiquement les méthodes equals() et hashCode(). Option C est correcte car une data class génère également automatiquement les méthodes toString() et copy(). Option B est incorrecte car une data class ne permet pas d''ajouter des propriétés supplémentaires après sa déclaration. Option D est incorrecte car une data class ne peut pas hériter d''une autre classe.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Génération automatique de méthodes equals() et hashCode().',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Possibilité d''ajouter des propriétés supplémentaires.',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Génération automatique de méthodes toString() et copy().',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Possibilité d''héritage.',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-OBJ-004') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='object_oriented' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-OBJ-004',v_cert_id,v_theme_id,'Quel modificateur de visibilité permet à une propriété d''être accessible uniquement dans le même fichier Kotlin ?','hard','SINGLE_CHOICE','Option B est correcte car le modificateur ''internal'' permet à une propriété d''être accessible uniquement dans le même fichier Kotlin. Les autres options sont incorrectes car ''private'' limite l''accès à la classe, ''protected'' permet l''accès dans la même classe et ses sous-classes, et ''public'' permet l''accès partout.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','private',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','internal',TRUE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','protected',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','public',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-OBJ-005') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='object_oriented' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-OBJ-005',v_cert_id,v_theme_id,'Quelles sont les DEUX opérateurs qui ne peuvent pas être surchargés en Kotlin ?','medium','SINGLE_CHOICE','Option D est correcte car l''opérateur ''/'' ne peut pas être surchargé en Kotlin. Option E est correcte car l''opérateur ''%'' ne peut pas être surchargé en Kotlin. Les autres options sont incorrectes car les opérateurs ''+'', ''-'', ''*'' peuvent être surchargés en Kotlin.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','+',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','-',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','*',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','/',TRUE,3);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'E','%',FALSE,4);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-OBJ-006') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='object_oriented' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-OBJ-006',v_cert_id,v_theme_id,'Quelles sont les DEUX affirmations correctes concernant les data classes en Kotlin ?','medium','SINGLE_CHOICE','Option B est correcte car les data classes implémentent automatiquement equals() et hashCode(). Option C est incorrecte car les data classes peuvent avoir des méthodes abstraites. Les autres options sont correctes.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Les data classes peuvent avoir des propriétés avec des valeurs par défaut.',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Les data classes implémentent automatiquement les méthodes equals() et hashCode().',TRUE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Les data classes peuvent avoir des méthodes abstraites.',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Les data classes ne peuvent pas avoir de constructeurs primaires.',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-OBJ-007') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='object_oriented' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-OBJ-007',v_cert_id,v_theme_id,'Quel modificateur de visibilité permet d''accéder à une propriété uniquement dans le même fichier Kotlin ?','easy','SINGLE_CHOICE','L''option C (internal) est correcte car elle permet d''accéder à une propriété uniquement dans le même fichier Kotlin. Les autres options sont incorrectes car public permet l''accès partout, private uniquement dans la même classe et protected dans la même hiérarchie de classes.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','public',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','private',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','internal',TRUE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','protected',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-OBJ-008') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='object_oriented' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-OBJ-008',v_cert_id,v_theme_id,'Sélectionnez TOUTES les affirmations correctes concernant les data classes en Kotlin :','medium','SINGLE_CHOICE','A est correct car les data classes génèrent automatiquement equals() et hashCode(). B est incorrect car les propriétés avec des initialisateurs ne sont pas autorisées dans une data class. C est correct car les data classes peuvent avoir des méthodes supplémentaires. D est incorrect car les data classes peuvent être héritées, mais elles ne peuvent hériter d''aucune autre classe.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Une data class génère automatiquement des méthodes equals() et hashCode().',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Les data classes peuvent avoir des propriétés avec des initialisateurs.',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Une data class peut avoir des méthodes supplémentaires.',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Les data classes ne peuvent pas être héritées.',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-OBJ-009') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='object_oriented' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-OBJ-009',v_cert_id,v_theme_id,'Quelle est la visibilité par défaut en Kotlin ?','easy','SINGLE_CHOICE','A est correct car par défaut, les membres sont publics et visibles partout. B est incorrect car private rend le membre visible uniquement dans la classe où il est déclaré. C est incorrect car internal rend le membre visible dans le même module. D est incorrect car protected rend le membre visible dans la classe et ses sous-classes.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','public',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','private',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','internal',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','protected',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-OBJ-010') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='object_oriented' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-OBJ-010',v_cert_id,v_theme_id,'Quelles sont les DEUX propositions vraies concernant les sealed classes en Kotlin ?','hard','SINGLE_CHOICE','A est incorrect car une sealed class ne peut pas être instanciée directement. B est correct car les sous-classes d''une sealed class doivent être déclarées dans le même fichier ou dans un fichier imbriqué. C est incorrect car une sealed class peut avoir un constructeur public, mais cela n''est généralement pas recommandé. D est correct car les sous-classes d''une sealed class peuvent être instanciées.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Une sealed class peut être instanciée.',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Les sous-classes d''une sealed class doivent être déclarées dans le même fichier.',TRUE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Une sealed class ne peut pas avoir de constructeur public.',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Les sous-classes d''une sealed class peuvent être instanciées.',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='KOT-OBJ-011') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='object_oriented' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'KOT-OBJ-011',v_cert_id,v_theme_id,'Quelle est la principale utilité d''un companion object en Kotlin ?','medium','SINGLE_CHOICE','B est correct car un companion object permet de définir des propriétés et des méthodes statiques pour une classe. A est incorrect car un companion object ne crée pas d''instances de la classe, mais plutôt des instances du companion object. C est incorrect car le garbage collector gère la mémoire, pas un companion object. D est incorrect car Kotlin ne supporte pas l''héritage multiple.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Créer des instances de la classe.',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Définir des propriétés et des méthodes statiques.',TRUE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Gérer la mémoire de l''objet.',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Permettre l''héritage multiple.',FALSE,3);
    END IF;
END $$;
