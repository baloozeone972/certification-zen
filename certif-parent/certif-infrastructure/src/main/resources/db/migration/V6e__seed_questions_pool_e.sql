-- =============================================================================
-- V6e__seed_questions_pool_e.sql
-- CertifApp — Import pool questions (352 questions, android certifications)
-- Idempotent : INSERT ... ON CONFLICT DO NOTHING
-- =============================================================================

-- ── ANDROID (352 questions) ──────
DO $$
DECLARE
    v_cert_id TEXT := 'android';
    v_theme_id UUID; v_q_id UUID; v_opt_id UUID;
BEGIN
    IF NOT EXISTS (SELECT 1 FROM certifications WHERE id = v_cert_id) THEN
        RAISE NOTICE 'Certification % absente', v_cert_id; RETURN;
    END IF;
    INSERT INTO certification_themes (id, certification_id, code, label, question_count, display_order)
    VALUES (uuid_generate_v4(), v_cert_id, 'activities_et_fragments', 'Activities et Fragments', 0, 0)
    ON CONFLICT (certification_id, code) DO NOTHING;
    INSERT INTO certification_themes (id, certification_id, code, label, question_count, display_order)
    VALUES (uuid_generate_v4(), v_cert_id, 'jetpack_compose', 'Jetpack Compose', 0, 0)
    ON CONFLICT (certification_id, code) DO NOTHING;
    INSERT INTO certification_themes (id, certification_id, code, label, question_count, display_order)
    VALUES (uuid_generate_v4(), v_cert_id, 'architecture_mvvm_viewmodel', 'Architecture (MVVM, ViewModel)', 0, 0)
    ON CONFLICT (certification_id, code) DO NOTHING;
    INSERT INTO certification_themes (id, certification_id, code, label, question_count, display_order)
    VALUES (uuid_generate_v4(), v_cert_id, 'data_storage', 'Data Storage', 0, 0)
    ON CONFLICT (certification_id, code) DO NOTHING;
    INSERT INTO certification_themes (id, certification_id, code, label, question_count, display_order)
    VALUES (uuid_generate_v4(), v_cert_id, 'networking', 'Networking', 0, 0)
    ON CONFLICT (certification_id, code) DO NOTHING;
    INSERT INTO certification_themes (id, certification_id, code, label, question_count, display_order)
    VALUES (uuid_generate_v4(), v_cert_id, 'security', 'Security', 0, 0)
    ON CONFLICT (certification_id, code) DO NOTHING;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-ACT-001') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='activities_et_fragments' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-ACT-001',v_cert_id,v_theme_id,'Quelle méthode est appelée à la création de l''Activity ?','easy','SINGLE_CHOICE','onCreate() est appelé lors de la création de l''Activity.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','onCreate()',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','onStart()',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','onResume()',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','onRestart()',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-ACT-002') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='activities_et_fragments' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-ACT-002',v_cert_id,v_theme_id,'Quelle méthode est appelée quand l''Activity devient visible ?','easy','SINGLE_CHOICE','onStart() est appelé quand l''Activity devient visible.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','onStart()',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','onCreate()',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','onResume()',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','onRestart()',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-ACT-003') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='activities_et_fragments' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-ACT-003',v_cert_id,v_theme_id,'Quelle méthode est appelée quand l''Activity prend le focus ?','easy','SINGLE_CHOICE','onResume() quand l''Activity interagit avec l''utilisateur.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','onResume()',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','onStart()',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','onCreate()',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','onRestart()',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-ACT-004') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='activities_et_fragments' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-ACT-004',v_cert_id,v_theme_id,'Quelle méthode est appelée quand l''Activity perd le focus ?','easy','SINGLE_CHOICE','onPause() quand l''Activity perd le focus.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','onPause()',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','onStop()',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','onDestroy()',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','onRestart()',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-ACT-005') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='activities_et_fragments' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-ACT-005',v_cert_id,v_theme_id,'Quelle méthode est appelée quand l''Activity n''est plus visible ?','easy','SINGLE_CHOICE','onStop() quand l''Activity n''est plus visible.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','onStop()',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','onPause()',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','onDestroy()',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','onRestart()',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-ACT-006') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='activities_et_fragments' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-ACT-006',v_cert_id,v_theme_id,'Quelle méthode est appelée avant la destruction ?','easy','SINGLE_CHOICE','onDestroy() avant la destruction de l''Activity.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','onDestroy()',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','onStop()',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','onPause()',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','onRestart()',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-ACT-007') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='activities_et_fragments' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-ACT-007',v_cert_id,v_theme_id,'Quelle méthode est appelée après onStop() ?','medium','SINGLE_CHOICE','onRestart() puis onStart() pour réafficher.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','onRestart()',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','onStart()',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','onResume()',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','onCreate()',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-ACT-008') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='activities_et_fragments' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-ACT-008',v_cert_id,v_theme_id,'Quelle méthode sauvegarde l''état de l''Activity ?','medium','SINGLE_CHOICE','onSaveInstanceState() sauvegarde l''état avant destruction.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','onSaveInstanceState()',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','onRestoreInstanceState()',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','onPause()',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','onStop()',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-ACT-009') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='activities_et_fragments' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-ACT-009',v_cert_id,v_theme_id,'Où restaurer l''état sauvegardé ?','medium','SINGLE_CHOICE','Le Bundle est disponible dans onCreate() ou onRestoreInstanceState().','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','onCreate() ou onRestoreInstanceState()',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','onStart()',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','onResume()',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','onRestart()',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-ACT-010') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='activities_et_fragments' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-ACT-010',v_cert_id,v_theme_id,'Que se passe-t-il en mode paysage ?','hard','SINGLE_CHOICE','La configuration change, l''Activity est recréée.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','L''Activity est détruite et recréée',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','L''Activity est mise en pause',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','L''Activity est arrêtée',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Rien ne change',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-ACT-011') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='activities_et_fragments' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-ACT-011',v_cert_id,v_theme_id,'Comment démarrer une autre Activity ?','easy','SINGLE_CHOICE','startActivity() démarre une nouvelle Activity.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','startActivity(intent)',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','start(intent)',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','launchActivity(intent)',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','beginActivity(intent)',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-ACT-012') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='activities_et_fragments' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-ACT-012',v_cert_id,v_theme_id,'Comment passer des données à une Activity ?','easy','SINGLE_CHOICE','putExtra() ajoute des données à l''Intent.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','intent.putExtra("key", value)',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','intent.setData(value)',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','intent.addExtra("key", value)',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','intent.setExtra("key", value)',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-ACT-013') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='activities_et_fragments' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-ACT-013',v_cert_id,v_theme_id,'Comment récupérer les données d''un Intent ?','easy','SINGLE_CHOICE','getStringExtra() ou getExtras().','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','getIntent().getStringExtra("key")',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','getData()',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','getExtras()',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A et C',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-ACT-014') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='activities_et_fragments' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-ACT-014',v_cert_id,v_theme_id,'Qu''est-ce qu''un Intent explicite ?','medium','SINGLE_CHOICE','Intent explicite = new Intent(this, Target.class).','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Nomme la classe cible',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Décrit l''action à effectuer',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Est implicite',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Ne spécifie pas la cible',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-ACT-015') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='activities_et_fragments' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-ACT-015',v_cert_id,v_theme_id,'Qu''est-ce qu''un Intent implicite ?','medium','SINGLE_CHOICE','Intent implicite = new Intent(Intent.ACTION_VIEW, uri).','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Décrit l''action (ACTION_VIEW)',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Nomme la classe',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Est explicite',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Ne fonctionne pas',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-ACT-016') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='activities_et_fragments' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-ACT-016',v_cert_id,v_theme_id,'Comment obtenir un résultat d''une Activity ?','hard','SINGLE_CHOICE','API moderne (Activity Result API) ou ancienne.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','startActivityForResult()',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','registerForActivityResult()',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','onActivityResult()',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-ACT-017') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='activities_et_fragments' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-ACT-017',v_cert_id,v_theme_id,'À quoi sert un Fragment ?','easy','SINGLE_CHOICE','Les Fragments sont des composants UI réutilisables.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','UI réutilisable',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Activity alternative',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Service',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','BroadcastReceiver',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-ACT-018') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='activities_et_fragments' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-ACT-018',v_cert_id,v_theme_id,'Quelle méthode est appelée pour créer la vue d''un Fragment ?','easy','SINGLE_CHOICE','onCreateView() retourne la vue du Fragment.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','onCreateView()',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','onCreate()',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','onViewCreated()',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','onStart()',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-ACT-019') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='activities_et_fragments' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-ACT-019',v_cert_id,v_theme_id,'Comment ajouter un Fragment dynamiquement ?','medium','SINGLE_CHOICE','FragmentTransaction avec add/replace.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','FragmentTransaction',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','add()',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','replace()',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-ACT-020') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='activities_et_fragments' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-ACT-020',v_cert_id,v_theme_id,'Comment communiquer entre Fragments ?','hard','SINGLE_CHOICE','Plusieurs patterns de communication.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','ViewModel partagé',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Activity comme interface',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','EventBus',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-CMP-001') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='jetpack_compose' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-CMP-001',v_cert_id,v_theme_id,'Qu''est-ce que Jetpack Compose ?','easy','SINGLE_CHOICE','Jetpack Compose est le nouveau toolkit UI déclaratif d''Android.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','UI toolkit déclaratif pour Android',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Base de données',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Bibliothèque réseau',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Framework de test',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-CMP-002') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='jetpack_compose' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-CMP-002',v_cert_id,v_theme_id,'Quelle annotation marque une fonction composable ?','easy','SINGLE_CHOICE','@Composable est l''annotation pour les fonctions UI Compose.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','@Composable',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','@Compose',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','@UI',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','@Component',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-CMP-003') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='jetpack_compose' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-CMP-003',v_cert_id,v_theme_id,'Comment afficher du texte avec Compose ?','easy','SINGLE_CHOICE','Text() est le composable pour afficher du texte.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Text("Hello")',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','TextView("Hello")',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Label("Hello")',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Paragraph("Hello")',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-CMP-004') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='jetpack_compose' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-CMP-004',v_cert_id,v_theme_id,'Comment créer un bouton avec Compose ?','easy','SINGLE_CHOICE','Button() prend un onClick lambda et un contenu.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Button(onClick = {}) { Text("Click") }',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Button(text = "Click")',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Clickable(text = "Click")',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Touchable("Click")',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-CMP-005') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='jetpack_compose' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-CMP-005',v_cert_id,v_theme_id,'Comment organiser des éléments verticalement ?','medium','SINGLE_CHOICE','Column arrange les enfants verticalement.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Column',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Row',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Box',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','LinearLayout',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-CMP-006') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='jetpack_compose' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-CMP-006',v_cert_id,v_theme_id,'Comment organiser des éléments horizontalement ?','medium','SINGLE_CHOICE','Row arrange les enfants horizontalement.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Row',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Column',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Box',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','LinearLayout',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-CMP-007') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='jetpack_compose' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-CMP-007',v_cert_id,v_theme_id,'À quoi sert Box ?','medium','SINGLE_CHOICE','Box superpose ses enfants les uns sur les autres.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Superposer des éléments',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Organiser verticalement',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Organiser horizontalement',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Scroll',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-CMP-008') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='jetpack_compose' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-CMP-008',v_cert_id,v_theme_id,'Comment déclarer un état mutable dans Compose ?','medium','SINGLE_CHOICE','remember { mutableStateOf() } préserve l''état à travers les recompositions.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','var text by remember { mutableStateOf("") }',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','var text = mutableStateOf("")',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','val text = remember { "" }',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','var text = stateOf("")',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-CMP-009') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='jetpack_compose' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-CMP-009',v_cert_id,v_theme_id,'Que fait rememberSaveable ?','hard','SINGLE_CHOICE','rememberSaveable survit aux changements de configuration.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Sauvegarde l''état après rotation',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Cache l''état',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Optimise les performances',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Partage l''état',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-CMP-010') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='jetpack_compose' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-CMP-010',v_cert_id,v_theme_id,'Comment déclencher une recomposition ?','hard','SINGLE_CHOICE','La modification d''une variable State déclenche la recomposition.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Modifier une variable State',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Appeler invalidate()',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Recompose()',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','refresh()',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-CMP-011') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='jetpack_compose' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-CMP-011',v_cert_id,v_theme_id,'À quoi sert Modifier ?','medium','SINGLE_CHOICE','Modifier permet de configurer padding, taille, clic, etc.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Personnaliser l''apparence et le comportement',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Créer des animations',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Gérer l''état',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Naviguer',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-CMP-012') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='jetpack_compose' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-CMP-012',v_cert_id,v_theme_id,'Comment ajouter un padding à un composable ?','easy','SINGLE_CHOICE','padding() ajoute un espacement intérieur.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Modifier.padding(16.dp)',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Modifier.padding(16)',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Modifier.offset(16.dp)',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Modifier.margin(16.dp)',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-CMP-013') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='jetpack_compose' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-CMP-013',v_cert_id,v_theme_id,'Comment rendre un élément cliquable ?','easy','SINGLE_CHOICE','clickable() rend l''élément cliquable.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Modifier.clickable { }',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Modifier.onClick { }',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Modifier.tap { }',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Modifier.press { }',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-CMP-014') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='jetpack_compose' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-CMP-014',v_cert_id,v_theme_id,'Comment chaîner plusieurs modificateurs ?','hard','SINGLE_CHOICE','Les modificateurs se chaînent avec l''opérateur point.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Modifier.padding(16.dp).clickable { }',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Modifier.padding(16.dp) then Modifier.clickable { }',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Modifier(padding = 16.dp, clickable = true)',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Modifier.combine(padding(16.dp), clickable { })',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-CMP-015') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='jetpack_compose' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-CMP-015',v_cert_id,v_theme_id,'Comment définir le thème d''une application Compose ?','easy','SINGLE_CHOICE','MaterialTheme est le composable de thème Material Design.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','MaterialTheme { }',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','ComposeTheme { }',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','AndroidTheme { }',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','DesignTheme { }',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-CMP-016') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='jetpack_compose' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-CMP-016',v_cert_id,v_theme_id,'Comment accéder aux couleurs du thème ?','hard','SINGLE_CHOICE','MaterialTheme.colors donne accès aux couleurs.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','MaterialTheme.colors.primary',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','LocalColors.current.primary',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Theme.colors.primary',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Colors.primary',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-CMP-017') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='jetpack_compose' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-CMP-017',v_cert_id,v_theme_id,'Comment créer un thème personnalisé ?','hard','SINGLE_CHOICE','MaterialTheme accepte un paramètre colors personnalisé.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','MaterialTheme(colors = customColors)',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','ComposeTheme(colors = customColors)',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Theme(colors = customColors)',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','CustomTheme(colors = customColors)',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-CMP-018') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='jetpack_compose' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-CMP-018',v_cert_id,v_theme_id,'Quelle bibliothèque utilise-t-on pour la navigation Compose ?','hard','SINGLE_CHOICE','androidx.navigation.compose est la bibliothèque officielle.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','navigation-compose',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','compose-navigation',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','androidx.navigation.compose',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A et C',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-CMP-019') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='jetpack_compose' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-CMP-019',v_cert_id,v_theme_id,'Comment créer un NavController ?','hard','SINGLE_CHOICE','rememberNavController() crée un NavController pour la navigation.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','rememberNavController()',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','NavController()',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','createNavController()',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','getNavController()',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-CMP-020') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='jetpack_compose' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-CMP-020',v_cert_id,v_theme_id,'Comment naviguer vers un écran ?','hard','SINGLE_CHOICE','navigate() change l''écran courant.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','navController.navigate("screen")',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','navController.goTo("screen")',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','navController.push("screen")',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','navController.forward("screen")',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-CMP-021') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='jetpack_compose' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-CMP-021',v_cert_id,v_theme_id,'Quel composable affiche une liste verticale ?','medium','SINGLE_CHOICE','LazyColumn affiche une liste avec chargement paresseux.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','LazyColumn',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Column',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','ListView',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','VerticalList',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-CMP-022') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='jetpack_compose' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-CMP-022',v_cert_id,v_theme_id,'Quelle est la différence entre Column et LazyColumn ?','medium','SINGLE_CHOICE','LazyColumn ne compose que les éléments visibles.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','LazyColumn charge paresseusement',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Column est plus rapide',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','LazyColumn est déprécié',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Column charge paresseusement',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-CMP-023') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='jetpack_compose' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-CMP-023',v_cert_id,v_theme_id,'Comment itérer sur une liste avec LazyColumn ?','hard','SINGLE_CHOICE','items() est la DSL pour itérer dans LazyColumn.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','items(list) { item -> Text(item) }',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','for (item in list) { Text(item) }',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','list.forEach { Text(it) }',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','LazyColumn(list) { Text(it) }',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-CMP-024') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='jetpack_compose' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-CMP-024',v_cert_id,v_theme_id,'Comment créer une animation de fondu ?','hard','SINGLE_CHOICE','AnimatedVisibility anime l''apparition/disparition.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','AnimatedVisibility { }',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','FadeAnimation { }',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Transition { }',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','animateFade { }',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-CMP-025') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='jetpack_compose' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-CMP-025',v_cert_id,v_theme_id,'Comment animer une valeur ?','hard','SINGLE_CHOICE','animateFloatAsState() anime un Float vers une cible.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','animateFloatAsState()',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','animateFloat()',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','floatAnimation()',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','animValue()',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-CMP-026') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='jetpack_compose' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-CMP-026',v_cert_id,v_theme_id,'Comment afficher une boîte de dialogue ?','hard','SINGLE_CHOICE','AlertDialog et Dialog sont disponibles.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','AlertDialog { }',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Dialog { }',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Popup { }',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A et B',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-CMP-027') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='jetpack_compose' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-CMP-027',v_cert_id,v_theme_id,'À quoi sert Scaffold ?','hard','SINGLE_CHOICE','Scaffold implémente la structure Material Design.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Structure d''écran (TopBar, BottomBar, FAB)',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Base de données',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Gestion d''état',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Navigation',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-CMP-028') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='jetpack_compose' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-CMP-028',v_cert_id,v_theme_id,'Comment ajouter un TopAppBar ?','hard','SINGLE_CHOICE','topBar est un paramètre de Scaffold.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Scaffold(topBar = { TopAppBar(title = { Text("Title") }) })',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Scaffold(topBar = TopAppBar("Title"))',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','TopAppBar(title = "Title")',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','AppBar(title = "Title")',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-CMP-029') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='jetpack_compose' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-CMP-029',v_cert_id,v_theme_id,'Comment injecter un ViewModel dans Compose ?','hard','SINGLE_CHOICE','viewModel() de androidx.lifecycle:lifecycle-viewmodel-compose.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','viewModel()',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','ViewModel()',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','rememberViewModel()',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','getViewModel()',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-CMP-030') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='jetpack_compose' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-CMP-030',v_cert_id,v_theme_id,'Comment observer un LiveData dans Compose ?','hard','SINGLE_CHOICE','observeAsState() convertit LiveData en State Compose.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','observeAsState()',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','toState()',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','asState()',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','collectAsState()',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-CMP-031') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='jetpack_compose' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-CMP-031',v_cert_id,v_theme_id,'Comment observer un Flow dans Compose ?','hard','SINGLE_CHOICE','collectAsState() collecte un Flow en State.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','collectAsState()',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','observeAsState()',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','flowAsState()',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','toState()',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-CMP-032') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='jetpack_compose' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-CMP-032',v_cert_id,v_theme_id,'À quoi sert remember ?','hard','SINGLE_CHOICE','remember évite de recalculer à chaque recomposition.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Mémoriser une valeur entre recompositions',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Créer un état',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Optimiser les performances',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A et C',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-CMP-033') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='jetpack_compose' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-CMP-033',v_cert_id,v_theme_id,'À quoi sert derivedStateOf ?','hard','SINGLE_CHOICE','derivedStateOf réduit les recompositions inutiles.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Créer un état dérivé optimisé',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Créer un état mutable',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Créer un état immuable',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Créer un état global',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-CMP-034') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='jetpack_compose' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-CMP-034',v_cert_id,v_theme_id,'Que fait @Stable ?','hard','SINGLE_CHOICE','@Stable aide le compilateur à optimiser les recompositions.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Indique qu''un type est stable',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Optimise les recompositions',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Évite les recalculs',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-CMP-035') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='jetpack_compose' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-CMP-035',v_cert_id,v_theme_id,'Comment tester un composable ?','hard','SINGLE_CHOICE','Plusieurs règles de test pour Compose.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','ComposeTestRule',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','createComposeRule()',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','AndroidComposeTestRule',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-CMP-036') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='jetpack_compose' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-CMP-036',v_cert_id,v_theme_id,'Comment vérifier qu''un texte est affiché ?','hard','SINGLE_CHOICE','onNodeWithText trouve un nœud par son texte.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','onNodeWithText("Hello").assertExists()',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','findText("Hello").assertExists()',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','checkText("Hello")',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','assertText("Hello")',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-CMP-037') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='jetpack_compose' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-CMP-037',v_cert_id,v_theme_id,'Quelle annotation affiche un aperçu ?','hard','SINGLE_CHOICE','@Preview génère un aperçu dans l''IDE.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','@Preview',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','@Show',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','@Display',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','@View',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-CMP-038') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='jetpack_compose' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-CMP-038',v_cert_id,v_theme_id,'Comment prévisualiser plusieurs thèmes ?','hard','SINGLE_CHOICE','uiMode permet de prévisualiser le mode nuit.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','@Preview(uiMode = Configuration.UI_MODE_NIGHT_YES)',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','@Preview(theme = "dark")',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','@Preview(darkMode = true)',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','@Preview(night = true)',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-CMP-039') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='jetpack_compose' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-CMP-039',v_cert_id,v_theme_id,'Comment utiliser une vue Android dans Compose ?','hard','SINGLE_CHOICE','AndroidView intègre des vues traditionnelles.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','AndroidView { context -> TextView(context) }',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','ComposeView { TextView(context) }',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','ViewBinding { TextView() }',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','LegacyView { TextView() }',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-CMP-040') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='jetpack_compose' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-CMP-040',v_cert_id,v_theme_id,'Comment utiliser Compose dans une vue traditionnelle ?','hard','SINGLE_CHOICE','ComposeView contient du contenu Compose.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','ComposeView',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','AndroidComposeView',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','ComposeViewHolder',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','ComposeLayout',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-CMP-041') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='jetpack_compose' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-CMP-041',v_cert_id,v_theme_id,'Comment gérer les encoches (notch) ?','hard','SINGLE_CHOICE','WindowInsets gère les zones système (barre d''état, navigation).','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','WindowInsets',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','DisplayCutout',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','EdgeInsets',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','SafeArea',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-CMP-042') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='jetpack_compose' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-CMP-042',v_cert_id,v_theme_id,'Comment ignorer les insets système ?','hard','SINGLE_CHOICE','systemBarsPadding() ajoute le padding des barres système.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Modifier.systemBarsPadding()',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Modifier.ignoreInsets()',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Modifier.noInsets()',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Modifier.fullScreen()',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-CMP-043') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='jetpack_compose' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-CMP-043',v_cert_id,v_theme_id,'Comment détecter un tap ?','hard','SINGLE_CHOICE','clickable ou pointerInput avec detectTapGestures.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Modifier.pointerInput(Unit) { detectTapGestures { } }',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Modifier.clickable { }',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Modifier.tap { }',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A et B',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-CMP-044') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='jetpack_compose' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-CMP-044',v_cert_id,v_theme_id,'Comment détecter un swipe ?','hard','SINGLE_CHOICE','draggable ou detectDragGestures pour le glisser.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Modifier.swipeable()',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Modifier.draggable()',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Modifier.pointerInput { detectDragGestures { } }',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','B et C',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-CMP-045') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='jetpack_compose' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-CMP-045',v_cert_id,v_theme_id,'Comment dessiner des formes personnalisées ?','hard','SINGLE_CHOICE','Canvas avec DrawScope permet le dessin personnalisé.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Canvas',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','DrawScope',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','GraphicsLayer',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A et B',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-CMP-046') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='jetpack_compose' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-CMP-046',v_cert_id,v_theme_id,'Comment appliquer un coin arrondi ?','hard','SINGLE_CHOICE','clip() avec RoundedCornerShape arrondit les coins.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Modifier.clip(RoundedCornerShape(8.dp))',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Modifier.rounded(8.dp)',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Modifier.corner(8.dp)',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Modifier.borderRadius(8.dp)',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-CMP-047') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='jetpack_compose' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-CMP-047',v_cert_id,v_theme_id,'Comment ajouter une description pour l''accessibilité ?','hard','SINGLE_CHOICE','semantics avec contentDescription pour TalkBack.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Modifier.semantics { contentDescription = "..." }',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Modifier.accessibility("...")',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Modifier.describe("...")',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Modifier.contentDescription("...")',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-CMP-048') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='jetpack_compose' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-CMP-048',v_cert_id,v_theme_id,'Comment rendre un élément focusable ?','hard','SINGLE_CHOICE','focusable() permet la navigation au clavier/D-pad.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Modifier.focusable()',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Modifier.canFocus()',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Modifier.focus()',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Modifier.tabIndex()',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-CMP-049') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='jetpack_compose' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-CMP-049',v_cert_id,v_theme_id,'Les fonctions composables doivent-elles être suspend ?','hard','SINGLE_CHOICE','Les composables sont synchrones, pour les async utiliser LaunchedEffect.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Non, elles sont synchrones',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Oui, toujours',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Oui, pour les effets',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Non, jamais',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-CMP-050') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='jetpack_compose' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-CMP-050',v_cert_id,v_theme_id,'Où placer les side-effects ?','hard','SINGLE_CHOICE','Les effets doivent être dans LaunchedEffect ou DisposableEffect.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','LaunchedEffect, DisposableEffect',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Dans le composable directement',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Dans ViewModel',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Dans un Flow',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-CMP-051') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='jetpack_compose' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-CMP-051',v_cert_id,v_theme_id,'Quelle est la convention de nommage pour les composables ?','hard','SINGLE_CHOICE','Les fonctions composables utilisent PascalCase.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','PascalCase',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','camelCase',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','snake_case',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','UPPER_CASE',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-CMP-052') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='jetpack_compose' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-CMP-052',v_cert_id,v_theme_id,'Peut-on migrer progressivement vers Compose ?','hard','SINGLE_CHOICE','Migration progressive possible (écran ou composant).','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Oui, composable par composable',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Non, migration totale',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Oui, écran par écran',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A et C',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-CMP-053') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='jetpack_compose' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-CMP-053',v_cert_id,v_theme_id,'Qu''est-ce que le state hoisting ?','hard','SINGLE_CHOICE','Le state hoisting place l''état dans le parent pour le rendre réutilisable.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Remonter l''état au parent',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Descendre l''état',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Partager l''état',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Cacher l''état',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-CMP-054') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='jetpack_compose' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-CMP-054',v_cert_id,v_theme_id,'Quel pattern utilise le state hoisting ?','hard','SINGLE_CHOICE','Le state hoisting est un pattern UDF (Unidirectional Data Flow).','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Unidirectional Data Flow',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','MVP',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','MVC',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','MVVM',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-CMP-055') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='jetpack_compose' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-CMP-055',v_cert_id,v_theme_id,'Qu''est-ce que la recomposition ?','hard','SINGLE_CHOICE','La recomposition ré-exécute les composables quand l''état change.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Re-exécution des composables',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Re-création de l''Activity',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Re-chargement du thème',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Re-démarrage de l''app',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-CMP-056') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='jetpack_compose' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-CMP-056',v_cert_id,v_theme_id,'Quand la recomposition se déclenche-t-elle ?','hard','SINGLE_CHOICE','La recomposition est déclenchée par les changements d''état.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Quand une variable State change',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','À intervalle régulier',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Au redémarrage',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','À la création',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-CMP-057') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='jetpack_compose' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-CMP-057',v_cert_id,v_theme_id,'À quoi sert Modifier.composed ?','hard','SINGLE_CHOICE','composed permet de créer des modificateurs qui dépendent de l''état.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Créer des modificateurs avec état',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Composer plusieurs modificateurs',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Optimiser les performances',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Debugger les modificateurs',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-CMP-058') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='jetpack_compose' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-CMP-058',v_cert_id,v_theme_id,'Comment créer un layout personnalisé ?','hard','SINGLE_CHOICE','Layout avec MeasurePolicy permet des layouts personnalisés.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Layout composable',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','CustomLayout',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','MeasurePolicy',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A et C',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-CMP-059') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='jetpack_compose' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-CMP-059',v_cert_id,v_theme_id,'Quelle fonction mesure et place les enfants ?','hard','SINGLE_CHOICE','MeasureScope fournit les méthodes de mesure et placement.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','MeasureScope.measure',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Layout.measure',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','SubcomposeLayout',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','BoxWithConstraints',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-CMP-060') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='jetpack_compose' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-CMP-060',v_cert_id,v_theme_id,'À quoi sert SubcomposeLayout ?','hard','SINGLE_CHOICE','SubcomposeLayout permet de composer les enfants paresseusement.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Composition paresseuse des enfants',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Layout imbriqué',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Animation',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Optimisation mémoire',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-ARCH-001') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='architecture_mvvm_viewmodel' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-ARCH-001',v_cert_id,v_theme_id,'Que signifie MVVM ?','medium','SINGLE_CHOICE','MVVM est le pattern d''architecture recommandé par Google.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Model-View-ViewModel',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Model-View-ViewManager',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Model-View-ViewModule',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Model-View-VirtualMachine',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-ARCH-002') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='architecture_mvvm_viewmodel' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-ARCH-002',v_cert_id,v_theme_id,'Quel est le rôle du ViewModel dans MVVM ?','medium','SINGLE_CHOICE','Le ViewModel expose les données à l''UI et survit aux changements de configuration.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Préparer et gérer les données pour l''UI',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Afficher l''interface',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Accéder à la base de données',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Gérer les permissions',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-ARCH-003') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='architecture_mvvm_viewmodel' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-ARCH-003',v_cert_id,v_theme_id,'Quelle classe étendre pour créer un ViewModel ?','easy','SINGLE_CHOICE','ViewModel ou AndroidViewModel (avec Context).','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','ViewModel',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','AndroidViewModel',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','LifecycleViewModel',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A ou B',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-ARCH-004') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='architecture_mvvm_viewmodel' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-ARCH-004',v_cert_id,v_theme_id,'Comment obtenir un ViewModel dans une Activity ?','easy','SINGLE_CHOICE','ViewModelProvider avec le propriétaire (Activity/Fragment).','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','ViewModelProvider(this).get(MyViewModel::class.java)',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','ViewModel(this).get(MyViewModel.class)',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','getViewModel(MyViewModel.class)',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','createViewModel(MyViewModel.class)',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-ARCH-005') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='architecture_mvvm_viewmodel' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-ARCH-005',v_cert_id,v_theme_id,'Un ViewModel survit-il à la rotation de l''écran ?','hard','SINGLE_CHOICE','Le ViewModel survit aux changements de configuration.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Oui',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Uniquement avec SavedState',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Uniquement si configuré',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-ARCH-006') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='architecture_mvvm_viewmodel' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-ARCH-006',v_cert_id,v_theme_id,'Quand un ViewModel est-il détruit ?','hard','SINGLE_CHOICE','Le ViewModel est détruit quand l''Activity est finie (finish()).','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Quand l''Activity est finie',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','À la rotation',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','À la pause',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','À l''arrêt',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-ARCH-007') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='architecture_mvvm_viewmodel' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-ARCH-007',v_cert_id,v_theme_id,'Qu''est-ce que LiveData ?','easy','SINGLE_CHOICE','LiveData est un observable qui respecte le cycle de vie.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Observateur de données lifecycle-aware',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Base de données',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Cache',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Service',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-ARCH-008') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='architecture_mvvm_viewmodel' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-ARCH-008',v_cert_id,v_theme_id,'Comment observer une LiveData ?','easy','SINGLE_CHOICE','observe() attache un observateur respectueux du cycle de vie.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','liveData.observe(this) { value -> }',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','liveData.subscribe(this) { value -> }',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','liveData.watch(this) { value -> }',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','liveData.listen(this) { value -> }',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-ARCH-009') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='architecture_mvvm_viewmodel' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-ARCH-009',v_cert_id,v_theme_id,'Que se passe-t-il si on observe LiveData depuis une Activity détruite ?','medium','SINGLE_CHOICE','LiveData ne notifie pas les observateurs avec un Lifecycle détruit.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Pas de notification',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Exception',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Notification quand même',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Crash',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-ARCH-010') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='architecture_mvvm_viewmodel' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-ARCH-010',v_cert_id,v_theme_id,'Comment mettre à jour une LiveData depuis un background thread ?','hard','SINGLE_CHOICE','postValue() est thread-safe, setValue() doit être appelé sur main thread.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','postValue()',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','setValue()',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','updateValue()',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','changeValue()',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-ARCH-011') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='architecture_mvvm_viewmodel' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-ARCH-011',v_cert_id,v_theme_id,'Différence entre setValue() et postValue() ?','hard','SINGLE_CHOICE','postValue() peut être appelé depuis un thread background.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','setValue() sur main thread, postValue() sur n''importe quel thread',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Identiques',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','setValue() sur background, postValue() sur main',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','postValue() déprécié',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-ARCH-012') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='architecture_mvvm_viewmodel' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-ARCH-012',v_cert_id,v_theme_id,'Qu''est-ce que StateFlow ?','hard','SINGLE_CHOICE','StateFlow est un Flow qui expose un état courant.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Flow avec état initial',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','LiveData alternative',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Flow sans état',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','SharedFlow',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-ARCH-013') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='architecture_mvvm_viewmodel' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-ARCH-013',v_cert_id,v_theme_id,'Comment créer un StateFlow ?','hard','SINGLE_CHOICE','MutableStateFlow prend une valeur initiale.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','MutableStateFlow(initialValue)',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','StateFlow.of(initialValue)',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','flowOf(initialValue)',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','stateFlow(initialValue)',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-ARCH-014') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='architecture_mvvm_viewmodel' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-ARCH-014',v_cert_id,v_theme_id,'Avantage de StateFlow sur LiveData ?','hard','SINGLE_CHOICE','StateFlow offre plus de flexibilité avec les coroutines.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Plus d''opérateurs (map, filter)',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Meilleure intégration coroutines',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Testable',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-ARCH-015') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='architecture_mvvm_viewmodel' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-ARCH-015',v_cert_id,v_theme_id,'Quel est le rôle du Repository ?','medium','SINGLE_CHOICE','Le Repository est une source unique de vérité pour les données.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Centraliser l''accès aux données',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Afficher l''interface',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Gérer le cycle de vie',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Naviguer entre écrans',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-ARCH-016') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='architecture_mvvm_viewmodel' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-ARCH-016',v_cert_id,v_theme_id,'Que doit faire un Repository ?','hard','SINGLE_CHOICE','Le Repository gère les sources de données.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Décider source (cache/network)',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Exposer des Flow/LiveData',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Gérer les erreurs',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-ARCH-017') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='architecture_mvvm_viewmodel' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-ARCH-017',v_cert_id,v_theme_id,'Qu''est-ce qu''un UseCase ?','hard','SINGLE_CHOICE','Un UseCase représente une seule action métier.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Encapsule une action métier',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Base de données',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','ViewModel',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Fragment',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-ARCH-018') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='architecture_mvvm_viewmodel' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-ARCH-018',v_cert_id,v_theme_id,'Où placer la logique métier ?','hard','SINGLE_CHOICE','La logique métier va dans les UseCases.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Dans les UseCases',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Dans le ViewModel',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Dans le Repository',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Dans l''Activity',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-ARCH-019') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='architecture_mvvm_viewmodel' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-ARCH-019',v_cert_id,v_theme_id,'Comment lancer une coroutine dans un ViewModel ?','hard','SINGLE_CHOICE','viewModelScope est lié au cycle de vie du ViewModel.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','viewModelScope.launch { }',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','GlobalScope.launch { }',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','lifecycleScope.launch { }',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','coroutineScope.launch { }',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-ARCH-020') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='architecture_mvvm_viewmodel' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-ARCH-020',v_cert_id,v_theme_id,'Que se passe-t-il si viewModelScope est annulé ?','hard','SINGLE_CHOICE','viewModelScope annule ses coroutines quand le ViewModel est détruit.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Toutes les coroutines enfants sont annulées',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Rien',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Erreur',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Redémarrage',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-ARCH-021') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='architecture_mvvm_viewmodel' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-ARCH-021',v_cert_id,v_theme_id,'Quelle bibliothèque d''injection est recommandée par Google ?','hard','SINGLE_CHOICE','Hilt (basé sur Dagger) est recommandé pour Android.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Hilt',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Dagger 2',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Koin',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A et B',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-ARCH-022') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='architecture_mvvm_viewmodel' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-ARCH-022',v_cert_id,v_theme_id,'Quelle annotation marque une classe pour injection Hilt ?','hard','SINGLE_CHOICE','@HiltViewModel marque un ViewModel pour injection.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','@Inject',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','@Provides',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','@Binds',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','@HiltViewModel',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-ARCH-023') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='architecture_mvvm_viewmodel' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-ARCH-023',v_cert_id,v_theme_id,'Quelle annotation active Hilt dans l''application ?','hard','SINGLE_CHOICE','@HiltAndroidApp sur la classe Application active Hilt.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','@HiltAndroidApp',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','@EnableHilt',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','@HiltApplication',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','@AndroidEntryPoint',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-ARCH-024') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='architecture_mvvm_viewmodel' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-ARCH-024',v_cert_id,v_theme_id,'Qu''est-ce que Navigation Component ?','hard','SINGLE_CHOICE','Navigation Component simplifie la navigation entre écrans.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Bibliothèque de navigation',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Base de données',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Cache',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Service',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-ARCH-025') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='architecture_mvvm_viewmodel' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-ARCH-025',v_cert_id,v_theme_id,'Où sont définies les destinations de navigation ?','hard','SINGLE_CHOICE','Le graphe de navigation est défini dans un fichier XML.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','nav_graph.xml',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','navigation.xml',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','destinations.xml',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','routes.xml',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-ARCH-026') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='architecture_mvvm_viewmodel' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-ARCH-026',v_cert_id,v_theme_id,'À quoi sert WorkManager ?','hard','SINGLE_CHOICE','WorkManager exécute des tâches différées garanties.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Tâches asynchrones garanties',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Navigation',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Base de données',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','UI',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-ARCH-027') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='architecture_mvvm_viewmodel' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-ARCH-027',v_cert_id,v_theme_id,'Quand utiliser WorkManager plutôt que Coroutines ?','hard','SINGLE_CHOICE','WorkManager garantit l''exécution même en cas d''arrêt de l''app.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Tâches garanties (même après redémarrage)',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Tâches UI',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Tâches rapides',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Tâches réactives',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-ARCH-028') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='architecture_mvvm_viewmodel' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-ARCH-028',v_cert_id,v_theme_id,'Comment créer un worker ?','hard','SINGLE_CHOICE','Worker (thread Java) ou CoroutineWorker (Kotlin).','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','class MyWorker : Worker()',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','class MyWorker : CoroutineWorker()',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','class MyWorker : ListenableWorker()',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A ou B',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-ARCH-029') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='architecture_mvvm_viewmodel' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-ARCH-029',v_cert_id,v_theme_id,'Qu''est-ce que DataBinding ?','hard','SINGLE_CHOICE','DataBinding lie directement les données aux vues XML.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Liaison déclarative UI/data',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Base de données',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Service',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Cache',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-ARCH-030') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='architecture_mvvm_viewmodel' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-ARCH-030',v_cert_id,v_theme_id,'Différence entre DataBinding et ViewBinding ?','hard','SINGLE_CHOICE','DataBinding est plus puissant, ViewBinding plus simple et rapide.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','DataBinding supporte les expressions',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','ViewBinding plus rapide',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','DataBinding plus complet',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-ARCH-031') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='architecture_mvvm_viewmodel' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-ARCH-031',v_cert_id,v_theme_id,'À quoi sert SavedStateHandle ?','hard','SINGLE_CHOICE','SavedStateHandle sauvegarde l''état du ViewModel après destruction.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Sauvegarder l''état du ViewModel',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Naviguer',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Injecter',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Logger',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-ARCH-032') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='architecture_mvvm_viewmodel' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-ARCH-032',v_cert_id,v_theme_id,'Comment injecter SavedStateHandle ?','hard','SINGLE_CHOICE','SavedStateHandle peut être injecté via le constructeur.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','ViewModel(savedStateHandle)',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','@Inject constructor(handle: SavedStateHandle)',TRUE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','SavedStateHandleProvider',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','getSavedStateHandle()',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-ARCH-033') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='architecture_mvvm_viewmodel' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-ARCH-033',v_cert_id,v_theme_id,'Comment tester un ViewModel ?','hard','SINGLE_CHOICE','Les règles pour coroutines et LiveData sont nécessaires.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','InstantTaskExecutorRule',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','MainDispatcherRule',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Un test JUnit classique',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A et B',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-ARCH-034') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='architecture_mvvm_viewmodel' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-ARCH-034',v_cert_id,v_theme_id,'Comment observer une LiveData dans un test ?','hard','SINGLE_CHOICE','observeForever() ou l''API Observer.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Observer',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','getValue()',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','observeForever',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A et C',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-ARCH-035') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='architecture_mvvm_viewmodel' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-ARCH-035',v_cert_id,v_theme_id,'Quelles sont les couches de Clean Architecture ?','hard','SINGLE_CHOICE','Clean Architecture sépare en couches Data, Domain, Presentation.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Data, Domain, Presentation',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Model, View, Controller',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','UI, Business, Data',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Entity, UseCase, Repository',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-ARCH-036') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='architecture_mvvm_viewmodel' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-ARCH-036',v_cert_id,v_theme_id,'Que contient la couche Domain ?','hard','SINGLE_CHOICE','La couche Domain contient la logique métier.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','UseCases et Entities',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','UI',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Base de données',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','API',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-ARCH-037') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='architecture_mvvm_viewmodel' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-ARCH-037',v_cert_id,v_theme_id,'Que signifie MVI ?','hard','SINGLE_CHOICE','MVI est un pattern avec des intents unidirectionnels.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Model-View-Intent',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Model-View-Interface',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Model-View-Interaction',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Model-View-Input',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-ARCH-038') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='architecture_mvvm_viewmodel' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-ARCH-038',v_cert_id,v_theme_id,'Différence principale MVI vs MVVM ?','hard','SINGLE_CHOICE','MVI a un seul état immuable (State).','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','MVI a un état unique',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','MVVM a un état unique',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','MVI a plusieurs états',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Identiques',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-ARCH-039') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='architecture_mvvm_viewmodel' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-ARCH-039',v_cert_id,v_theme_id,'À quoi sert Paging 3 ?','hard','SINGLE_CHOICE','Paging 3 simplifie le chargement paginé des données.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Pagination des données',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Base de données',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Cache',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Network',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-ARCH-040') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='architecture_mvvm_viewmodel' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-ARCH-040',v_cert_id,v_theme_id,'Quel type retourne un PagingSource ?','hard','SINGLE_CHOICE','LoadResult.Page ou LoadResult.Error.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','LoadResult',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','PagingData',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','PagingSourceResult',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Page',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-ARCH-041') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='architecture_mvvm_viewmodel' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-ARCH-041',v_cert_id,v_theme_id,'Room est une abstraction sur quelle API ?','hard','SINGLE_CHOICE','Room est une couche d''abstraction sur SQLite.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','SQLite',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Realm',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','ObjectBox',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Firebase',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-ARCH-042') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='architecture_mvvm_viewmodel' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-ARCH-042',v_cert_id,v_theme_id,'Quelle annotation marque une base de données Room ?','hard','SINGLE_CHOICE','@Database sur une classe abstraite étendant RoomDatabase.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','@Database',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','@RoomDatabase',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','@DB',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','@EntityDatabase',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-ARCH-043') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='architecture_mvvm_viewmodel' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-ARCH-043',v_cert_id,v_theme_id,'Comment migrer une base Room ?','hard','SINGLE_CHOICE','Plusieurs options pour les migrations.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Migration',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','AddMigrations',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','fallbackToDestructiveMigration',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-ARCH-044') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='architecture_mvvm_viewmodel' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-ARCH-044',v_cert_id,v_theme_id,'Qu''est-ce que Retrofit ?','hard','SINGLE_CHOICE','Retrofit est un client HTTP typé pour les API REST.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Client HTTP pour API REST',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Base de données',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Cache',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Sérialisation',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-ARCH-045') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='architecture_mvvm_viewmodel' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-ARCH-045',v_cert_id,v_theme_id,'Comment définir une API Retrofit ?','hard','SINGLE_CHOICE','Les APIs sont définies dans des interfaces avec des annotations.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','interface ApiService { @GET("path") suspend fun get(): Response }',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','class ApiService { @GET }',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','abstract class ApiService',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','object ApiService',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-ARCH-046') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='architecture_mvvm_viewmodel' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-ARCH-046',v_cert_id,v_theme_id,'Comment créer une instance Retrofit ?','hard','SINGLE_CHOICE','Builder pattern pour configurer Retrofit.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Retrofit.Builder().baseUrl().build()',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Retrofit.create()',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','new Retrofit()',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','RetrofitClient()',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-ARCH-047') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='architecture_mvvm_viewmodel' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-ARCH-047',v_cert_id,v_theme_id,'À quoi sert OkHttp ?','hard','SINGLE_CHOICE','OkHttp est le client HTTP utilisé par Retrofit.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Client HTTP sous-jacent',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Base de données',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Cache',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Sérialisation',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-ARCH-048') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='architecture_mvvm_viewmodel' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-ARCH-048',v_cert_id,v_theme_id,'Comment ajouter un header à toutes les requêtes ?','hard','SINGLE_CHOICE','Un Interceptor personnalisé peut ajouter des headers.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Interceptor',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','addHeader()',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','HeaderInterceptor',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','NetworkInterceptor',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-ARCH-049') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='architecture_mvvm_viewmodel' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-ARCH-049',v_cert_id,v_theme_id,'À quoi sert Moshi ?','hard','SINGLE_CHOICE','Moshi est un parseur JSON pour Kotlin/Java.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','JSON parsing',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Base de données',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Cache',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Network',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-ARCH-050') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='architecture_mvvm_viewmodel' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-ARCH-050',v_cert_id,v_theme_id,'Quelle annotation marque une classe pour Kotlin Serialization ?','hard','SINGLE_CHOICE','@Serializable est l''annotation de kotlinx.serialization.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','@Serializable',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','@Serialize',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','@JsonSerializable',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','@KSerializable',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-ARCH-051') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='architecture_mvvm_viewmodel' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-ARCH-051',v_cert_id,v_theme_id,'À quoi sert Preferences DataStore ?','hard','SINGLE_CHOICE','Preferences DataStore remplace SharedPreferences.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Stockage de paires clé-valeur',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Base de données',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Cache réseau',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Logs',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-ARCH-052') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='architecture_mvvm_viewmodel' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-ARCH-052',v_cert_id,v_theme_id,'Comment lire une valeur depuis DataStore ?','hard','SINGLE_CHOICE','dataStore.data retourne un Flow avec les données.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','dataStore.data.map { it[KEY] }',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','dataStore.getValue(KEY)',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','dataStore.get(KEY)',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','dataStore.read(KEY)',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-ARCH-053') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='architecture_mvvm_viewmodel' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-ARCH-053',v_cert_id,v_theme_id,'Différence entre Preferences et Proto DataStore ?','hard','SINGLE_CHOICE','Proto DataStore utilise des schémas protobuf.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Proto utilise des protobufs',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Preferences plus rapide',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Proto plus lent',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Identiques',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-ARCH-054') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='architecture_mvvm_viewmodel' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-ARCH-054',v_cert_id,v_theme_id,'À quoi sert LeakCanary ?','hard','SINGLE_CHOICE','LeakCanary détecte automatiquement les fuites mémoire.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Détection de memory leaks',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Base de données',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Cache',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Logging',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-ARCH-055') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='architecture_mvvm_viewmodel' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-ARCH-055',v_cert_id,v_theme_id,'À quoi sert Timber ?','hard','SINGLE_CHOICE','Timber est une API de logging avec plantage des arbres.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Logging moderne',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Base de données',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Cache',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Network',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-ARCH-056') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='architecture_mvvm_viewmodel' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-ARCH-056',v_cert_id,v_theme_id,'À quoi sert Coil ?','hard','SINGLE_CHOICE','Coil charge des images depuis des URLs.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Chargement d''images',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Base de données',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Cache',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Network',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-ARCH-057') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='architecture_mvvm_viewmodel' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-ARCH-057',v_cert_id,v_theme_id,'Glide vs Coil, quelle différence ?','hard','SINGLE_CHOICE','Coil est natif Kotlin, plus moderne.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Coil est écrit en Kotlin',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Glide plus ancien',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Coil plus moderne',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-ARCH-058') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='architecture_mvvm_viewmodel' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-ARCH-058',v_cert_id,v_theme_id,'Comment ajouter une colonne à une table Room ?','hard','SINGLE_CHOICE','Migration ou fallbackToDestructiveMigration.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','@Entity modification + Migration',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Recreate database',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','ALTER TABLE manuel',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A ou C',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-ARCH-059') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='architecture_mvvm_viewmodel' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-ARCH-059',v_cert_id,v_theme_id,'Comment définir une relation one-to-many dans Room ?','hard','SINGLE_CHOICE','@Relation avec @ForeignKey pour les contraintes.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','@Relation',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','@ForeignKey',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','@Embedded',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A et B',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-ARCH-060') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='architecture_mvvm_viewmodel' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-ARCH-060',v_cert_id,v_theme_id,'Comment exécuter une transaction Room ?','hard','SINGLE_CHOICE','@Transaction sur méthode DAO ou runInTransaction.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','@Transaction',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','runInTransaction',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','transaction { }',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A et B',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-DS-001') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='data_storage' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-DS-001',v_cert_id,v_theme_id,'À quoi sert SharedPreferences ?','easy','SINGLE_CHOICE','SharedPreferences est pour les données simples (préférences utilisateur).','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Stocker des paires clé-valeur simples',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Stocker des fichiers',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Stocker des images',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Stocker des vidéos',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-DS-002') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='data_storage' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-DS-002',v_cert_id,v_theme_id,'Comment obtenir une instance de SharedPreferences ?','easy','SINGLE_CHOICE','Deux méthodes : nommée ou par défaut.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','getSharedPreferences("name", MODE_PRIVATE)',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','PreferenceManager.getDefaultSharedPreferences(this)',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','SharedPreferences.getInstance()',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A et B',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-DS-003') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='data_storage' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-DS-003',v_cert_id,v_theme_id,'Comment écrire dans SharedPreferences ?','medium','SINGLE_CHOICE','edit() puis apply() ou commit().','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','edit().putString("key", "value").apply()',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','putString("key", "value")',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','writeString("key", "value")',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','setString("key", "value")',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-DS-004') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='data_storage' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-DS-004',v_cert_id,v_theme_id,'Différence entre apply() et commit() ?','medium','SINGLE_CHOICE','apply() est asynchrone et plus rapide.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','apply() asynchrone, commit() synchrone',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','apply() synchrone, commit() asynchrone',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Identiques',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','apply() déprécié',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-DS-005') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='data_storage' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-DS-005',v_cert_id,v_theme_id,'SharedPreferences est-il thread-safe ?','hard','SINGLE_CHOICE','SharedPreferences est thread-safe.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Oui',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Uniquement en mode multi-process',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Uniquement en mode single-process',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-DS-006') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='data_storage' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-DS-006',v_cert_id,v_theme_id,'Qu''est-ce que Preferences DataStore ?','hard','SINGLE_CHOICE','DataStore utilise Kotlin coroutines et Flow.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Alternative moderne à SharedPreferences',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Base de données',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Cache',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','File storage',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-DS-007') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='data_storage' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-DS-007',v_cert_id,v_theme_id,'Comment créer un Preferences DataStore ?','hard','SINGLE_CHOICE','preferencesDataStore délégué pour créer l''instance.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','preferencesDataStore(name)',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','DataStore.preferences(name)',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','PreferencesDataStore.create(name)',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','createDataStore(name)',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-DS-008') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='data_storage' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-DS-008',v_cert_id,v_theme_id,'Comment lire des données depuis DataStore ?','hard','SINGLE_CHOICE','dataStore.data retourne un Flow avec les données.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','dataStore.data.map { it[KEY] }',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','dataStore.getValue(KEY)',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','dataStore.get(KEY)',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','dataStore.read(KEY)',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-DS-009') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='data_storage' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-DS-009',v_cert_id,v_theme_id,'Comment écrire dans DataStore ?','hard','SINGLE_CHOICE','edit() est la méthode pour modifier les données.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','dataStore.edit { it[KEY] = value }',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','dataStore.put(KEY, value)',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','dataStore.write(KEY, value)',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','dataStore.set(KEY, value)',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-DS-010') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='data_storage' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-DS-010',v_cert_id,v_theme_id,'Qu''est-ce que Proto DataStore ?','hard','SINGLE_CHOICE','Proto DataStore utilise des messages protobuf typés.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','DataStore avec schémas protobuf',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Base de données relationnelle',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Cache mémoire',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','File storage',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-DS-011') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='data_storage' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-DS-011',v_cert_id,v_theme_id,'Qu''est-ce que Room ?','easy','SINGLE_CHOICE','Room est une couche d''abstraction sur SQLite.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','ORM pour SQLite',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Base de données NoSQL',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Cache',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','File storage',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-DS-012') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='data_storage' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-DS-012',v_cert_id,v_theme_id,'Quelle annotation marque une entité Room ?','easy','SINGLE_CHOICE','@Entity définit une table dans la base.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','@Entity',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','@Table',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','@Database',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','@Column',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-DS-013') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='data_storage' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-DS-013',v_cert_id,v_theme_id,'Quelle annotation marque la clé primaire ?','easy','SINGLE_CHOICE','@PrimaryKey définit la clé primaire.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','@PrimaryKey',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','@Id',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','@Key',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','@Primary',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-DS-014') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='data_storage' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-DS-014',v_cert_id,v_theme_id,'Quelle annotation marque une colonne ?','medium','SINGLE_CHOICE','@ColumnInfo personnalise le nom de colonne.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','@ColumnInfo',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','@Column',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','@Field',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','@Property',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-DS-015') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='data_storage' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-DS-015',v_cert_id,v_theme_id,'Quelle annotation marque un DAO ?','medium','SINGLE_CHOICE','@Dao définit les méthodes d''accès aux données.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','@Dao',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','@Repository',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','@Database',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','@Query',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-DS-016') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='data_storage' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-DS-016',v_cert_id,v_theme_id,'Quelle annotation marque une requête SQL ?','medium','SINGLE_CHOICE','@Query exécute une requête SQL.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','@Query',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','@SQL',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','@Select',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','@RawQuery',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-DS-017') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='data_storage' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-DS-017',v_cert_id,v_theme_id,'Comment Room gère-t-il les migrations ?','hard','SINGLE_CHOICE','Plusieurs options pour les migrations.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Migration class',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','addMigrations()',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','fallbackToDestructiveMigration()',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-DS-018') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='data_storage' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-DS-018',v_cert_id,v_theme_id,'Que fait @Transaction ?','hard','SINGLE_CHOICE','@Transaction garantit l''atomicité des opérations.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Exécute en une seule transaction',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Annule la transaction',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Crée une transaction',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Ferme la transaction',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-DS-019') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='data_storage' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-DS-019',v_cert_id,v_theme_id,'Comment définir une relation one-to-many dans Room ?','hard','SINGLE_CHOICE','@Relation avec @ForeignKey pour les contraintes.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','@Relation',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','@ForeignKey',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','@Embedded',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A et B',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-DS-020') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='data_storage' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-DS-020',v_cert_id,v_theme_id,'Que fait @Embedded ?','hard','SINGLE_CHOICE','@Embedded décompose un objet en plusieurs colonnes.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Inclut les champs d''un objet',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Crée une relation',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Définit une clé',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Crée un index',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-DS-021') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='data_storage' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-DS-021',v_cert_id,v_theme_id,'Comment Room gère-t-il les types complexes ?','hard','SINGLE_CHOICE','TypeConverter convertit les types personnalisés.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','TypeConverter',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','TypeAdapter',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','TypeMapper',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','TypeSerializer',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-DS-022') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='data_storage' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-DS-022',v_cert_id,v_theme_id,'Comment observer les changements en base ?','hard','SINGLE_CHOICE','Room supporte LiveData, Flow et RxJava.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','LiveData ou Flow',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','RxJava',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Callback',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A et B',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-DS-023') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='data_storage' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-DS-023',v_cert_id,v_theme_id,'Room utilise quelle base de données sous-jacente ?','hard','SINGLE_CHOICE','Room est une abstraction sur SQLite.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','SQLite',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','MySQL',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','PostgreSQL',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Realm',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-DS-024') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='data_storage' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-DS-024',v_cert_id,v_theme_id,'Où sont stockés les fichiers internes ?','easy','SINGLE_CHOICE','getFilesDir() pour les fichiers privés de l''app.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','getFilesDir()',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','getExternalFilesDir()',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','getCacheDir()',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','getDataDir()',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-DS-025') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='data_storage' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-DS-025',v_cert_id,v_theme_id,'Les fichiers internes sont-ils accessibles par d''autres apps ?','medium','SINGLE_CHOICE','Les fichiers internes sont privés à l''application.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Non, privés',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Oui',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Uniquement en root',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Uniquement si partagés',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-DS-026') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='data_storage' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-DS-026',v_cert_id,v_theme_id,'Comment accéder au stockage externe ?','easy','SINGLE_CHOICE','getExternalFilesDir() et getExternalCacheDir() sont recommandés.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','getExternalFilesDir()',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','getExternalStorageDirectory()',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','getExternalCacheDir()',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A et C',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-DS-027') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='data_storage' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-DS-027',v_cert_id,v_theme_id,'Quelle permission est nécessaire pour le stockage externe ?','hard','SINGLE_CHOICE','Permissions pour accéder aux fichiers externes.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','READ_EXTERNAL_STORAGE / WRITE_EXTERNAL_STORAGE',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','ACCESS_EXTERNAL_STORAGE',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','STORAGE_PERMISSION',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','FILE_ACCESS',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-DS-028') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='data_storage' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-DS-028',v_cert_id,v_theme_id,'Qu''est-ce que le Scoped Storage ?','hard','SINGLE_CHOICE','Scoped Storage limite l''accès aux fichiers de l''app.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Accès limité au stockage externe',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Accès complet au stockage',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Suppression du stockage',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Stockage chiffré',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-DS-029') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='data_storage' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-DS-029',v_cert_id,v_theme_id,'Comment accéder au cache de l''application ?','easy','SINGLE_CHOICE','cacheDir pour cache interne, externalCacheDir pour externe.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','cacheDir',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','getCacheDir()',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','externalCacheDir',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-DS-030') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='data_storage' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-DS-030',v_cert_id,v_theme_id,'Le cache est-il automatiquement supprimé ?','medium','SINGLE_CHOICE','Le système peut vider le cache en cas d''espace faible.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Oui, par le système',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Non, manuellement',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Uniquement au redémarrage',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Uniquement si espace faible',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-DS-031') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='data_storage' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-DS-031',v_cert_id,v_theme_id,'Quand utiliser DataStore plutôt que Room ?','hard','SINGLE_CHOICE','DataStore pour les préférences, Room pour les données structurées.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Données simples, petites quantités',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Données complexes, grandes quantités',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Relations entre données',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Requêtes complexes',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-DS-032') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='data_storage' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-DS-032',v_cert_id,v_theme_id,'Qu''est-ce que Realm ?','hard','SINGLE_CHOICE','Realm est une base de données mobile objet.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Base de données mobile',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','ORM',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Alternative à SQLite',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-DS-033') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='data_storage' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-DS-033',v_cert_id,v_theme_id,'Qu''est-ce que ObjectBox ?','hard','SINGLE_CHOICE','ObjectBox est une base de données NoSQL haute performance.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Base de données NoSQL',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','ORM',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Alternative à Room',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-DS-034') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='data_storage' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-DS-034',v_cert_id,v_theme_id,'Comment écrire un fichier ?','medium','SINGLE_CHOICE','FileOutputStream ou Files.write() en Kotlin.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','FileOutputStream',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','writeText()',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Files.write()',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A et C',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-DS-035') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='data_storage' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-DS-035',v_cert_id,v_theme_id,'Comment lire un fichier ?','medium','SINGLE_CHOICE','Plusieurs méthodes pour lire des fichiers.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','FileInputStream',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','readText()',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Files.readAllBytes()',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-DS-036') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='data_storage' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-DS-036',v_cert_id,v_theme_id,'Où placer les fichiers assets ?','hard','SINGLE_CHOICE','Les assets sont dans le dossier assets.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','src/main/assets',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','src/main/res/raw',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','src/main/resources',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','src/main/files',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-DS-037') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='data_storage' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-DS-037',v_cert_id,v_theme_id,'Comment lire un fichier asset ?','hard','SINGLE_CHOICE','getAssets().open() donne un InputStream.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','assets.open("file.txt")',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','getAssets().open("file.txt")',TRUE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','openAsset("file.txt")',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','readAsset("file.txt")',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-DS-038') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='data_storage' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-DS-038',v_cert_id,v_theme_id,'Où placer les fichiers raw ?','hard','SINGLE_CHOICE','Les fichiers raw sont dans res/raw.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','res/raw',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','res/assets',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','res/files',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','res/data',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-DS-039') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='data_storage' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-DS-039',v_cert_id,v_theme_id,'Comment accéder à un fichier raw ?','hard','SINGLE_CHOICE','L''ID et la méthode openRawResource.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','R.raw.filename',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','getResources().openRawResource(R.raw.filename)',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','openRawResource(R.raw.filename)',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A et B',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-DS-040') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='data_storage' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-DS-040',v_cert_id,v_theme_id,'À quoi sert un ContentProvider ?','hard','SINGLE_CHOICE','ContentProvider permet le partage de données.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Partager des données entre apps',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Stocker des données',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Cacher des données',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Chiffrer des données',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-DS-041') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='data_storage' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-DS-041',v_cert_id,v_theme_id,'Quelles méthodes doit implémenter un ContentProvider ?','hard','SINGLE_CHOICE','Les 5 méthodes CRUD de base.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','query, insert, update, delete, getType',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','select, insert, update, delete',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','read, write, update, delete',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','get, set, update, delete',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-DS-042') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='data_storage' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-DS-042',v_cert_id,v_theme_id,'À quoi sert MediaStore ?','hard','SINGLE_CHOICE','MediaStore donne accès aux médias de l''appareil.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Accéder aux médias (images, vidéos, audio)',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Stocker des médias',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Supprimer des médias',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Encoder des médias',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-DS-043') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='data_storage' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-DS-043',v_cert_id,v_theme_id,'Quelle permission est nécessaire pour MediaStore ?','hard','SINGLE_CHOICE','Permissions granulaires selon le type de média.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','READ_MEDIA_IMAGES, READ_MEDIA_VIDEO, READ_MEDIA_AUDIO',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','READ_EXTERNAL_STORAGE',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','ACCESS_MEDIA',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','MEDIA_PERMISSION',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-DS-044') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='data_storage' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-DS-044',v_cert_id,v_theme_id,'À quoi sert SAF ?','hard','SINGLE_CHOICE','SAF permet à l''utilisateur de choisir des documents.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Accès aux documents via un sélecteur',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Accès direct aux fichiers',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Stockage chiffré',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Backup',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-DS-045') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='data_storage' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-DS-045',v_cert_id,v_theme_id,'Comment lancer le sélecteur SAF ?','hard','SINGLE_CHOICE','ACTION_OPEN_DOCUMENT ou ACTION_GET_CONTENT.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Intent(ACTION_OPEN_DOCUMENT)',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Intent(ACTION_GET_CONTENT)',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Intent(ACTION_PICK)',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A et B',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-DS-046') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='data_storage' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-DS-046',v_cert_id,v_theme_id,'Comment chiffrer une base Room ?','hard','SINGLE_CHOICE','SQLCipher avec Room pour base chiffrée.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','SQLCipher',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Room avec support SQLCipher',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Android Keystore',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A et B',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-DS-047') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='data_storage' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-DS-047',v_cert_id,v_theme_id,'Comment activer le backup Auto Backup ?','hard','SINGLE_CHOICE','allowBackup et fullBackupContent.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','android:allowBackup="true"',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','android:fullBackupContent',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','BackupAgent',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A et B',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-DS-048') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='data_storage' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-DS-048',v_cert_id,v_theme_id,'Quelles données sont sauvegardées automatiquement ?','hard','SINGLE_CHOICE','Les données internes sont sauvegardées.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','SharedPreferences, fichiers internes, base Room',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Fichiers externes',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Cache',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Assets',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-DS-049') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='data_storage' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-DS-049',v_cert_id,v_theme_id,'Comment tester une base Room ?','hard','SINGLE_CHOICE','inMemoryDatabaseBuilder pour base en mémoire.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','InMemoryDatabase',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','createDatabaseBuilder',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Room.inMemoryDatabaseBuilder',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A et C',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-DS-050') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='data_storage' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-DS-050',v_cert_id,v_theme_id,'Comment tester les migrations Room ?','hard','SINGLE_CHOICE','MigrationTestHelper de androidx.room.testing.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','MigrationTestHelper',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','testMigrations()',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','runMigrationsTest()',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','verifyMigrations()',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-DS-051') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='data_storage' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-DS-051',v_cert_id,v_theme_id,'Quelles sont les deux principales avantages de Room Database ?','medium','SINGLE_CHOICE','Room Database offre une gestion simplifiée de la base de données SQLite et facilite l''intégration avec Firebase. Bien que Room assure une certaine sécurité des données, ce n''est pas son principal avantage. L''encapsulation des données n''est pas spécifiquement une fonctionnalité de Room.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Supporte l''encapsulation des données',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Permet une gestion simplifiée de la base de données SQLite',TRUE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Facilite l''intégration avec Firebase',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Assure la sécurité des données',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-DS-052') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='data_storage' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-DS-052',v_cert_id,v_theme_id,'Comment accéder à une instance de SharedPreferences ?','easy','SINGLE_CHOICE','Deux méthodes sont disponibles pour accéder à une instance de SharedPreferences : par nom ou par défaut. Les options A et B sont correctes, tandis que C est incorrecte car elle fait référence à une méthode qui n''existe pas.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','SharedPreferences.getInstance()',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','getSharedPreferences("name", MODE_PRIVATE)',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','PreferenceManager.getDefaultSharedPreferences(this)',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A et B',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-DS-053') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='data_storage' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-DS-053',v_cert_id,v_theme_id,'Quelles sont les deux principales différences entre Scoped Storage et Legacy Storage ?','hard','SINGLE_CHOICE','Scoped Storage est plus sécurisé car il limite l''accès aux fichiers à l''application. Legacy Storage, en revanche, permet un accès plus large aux fichiers et nécessite des permissions spécifiques pour certaines opérations. L''option B est incorrecte car Scoped Storage ne permet pas l''accès direct aux fichiers des autres applications, contrairement à Legacy Storage.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Scoped Storage est plus sécurisé',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Scoped Storage permet l''accès direct aux fichiers des autres applications',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Legacy Storage est plus performant',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Scoped Storage nécessite une déclaration explicite des permissions',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-DS-054') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='data_storage' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-DS-054',v_cert_id,v_theme_id,'Quelle méthode est utilisée pour récupérer des données à partir d''un ContentProvider ?','medium','SINGLE_CHOICE','La méthode query() est utilisée pour récupérer des données à partir d''un ContentProvider. Les autres méthodes (insert(), update(), delete()) sont utilisées pour effectuer des opérations de modification des données.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','query()',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','insert()',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','update()',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','delete()',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-DS-055') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='data_storage' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-DS-055',v_cert_id,v_theme_id,'Quelles sont les deux principales façons de crypter une base de données dans Android ?','hard','SINGLE_CHOICE','SQLCipher et Realm avec encryption sont deux principales façons de crypter une base de données dans Android. SharedPreferences ne supporte pas la cryptage des données, et crypter les données à l''application niveau n''est généralement pas une solution sécurisée pour la base de données.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Utiliser SQLCipher',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Crypter les données à l''application niveau',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Utiliser Realm avec encryption',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Utiliser SharedPreferences',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-DS-056') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='data_storage' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-DS-056',v_cert_id,v_theme_id,'Sélectionnez TOUTES les affirmations correctes concernant Room Database :','medium','SINGLE_CHOICE','Room Database supporte la migration de schémas et est compatible avec SQLite, ce qui permet une intégration fluide. Elle n''est pas limitée aux fichiers externes et peut utiliser LiveData pour les requêtes asynchrones, mais cela n''est pas une exigence.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Supporte la migration de schémas',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Peut être utilisé avec des fichiers externes',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Nécessite l''utilisation de LiveData pour les requêtes asynchrones',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Supporte la rétrocompatibilité avec SQLite',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-DS-057') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='data_storage' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-DS-057',v_cert_id,v_theme_id,'Quelle est la méthode correcte pour obtenir une instance de SharedPreferences ?','easy','SINGLE_CHOICE','Les deux méthodes A et B sont correctes pour obtenir une instance de SharedPreferences. La méthode C n''existe pas.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','getSharedPreferences("name", MODE_PRIVATE)',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','PreferenceManager.getDefaultSharedPreferences(this)',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','SharedPreferences.getInstance()',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A et B',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-DS-058') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='data_storage' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-DS-058',v_cert_id,v_theme_id,'Quelles sont les DEUX propositions vraies concernant Internal Storage :','hard','SINGLE_CHOICE','Internal Storage est accessible uniquement par l''application qui l''a créée et supporte la lecture et l''écriture. Le contenu n''est pas visible dans le système de fichiers externe et ne peut pas être partagé avec d''autres applications.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Accessible uniquement par l''application qui l''a créée',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Peut être partagé avec d''autres applications',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Le contenu est visible dans le système de fichiers externe',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Supporte la lecture et l''écriture',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-DS-059') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='data_storage' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-DS-059',v_cert_id,v_theme_id,'Quelle est la principale différence entre Scoped Storage et External Storage ?','medium','SINGLE_CHOICE','Scoped Storage est plus sécurisé car il limite l''accès aux fichiers à l''application qui les a créées, tandis que External Storage permet un accès global aux fichiers.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Scoped Storage est plus sécurisé',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','External Storage permet un accès global aux fichiers',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Scoped Storage ne supporte pas les permissions',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','External Storage est plus rapide',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-DS-060') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='data_storage' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-DS-060',v_cert_id,v_theme_id,'Sélectionnez TOUTES les affirmations correctes concernant la cryptage de bases de données :','hard','SINGLE_CHOICE','Room Database supporte la cryptage nativement et peut être utilisé avec SQLite. La nécessité d''une bibliothèque externe dépend de la complexité requise, mais Room offre des options intégrées. Le cryptage n''est pas nécessairement recommandé pour des applications de petite taille, mais il peut être utilisé selon les besoins en sécurité.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Nécessite l''utilisation d''une bibliothèque externe',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Supporté nativement par Room Database',TRUE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Peut être utilisé avec SQLite',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','N''est pas recommandé pour des applications de petite taille',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-DS-061') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='data_storage' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-DS-061',v_cert_id,v_theme_id,'Sélectionnez TOUTES les affirmations correctes concernant Room Database :','medium','SINGLE_CHOICE','Room est effectivement une bibliothèque de persistance des données pour Android, ce qui fait de l''option A correcte. La migration automatique est également supportée par Room, ce qui rend l''option B correcte. Room permet d''écrire des requêtes SQL complexes, ce qui justifie l''option C comme correcte. En revanche, Room supporte en réalité la synchronisation avec Firebase via des bibliothèques complémentaires, donc l''option D est incorrecte.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Room est une bibliothèque de persistance des données pour les applications Android',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Room prend en charge la migration automatique des bases de données',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Room permet d''écrire des requêtes SQL complexes',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Room ne supporte pas la synchronisation avec Firebase',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-DS-062') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='data_storage' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-DS-062',v_cert_id,v_theme_id,'Quelle méthode est utilisée pour obtenir une instance de SharedPreferences ?','easy','SINGLE_CHOICE','Deux méthodes permettent d''obtenir une instance de SharedPreferences : getSharedPreferences("name", MODE_PRIVATE) pour un fichier nommé, et PreferenceManager.getDefaultSharedPreferences(this) pour le fichier par défaut. Donc, l''option A et B est correcte.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','getSharedPreferences("name", MODE_PRIVATE)',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','PreferenceManager.getDefaultSharedPreferences(this)',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','SharedPreferences.getInstance()',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A et B',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-DS-063') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='data_storage' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-DS-063',v_cert_id,v_theme_id,'Quelles sont les DEUX propositions vraies concernant Scoped Storage ?','hard','SINGLE_CHOICE','Scoped Storage est effectivement introduit dans Android 10, ce qui fait de l''option A correcte. Cette fonctionnalité améliore la sécurité en limitant l''accès aux fichiers, ce qui justifie l''option C comme correcte. En revanche, Scoped Storage ne permet pas d''accéder directement aux fichiers des autres applications et est activé par défaut, donc les options B et D sont incorrectes.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Scoped Storage est disponible à partir d''Android 10',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Scoped Storage permet l''accès direct aux fichiers des autres applications',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Scoped Storage améliore la sécurité en limitant l''accès aux fichiers',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Scoped Storage est désactivé par défaut',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-DS-064') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='data_storage' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-DS-064',v_cert_id,v_theme_id,'Quelle méthode est utilisée pour accéder aux données d''un ContentProvider ?','medium','SINGLE_CHOICE','Deux méthodes permettent d''accéder aux données d''un ContentProvider : getContentResolver().query() et ContentProvider.query(). Donc, l''option A et B est correcte.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','getContentResolver().query()',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','ContentProvider.query()',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Context.getContentProvider()',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A et B',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-DS-065') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='data_storage' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-DS-065',v_cert_id,v_theme_id,'Quelles sont les DEUX propositions vraies concernant la cryptage de base de données ?','hard','SINGLE_CHOICE','La cryptage de base de données est effectivement supportée par Room, ce qui fait de l''option A correcte. Room utilise SQLCipher pour la cryptage, ce qui justifie l''option C comme correcte. En revanche, SQLite ne supporte pas la cryptage automatique et la cryptage de base de données ne peut pas être désactivée, donc les options B et D sont incorrectes.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','La cryptage de base de données est supportée par Room',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','La cryptage de base de données est automatique avec SQLite',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Room utilise SQLCipher pour la cryptage',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','La cryptage de base de données peut être désactivée',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-DS-066') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='data_storage' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-DS-066',v_cert_id,v_theme_id,'Sélectionnez TOUTES les affirmations correctes concernant Room Database :','medium','SINGLE_CHOICE','Room est effectivement une abstraction sur SQLite, ce qui facilite son utilisation. Elle permet de créer des requêtes SQL complexes grâce à l''annotation @Query. Bien que Room offre des fonctionnalités pour gérer les relations entre entités, il est possible de migrer une base de données avec Room en définissant des classes Migration. Donc, l''option C est incorrecte.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Room est une abstraction sur SQLite',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Room permet de créer des requêtes SQL complexes',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Room ne supporte pas la migration de base de données',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Room offre des fonctionnalités pour gérer les relations entre entités',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-DS-067') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='data_storage' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-DS-067',v_cert_id,v_theme_id,'Quelle méthode est utilisée pour obtenir une instance de SharedPreferences ?','easy','SINGLE_CHOICE','Deux méthodes peuvent être utilisées pour obtenir une instance de SharedPreferences : getSharedPreferences("name", MODE_PRIVATE) pour une préférence nommée, ou PreferenceManager.getDefaultSharedPreferences(this) pour les préférences par défaut. Donc, l''option A et B est correcte.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','getSharedPreferences("name", MODE_PRIVATE)',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','PreferenceManager.getDefaultSharedPreferences(this)',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','SharedPreferences.getInstance()',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A et B',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-DS-068') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='data_storage' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-DS-068',v_cert_id,v_theme_id,'Quelles sont les DEUX principales différences entre Scoped Storage et External Storage ?','hard','SINGLE_CHOICE','Scoped Storage offre une meilleure sécurité des fichiers en limitant l''accès aux applications. External Storage permet un accès direct aux fichiers de l''utilisateur, ce qui n''est pas possible avec Scoped Storage. Les autres options sont incorrectes : Scoped Storage est disponible à partir d''Android 10, et il nécessite des permissions spécifiques pour accéder aux fichiers.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Scoped Storage est disponible sur toutes les versions d''Android',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Scoped Storage offre une meilleure sécurité des fichiers',TRUE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','External Storage permet un accès direct aux fichiers de l''utilisateur',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Scoped Storage ne nécessite pas de permissions spécifiques',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-NET-001') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='networking' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-NET-001',v_cert_id,v_theme_id,'Qu''est-ce que Retrofit ?','easy','SINGLE_CHOICE','Retrofit est un client HTTP typé.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Client HTTP pour API REST',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Base de données',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Cache',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Sérialisation',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-NET-002') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='networking' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-NET-002',v_cert_id,v_theme_id,'Quelle annotation pour une requête GET ?','easy','SINGLE_CHOICE','@GET définit une requête HTTP GET.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','@GET',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','@HTTP',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','@Request',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','@Fetch',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-NET-003') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='networking' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-NET-003',v_cert_id,v_theme_id,'Quelle annotation pour une requête POST ?','easy','SINGLE_CHOICE','@POST définit une requête HTTP POST.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','@POST',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','@PUT',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','@PATCH',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','@DELETE',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-NET-004') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='networking' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-NET-004',v_cert_id,v_theme_id,'Quelle annotation pour le corps de la requête ?','easy','SINGLE_CHOICE','@Body envoie un objet dans le corps de la requête.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','@Body',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','@Field',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','@Query',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','@Part',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-NET-005') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='networking' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-NET-005',v_cert_id,v_theme_id,'Quelle annotation pour un paramètre d''URL ?','easy','SINGLE_CHOICE','@Path remplace une variable dans l''URL.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','@Path',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','@Query',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','@Field',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','@Body',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-NET-006') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='networking' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-NET-006',v_cert_id,v_theme_id,'Quelle annotation pour un paramètre de requête ?','easy','SINGLE_CHOICE','@Query ajoute un paramètre ?key=value.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','@Query',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','@Path',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','@Field',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','@Body',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-NET-007') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='networking' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-NET-007',v_cert_id,v_theme_id,'Comment créer une instance Retrofit ?','medium','SINGLE_CHOICE','Builder pattern pour configurer Retrofit.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Retrofit.Builder().baseUrl(url).build()',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','new Retrofit(url)',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Retrofit.create(url)',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','RetrofitClient(url)',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-NET-008') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='networking' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-NET-008',v_cert_id,v_theme_id,'Comment créer l''interface API ?','medium','SINGLE_CHOICE','create() génère l''implémentation de l''interface.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','retrofit.create(ApiService::class.java)',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','retrofit.get(ApiService.class)',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','retrofit.build(ApiService.class)',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','retrofit.new(ApiService.class)',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-NET-009') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='networking' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-NET-009',v_cert_id,v_theme_id,'Comment ajouter un convertisseur JSON ?','hard','SINGLE_CHOICE','addConverterFactory ajoute le convertisseur.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','addConverterFactory(GsonConverterFactory.create())',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','addConverter(JsonConverter)',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','setConverter(GsonConverter)',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','registerConverter(GsonConverter)',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-NET-010') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='networking' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-NET-010',v_cert_id,v_theme_id,'Comment rendre une méthode Retrofit suspend ?','hard','SINGLE_CHOICE','suspend ou Deferred pour coroutines.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','suspend fun getData(): Response',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','fun getData(): Deferred<Response>',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','fun getData(): Call<Response>',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A ou B',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-NET-011') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='networking' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-NET-011',v_cert_id,v_theme_id,'À quoi sert OkHttp ?','hard','SINGLE_CHOICE','OkHttp est le client HTTP utilisé par Retrofit.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Client HTTP sous-jacent',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Base de données',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Cache',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Sérialisation',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-NET-012') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='networking' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-NET-012',v_cert_id,v_theme_id,'Comment ajouter un Interceptor ?','hard','SINGLE_CHOICE','addInterceptor ou addNetworkInterceptor.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','OkHttpClient.Builder().addInterceptor(interceptor)',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','client.interceptor(interceptor)',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','addNetworkInterceptor(interceptor)',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A et C',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-NET-013') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='networking' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-NET-013',v_cert_id,v_theme_id,'Différence entre Interceptor et NetworkInterceptor ?','hard','SINGLE_CHOICE','NetworkInterceptor est plus bas niveau.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','NetworkInterceptor voit la réponse brute',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Interceptor voit la réponse traitée',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Identiques',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A et B',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-NET-014') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='networking' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-NET-014',v_cert_id,v_theme_id,'Qu''est-ce que Moshi ?','hard','SINGLE_CHOICE','Moshi est un parseur JSON pour Kotlin/Java.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Parseur JSON',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Base de données',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Cache',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Network',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-NET-015') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='networking' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-NET-015',v_cert_id,v_theme_id,'Comment créer un adaptateur personnalisé Moshi ?','hard','SINGLE_CHOICE','@Json ou TypeAdapter personnalisé.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','@Json qualifier',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','JsonAdapter',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','TypeAdapter',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A et C',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-NET-016') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='networking' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-NET-016',v_cert_id,v_theme_id,'Quelle annotation pour la sérialisation Kotlin ?','hard','SINGLE_CHOICE','@Serializable de kotlinx.serialization.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','@Serializable',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','@Serialize',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','@JsonSerializable',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','@KSerializable',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-NET-017') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='networking' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-NET-017',v_cert_id,v_theme_id,'Comment utiliser Kotlin Serialization avec Retrofit ?','hard','SINGLE_CHOICE','Json.asConverterFactory() crée le convertisseur.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','addConverterFactory(Json.asConverterFactory())',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','setSerializer(Json)',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','useKotlinSerialization()',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','enableKotlinSerialization()',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-NET-018') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='networking' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-NET-018',v_cert_id,v_theme_id,'Qu''est-ce que Volley ?','hard','SINGLE_CHOICE','Volley est une bibliothèque réseau de Google.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Bibliothèque réseau Google',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Base de données',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Cache',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Sérialisation',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-NET-019') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='networking' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-NET-019',v_cert_id,v_theme_id,'Avantage de Retrofit sur Volley ?','hard','SINGLE_CHOICE','Retrofit offre un typage fort et coroutines.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Typage fort, coroutines',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Plus simple',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Plus rapide',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Moins de code',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-NET-020') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='networking' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-NET-020',v_cert_id,v_theme_id,'Qu''est-ce que Ktor ?','hard','SINGLE_CHOICE','Ktor est un client HTTP asynchrone pour Kotlin multiplateforme.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Client HTTP multiplateforme',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Base de données',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Cache',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Sérialisation',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-NET-021') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='networking' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-NET-021',v_cert_id,v_theme_id,'Ktor est-il compatible avec Android ?','hard','SINGLE_CHOICE','Ktor fonctionne sur Android.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Oui',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Partiellement',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Encore expérimental',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-NET-022') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='networking' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-NET-022',v_cert_id,v_theme_id,'Quelle bibliothèque charge des images ?','hard','SINGLE_CHOICE','Glide, Coil, Picasso sont les bibliothèques d''images.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Glide, Coil, Picasso',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Retrofit',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','OkHttp',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Moshi',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-NET-023') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='networking' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-NET-023',v_cert_id,v_theme_id,'Comment charger une image avec Coil ?','hard','SINGLE_CHOICE','Plusieurs bibliothèques avec syntaxes différentes.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','ImageRequest.Builder(context).data(url).build()',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Glide.with(context).load(url)',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Picasso.get().load(url)',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A et B',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-NET-024') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='networking' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-NET-024',v_cert_id,v_theme_id,'Quelle est la particularité de Glide ?','hard','SINGLE_CHOICE','Glide supporte GIF, vidéo, images.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','GIF et vidéo supportés',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Seulement images',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Seulement PNG',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Seulement JPEG',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-NET-025') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='networking' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-NET-025',v_cert_id,v_theme_id,'Comment configurer le cache avec Glide ?','hard','SINGLE_CHOICE','Options de cache disque et mémoire.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','diskCacheStrategy()',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','skipMemoryCache()',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','onlyRetrieveFromCache()',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A et B',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-NET-026') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='networking' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-NET-026',v_cert_id,v_theme_id,'Comment implémenter WebSocket sur Android ?','hard','SINGLE_CHOICE','Plusieurs bibliothèques supportent WebSocket.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','OkHttp WebSocket',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Java WebSocket',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Ktor WebSocket',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-NET-027') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='networking' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-NET-027',v_cert_id,v_theme_id,'À quoi servent les SSE ?','hard','SINGLE_CHOICE','SSE permet au serveur d''envoyer des événements.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Notifications unidirectionnelles',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Notifications bidirectionnelles',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Requête HTTP classique',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Upload de fichiers',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-NET-028') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='networking' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-NET-028',v_cert_id,v_theme_id,'À quoi sert DownloadManager ?','hard','SINGLE_CHOICE','DownloadManager gère les téléchargements longs.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Téléchargement de fichiers',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Upload de fichiers',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Streaming',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','WebSocket',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-NET-029') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='networking' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-NET-029',v_cert_id,v_theme_id,'Comment lancer un téléchargement ?','hard','SINGLE_CHOICE','enqueue() met le téléchargement en file.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','DownloadManager.enqueue(request)',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','DownloadManager.start(request)',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','DownloadManager.download(request)',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','DownloadManager.execute(request)',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-NET-030') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='networking' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-NET-030',v_cert_id,v_theme_id,'Comment exécuter une tâche réseau avec WorkManager ?','hard','SINGLE_CHOICE','Contraintes réseau pour WorkManager.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','setConstraints(NetworkType.CONNECTED)',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','NetworkType.UNMETERED',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','NetworkType.NOT_ROAMING',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-NET-031') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='networking' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-NET-031',v_cert_id,v_theme_id,'Comment vérifier la connexion internet ?','hard','SINGLE_CHOICE','API Network pour la connectivité.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','ConnectivityManager',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','NetworkCapabilities',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','NetworkCallback',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-NET-032') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='networking' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-NET-032',v_cert_id,v_theme_id,'Quelle permission pour la connectivité ?','hard','SINGLE_CHOICE','Permissions pour lire l''état réseau.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','ACCESS_NETWORK_STATE',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','INTERNET',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','ACCESS_WIFI_STATE',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A et C',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-NET-033') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='networking' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-NET-033',v_cert_id,v_theme_id,'Comment implémenter des retries ?','hard','SINGLE_CHOICE','Plusieurs approches pour les retries.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Retrofit avec OkHttp interceptor',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Resilience4j',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Coroutines retry',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-NET-034') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='networking' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-NET-034',v_cert_id,v_theme_id,'Comment configurer les timeouts ?','hard','SINGLE_CHOICE','Trois types de timeouts configurables.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','OkHttpClient.Builder().connectTimeout()',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','OkHttpClient.Builder().readTimeout()',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','OkHttpClient.Builder().writeTimeout()',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-NET-035') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='networking' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-NET-035',v_cert_id,v_theme_id,'Qu''est-ce que le certificate pinning ?','hard','SINGLE_CHOICE','Pinning empêche les attaques MITM.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Fixer un certificat spécifique',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Accepter tous les certificats',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Ignorer les certificats',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Chiffrer les certificats',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-NET-036') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='networking' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-NET-036',v_cert_id,v_theme_id,'Comment implémenter certificate pinning avec OkHttp ?','hard','SINGLE_CHOICE','CertificatePinner avec les empreintes.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','CertificatePinner',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','addCertificatePinner()',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','setCertificatePinner()',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A et B',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-NET-037') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='networking' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-NET-037',v_cert_id,v_theme_id,'Que faut-il configurer pour Retrofit avec Proguard ?','hard','SINGLE_CHOICE','Règles Proguard pour Retrofit.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','-keep class retrofit2.**',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','-keepattributes Signature',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','-keepattributes *Annotation*',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-NET-038') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='networking' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-NET-038',v_cert_id,v_theme_id,'Comment tester les appels réseau ?','hard','SINGLE_CHOICE','MockWebServer simule un serveur HTTP.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','MockWebServer',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Mockito',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Retrofit mock',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A et B',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-NET-039') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='networking' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-NET-039',v_cert_id,v_theme_id,'À quoi sert MockWebServer ?','hard','SINGLE_CHOICE','MockWebServer d''OkHttp pour les tests.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Simuler un serveur HTTP',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Simuler une base de données',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Simuler un cache',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Simuler un client',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-NET-040') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='networking' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-NET-040',v_cert_id,v_theme_id,'Comment définir une réponse MockWebServer ?','hard','SINGLE_CHOICE','enqueue() ajoute une réponse simulée.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','enqueue(MockResponse().setBody("{}"))',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','addResponse(MockResponse())',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','setResponse(MockResponse())',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','sendResponse(MockResponse())',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-NET-041') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='networking' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-NET-041',v_cert_id,v_theme_id,'Où configurer la sécurité réseau ?','hard','SINGLE_CHOICE','Fichier XML et référence dans manifest.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','res/xml/network_security_config.xml',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','AndroidManifest.xml',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','build.gradle',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A et B',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-NET-042') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='networking' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-NET-042',v_cert_id,v_theme_id,'Comment autoriser le trafic HTTP (non HTTPS) ?','hard','SINGLE_CHOICE','Configuration dans security config ou manifest.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','android:usesCleartextTraffic="true"',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','cleartextTrafficPermitted="true"',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','httpEnabled="true"',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A et B',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-NET-043') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='networking' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-NET-043',v_cert_id,v_theme_id,'À quoi sert Chucker ?','hard','SINGLE_CHOICE','Chucker est un interceptor de debug pour OkHttp.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Debugging réseau',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Base de données',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Cache',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Sérialisation',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-NET-044') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='networking' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-NET-044',v_cert_id,v_theme_id,'Comment intégrer Chucker ?','hard','SINGLE_CHOICE','Interceptor selon le besoin.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','addInterceptor(ChuckerInterceptor(context))',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','addNetworkInterceptor(ChuckerInterceptor(context))',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','enableChucker()',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A ou B',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-NET-045') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='networking' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-NET-045',v_cert_id,v_theme_id,'À quoi sert Stetho ?','hard','SINGLE_CHOICE','Stetho de Facebook pour le debugging.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Debugging réseau via Chrome',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Base de données',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Cache',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Sérialisation',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-NET-046') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='networking' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-NET-046',v_cert_id,v_theme_id,'Comment activer la compression Gzip ?','hard','SINGLE_CHOICE','OkHttp gère Gzip par défaut.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','OkHttp le fait automatiquement',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','addInterceptor(GzipInterceptor)',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','enableGzip()',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A et B',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-NET-047') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='networking' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-NET-047',v_cert_id,v_theme_id,'Comment gérer l''authentification Bearer token ?','hard','SINGLE_CHOICE','Interceptor ou Authenticator pour les tokens.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Interceptor ajoutant Authorization header',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Authenticator',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','addHeader()',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A et B',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-NET-048') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='networking' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-NET-048',v_cert_id,v_theme_id,'Comment rafraîchir un token expiré ?','hard','SINGLE_CHOICE','Authenticator peut retenter avec nouveau token.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Authenticator personnalisé',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Interceptor',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Retry',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A et B',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-NET-049') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='networking' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-NET-049',v_cert_id,v_theme_id,'Comment gérer le mode hors ligne ?','hard','SINGLE_CHOICE','Plusieurs stratégies pour l''offline.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Cache réseau',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Base de données locale',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','WorkManager sync',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-NET-050') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='networking' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-NET-050',v_cert_id,v_theme_id,'Comment configurer le cache OkHttp ?','hard','SINGLE_CHOICE','Cache via OkHttpClient.Builder().','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','cache(Cache(directory, size))',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','OkHttpClient.Builder().cache(cache)',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','setCache(cache)',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A et B',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-NET-051') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='networking' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-NET-051',v_cert_id,v_theme_id,'Sélectionnez TOUTES les affirmations correctes concernant Certificate Pinning :','medium','SINGLE_CHOICE','Option A est correcte car Certificate Pinning est une méthode de sécurité utilisée pour vérifier l''identité du serveur. Option B est correcte car il protège contre les attaques man-in-the-middle en vérifiant que la réponse provient du serveur attendu. Option C est incorrecte car Certificate Pinning n''est pas utilisé pour vérifier l''identité du client. Option D est incorrecte car Certificate Pinning est recommandé dans les applications mobiles pour améliorer la sécurité.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Il s''agit d''une méthode de sécurité pour vérifier l''identité du serveur.',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Il permet de protéger contre les attaques man-in-the-middle.',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Il est utilisé pour vérifier l''identité du client.',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Il n''est pas recommandé dans les applications mobiles.',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-NET-052') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='networking' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-NET-052',v_cert_id,v_theme_id,'Quelle est la principale différence entre Volley et Retrofit ?','easy','SINGLE_CHOICE','Option B est correcte car Retrofit est généralement considéré comme plus facile à utiliser pour les requêtes complexes en raison de sa conception basée sur des interfaces. Option A est incorrecte car Volley utilise également des callbacks, mais avec une approche légèrement différente. Option C est incorrecte car Volley prend en charge la gestion des images, mais ce n''est pas une différence clé entre les deux. Option D est incorrecte car la performance peut varier selon le contexte et les configurations utilisées.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Volley utilise des callbacks, tandis que Retrofit utilise des interfaces.',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Retrofit est plus facile à utiliser pour les requêtes complexes.',TRUE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Volley prend en charge la gestion des images, tandis que Retrofit ne le fait pas.',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Retrofit est plus performant que Volley.',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-NET-053') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='networking' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-NET-053',v_cert_id,v_theme_id,'Sélectionnez TOUTES les affirmations correctes concernant Retrofit :','medium','SINGLE_CHOICE','Retrofit est effectivement un client HTTP typé pour Android, ce qui fait de l''option A correcte. L''option B est incorrecte car Retrofit prend en charge plusieurs types de requêtes HTTP, pas seulement GET. L''option C est correcte car Retrofit utilise des convertisseurs pour sérialiser et désérialiser les objets JSON. L''option D est incorrecte car Retrofit supporte les requêtes asynchrones, ce qui permet une communication non bloquante avec le serveur.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Retrofit est un client HTTP typé pour Android.',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Retrofit prend en charge uniquement les requêtes GET.',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Retrofit permet la sérialisation et la désérialisation des objets JSON.',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Retrofit ne supporte pas les requêtes asynchrones.',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-NET-054') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='networking' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-NET-054',v_cert_id,v_theme_id,'Quelle est la principale fonction d''OkHttp ?','easy','SINGLE_CHOICE','OkHttp est principalement utilisé pour gérer les requêtes réseau HTTP, ce qui rend l''option A la réponse correcte. Les autres options ne sont pas spécifiques à OkHttp : la sérialisation et désérialisation des objets JSON est généralement gérée par d''autres bibliothèques, le cache des images est géré par des bibliothèques comme Glide ou Coil, et l''authentification des utilisateurs est généralement gérée par des bibliothèques d''authentification.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Gérer les requêtes réseau HTTP.',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Sérialiser et désérialiser des objets JSON.',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Gérer les images en cache.',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Authentifier les utilisateurs.',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-NET-055') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='networking' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-NET-055',v_cert_id,v_theme_id,'Quelles sont les DEUX propositions vraies concernant Moshi :','medium','SINGLE_CHOICE','Moshi est effectivement une bibliothèque de sérialisation/désérialisation JSON, ce qui fait de l''option A correcte. L''option B est également correcte car Moshi permet la conversion des objets Java en JSON et vice versa. L''option C est incorrecte car Moshi supporte les annotations Kotlin, ce qui facilite la conversion des objets en JSON. L''option D est incorrecte car Moshi n''est pas intégré par défaut dans Retrofit, mais il peut être utilisé avec Retrofit pour la sérialisation/désérialisation des données.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Moshi est une bibliothèque de sérialisation/désérialisation JSON.',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Moshi prend en charge la conversion des objets Java en JSON et vice versa.',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Moshi ne supporte pas les annotations Kotlin.',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Moshi est intégré par défaut dans Retrofit.',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-NET-056') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='networking' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-NET-056',v_cert_id,v_theme_id,'Quelle est la principale raison de l''utilisation du pinning des certificats ?','hard','SINGLE_CHOICE','Le pinning des certificats est principalement utilisé pour protéger contre les attaques de type man-in-the-middle (MITM), ce qui rend l''option B la réponse correcte. Les autres options ne sont pas liées au pinning des certificats : l''amélioration de la performance et la gestion de l''authentification des utilisateurs sont généralement gérées par d''autres mécanismes, et la réduction de la taille du cache est liée à l''optimisation des performances du réseau, pas au pinning des certificats.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Pour améliorer la performance des requêtes réseau.',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Pour protéger contre les attaques de type man-in-the-middle (MITM).',TRUE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Pour gérer l''authentification des utilisateurs.',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Pour réduire la taille du cache.',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-NET-057') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='networking' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-NET-057',v_cert_id,v_theme_id,'Sélectionnez TOUTES les affirmations correctes concernant Chucker et Stetho :','medium','SINGLE_CHOICE','Chucker est effectivement un outil de débogage pour les requêtes réseau, ce qui fait de l''option A correcte. Stetho permet également d''inspecter les requêtes réseau dans l''application, ce qui rend l''option B correcte. Les autres options ne sont pas spécifiques à Chucker et Stetho : la sérialisation et désérialisation des objets JSON est généralement gérée par d''autres bibliothèques, et Chucker et Stetho ne sont pas intégrés par défaut dans Android Studio.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Chucker est un outil de débogage pour les requêtes réseau.',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Stetho permet d''inspecter les requêtes réseau dans l''application.',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Chucker et Stetho sont des bibliothèques de sérialisation/désérialisation JSON.',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Chucker et Stetho sont intégrés par défaut dans Android Studio.',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-NET-058') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='networking' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-NET-058',v_cert_id,v_theme_id,'Sélectionnez TOUTES les affirmations correctes concernant Retrofit :','medium','SINGLE_CHOICE','Retrofit est effectivement un client HTTP pour API REST, ce qui fait de l''option A correcte. L''option B est incorrecte car Retrofit prend en charge plusieurs types de requêtes HTTP, pas seulement GET. L''option C est correcte car Retrofit permet de définir des annotations personnalisées pour les requêtes. L''option D est incorrecte car Retrofit supporte la sérialisation automatique des objets grâce à des bibliothèques comme Moshi ou Gson.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Retrofit est un client HTTP pour API REST.',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Retrofit prend en charge uniquement les requêtes GET.',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Retrofit permet de définir des annotations personnalisées pour les requêtes.',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Retrofit ne supporte pas la sérialisation automatique des objets.',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-NET-059') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='networking' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-NET-059',v_cert_id,v_theme_id,'Quelle est la principale fonction d''OkHttp ?','easy','SINGLE_CHOICE','OkHttp est principalement conçu pour gérer les requêtes réseau HTTP, ce qui fait de l''option A correcte. Les autres options ne sont pas les principales fonctions d''OkHttp.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Gérer les requêtes réseau HTTP.',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Sérialiser des objets en JSON.',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Gérer les images dans une application Android.',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Fournir un cache pour les images.',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-NET-060') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='networking' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-NET-060',v_cert_id,v_theme_id,'Quelles sont les DEUX principales caractéristiques de Kotlin Serialization :','hard','SINGLE_CHOICE','Kotlin Serialization supporte effectivement la sérialisation et la désérialisation automatiques, ce qui fait de l''option A correcte. L''option B est incorrecte car Kotlin Serialization ne prend en charge que JSON par défaut, sans être compatible avec tous les formats de données. L''option C est correcte car Kotlin Serialization fournit des annotations pour la configuration personnalisée. L''option D est incorrecte car Kotlin Serialization ne nécessite pas l''utilisation de bibliothèques tierces pour les formats spécifiques.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Supporte la sérialisation et la désérialisation automatiques.',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Compatible avec tous les formats de données (XML, JSON, etc.).',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Fournit des annotations pour la configuration personnalisée.',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Nécessite l''utilisation de bibliothèques tierces pour les formats spécifiques.',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-NET-061') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='networking' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-NET-061',v_cert_id,v_theme_id,'Quelle est l''utilité du Certificate Pinning dans une application Android ?','medium','SINGLE_CHOICE','Le Certificate Pinning permet de sécuriser la communication avec un serveur en vérifiant le certificat, ce qui fait de l''option A correcte. Les autres options ne sont pas directement liées au Certificate Pinning.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Permettre la communication sécurisée avec un serveur en vérifiant le certificat.',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Gérer les mises à jour des images dans l''application.',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Optimiser le chargement des données réseau.',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Crypter les données stockées localement.',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-NET-062') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='networking' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-NET-062',v_cert_id,v_theme_id,'Quelles sont les DEUX principales fonctions de Chucker :','easy','SINGLE_CHOICE','Chucker est principalement conçu pour capturer et afficher les requêtes réseau, ce qui fait de l''option A correcte. L''option B est également correcte car Chucker peut être utilisé pour gérer le stockage local des données de l''utilisateur. Les autres options ne sont pas les principales fonctions de Chucker.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Capturer et afficher les requêtes réseau.',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Gérer le stockage local des données de l''utilisateur.',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Optimiser les images dans l''application.',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Analyser les performances de l''application.',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-NET-063') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='networking' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-NET-063',v_cert_id,v_theme_id,'Sélectionnez TOUTES les affirmations correctes concernant Retrofit :','medium','SINGLE_CHOICE','Retrofit est effectivement un client HTTP pour API REST (Option A). Il prend en charge la sérialisation automatique des objets JSON grâce à des bibliothèques comme Moshi ou Gson (Option B). Retrofit permet l''utilisation de méthodes GET, POST et DELETE (Option C). L''assertion selon laquelle Retrofit ne supporte pas les requêtes asynchrones est fausse, car il fonctionne de manière asynchrone par défaut (Option D).','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Retrofit est un client HTTP pour API REST.',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Retrofit prend en charge la sérialisation automatique des objets JSON.',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Retrofit permet l''utilisation de méthodes GET, POST et DELETE.',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Retrofit ne supporte pas les requêtes asynchrones.',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-NET-064') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='networking' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-NET-064',v_cert_id,v_theme_id,'Quelle est la principale fonction d''OkHttp ?','easy','SINGLE_CHOICE','OkHttp est principalement utilisé pour gérer les requêtes réseau HTTP (Option A). Bien que OkHttp puisse être utilisé avec des bibliothèques de sérialisation comme Moshi ou Gson, sa fonction principale n''est pas la sérialisation (Option B). La gestion de la cache en mémoire est généralement gérée par des bibliothèques spécifiques comme Volley ou Retrofit (Option C). OkHttp ne fournit pas d''interface utilisateur pour les requêtes réseau (Option D).','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Gérer les requêtes réseau HTTP.',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Sérialiser et désérialiser des objets JSON.',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Gérer la cache en mémoire.',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Fournir une interface utilisateur pour les requêtes réseau.',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-NET-065') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='networking' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-NET-065',v_cert_id,v_theme_id,'Quelles sont les DEUX principales raisons d''utiliser le pinning des certificats ?','hard','SINGLE_CHOICE','Le pinning des certificats est utilisé pour protéger contre les attaques de type man-in-the-middle (Option A), car cela assure que la connexion est établie avec un serveur authentique. Il peut également aider à assurer la confidentialité des données échangées (Option D), car cela garantit que les communications sont sécurisées. L''amélioration des performances des requêtes réseau (Option B) n''est pas une raison principale du pinning des certificats, et la simplification de la mise à jour des certificats (Option C) est généralement une tâche manuelle et n''est pas automatisée par le pinning des certificats.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Pour protéger contre les attaques de type man-in-the-middle.',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Pour améliorer la performance des requêtes réseau.',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Pour simplifier le processus de mise à jour des certificats.',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Pour assurer la confidentialité des données échangées.',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-SEC-001') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-SEC-001',v_cert_id,v_theme_id,'Qu''est-ce que l''Android Keystore ?','hard','SINGLE_CHOICE','Keystore protège les clés cryptographiques.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Stockage sécurisé de clés cryptographiques',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Base de données',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Cache',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','SharedPreferences',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-SEC-002') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-SEC-002',v_cert_id,v_theme_id,'Comment générer une clé dans Keystore ?','hard','SINGLE_CHOICE','KeyGenerator pour symétrique, KeyPairGenerator pour asymétrique.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','KeyGenerator',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','KeyPairGenerator',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','KeyStore.setEntry()',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A et B',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-SEC-003') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-SEC-003',v_cert_id,v_theme_id,'Quand utiliser le Keystore ?','hard','SINGLE_CHOICE','Keystore pour toute donnée cryptographique sensible.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Clés de chiffrement',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Tokens d''authentification',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Certificats',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-SEC-004') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-SEC-004',v_cert_id,v_theme_id,'À quoi sert BiometricPrompt ?','hard','SINGLE_CHOICE','BiometricPrompt pour empreinte digitale, visage, etc.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Authentification biométrique',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Base de données',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Cache',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Network',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-SEC-005') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-SEC-005',v_cert_id,v_theme_id,'Comment vérifier si la biométrie est disponible ?','hard','SINGLE_CHOICE','canAuthenticate() retourne l''état de disponibilité.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','BiometricManager.from(context).canAuthenticate()',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','BiometricManager.canAuthenticate()',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','isBiometricAvailable()',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','hasBiometric()',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-SEC-006') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-SEC-006',v_cert_id,v_theme_id,'Quelles sont les erreurs possibles de canAuthenticate ?','hard','SINGLE_CHOICE','Plusieurs codes d''erreur possibles.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','BIOMETRIC_SUCCESS',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','BIOMETRIC_ERROR_NONE_ENROLLED',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','BIOMETRIC_ERROR_HW_UNAVAILABLE',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-SEC-007') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-SEC-007',v_cert_id,v_theme_id,'Quel algorithme est recommandé pour le chiffrement ?','hard','SINGLE_CHOICE','AES/GCM est l''algorithme recommandé.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','AES/GCM/NoPadding',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','DES',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','RC4',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Blowfish',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-SEC-008') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-SEC-008',v_cert_id,v_theme_id,'Comment générer une clé AES ?','hard','SINGLE_CHOICE','KeyGenerator ou SecretKeySpec.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','KeyGenerator.getInstance("AES")',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','SecretKeySpec',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','KeyPairGenerator',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A et B',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-SEC-009') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-SEC-009',v_cert_id,v_theme_id,'Qu''est-ce que l''IV (Initialization Vector) ?','hard','SINGLE_CHOICE','IV assure l''unicité du chiffrement.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Vecteur d''initialisation pour AES',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Clé de chiffrement',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Tag d''authentification',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Hash',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-SEC-010') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-SEC-010',v_cert_id,v_theme_id,'L''IV doit-il être secret ?','hard','SINGLE_CHOICE','L''IV doit être unique mais pas nécessairement secret.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Non, mais doit être unique',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Oui, absolument',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Oui, partiellement',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Non, pas important',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-SEC-011') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-SEC-011',v_cert_id,v_theme_id,'À quoi sert ProGuard/R8 ?','hard','SINGLE_CHOICE','ProGuard/R8 obfusque et optimise le code.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Obfuscation et optimisation',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Chiffrement',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Authentification',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Logging',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-SEC-012') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-SEC-012',v_cert_id,v_theme_id,'Que faut-il conserver avec ProGuard ?','hard','SINGLE_CHOICE','Règles pour reflection, Room, sérialisation.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Classes utilisées par reflection',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Entités Room',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Modèles JSON',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-SEC-013') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-SEC-013',v_cert_id,v_theme_id,'Android exige-t-il HTTPS par défaut ?','hard','SINGLE_CHOICE','HTTPS est exigé par défaut pour les apps ciblant API 28+.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Oui, depuis Android 9 (API 28)',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Uniquement pour les apps ciblant API 28+',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A et C',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-SEC-014') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-SEC-014',v_cert_id,v_theme_id,'Comment autoriser le trafic HTTP ?','hard','SINGLE_CHOICE','Configuration de sécurité réseau.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','network_security_config.xml',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','android:usesCleartextTraffic="true"',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','android:allowHttp="true"',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A et B',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-SEC-015') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-SEC-015',v_cert_id,v_theme_id,'Pourquoi détecter les appareils rootés ?','hard','SINGLE_CHOICE','Les appareils rootés sont plus vulnérables.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Prévenir les attaques',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Protéger les données sensibles',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Sécurité accrue',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-SEC-016') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-SEC-016',v_cert_id,v_theme_id,'Comment détecter un appareil rooté ?','hard','SINGLE_CHOICE','Plusieurs méthodes de détection root.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Vérifier les fichiers su',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Vérifier les applications root',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Vérifier les propriétés système',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-SEC-017') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-SEC-017',v_cert_id,v_theme_id,'À quoi sert SafetyNet ?','hard','SINGLE_CHOICE','SafetyNet atteste de l''intégrité de l''appareil.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Vérifier l''intégrité de l''appareil',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Chiffrer les données',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Authentifier les utilisateurs',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Logger',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-SEC-018') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-SEC-018',v_cert_id,v_theme_id,'SafetyNet a été remplacé par quoi ?','hard','SINGLE_CHOICE','Play Integrity API remplace SafetyNet.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Play Integrity API',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Firebase App Check',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Android VTS',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Samsung Knox',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-SEC-019') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-SEC-019',v_cert_id,v_theme_id,'Que vérifie Play Integrity API ?','hard','SINGLE_CHOICE','Vérifications complètes d''intégrité.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Intégrité de l''app',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Intégrité de l''appareil',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Licence Google Play',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-SEC-020') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-SEC-020',v_cert_id,v_theme_id,'Pourquoi obfusquer le code ?','hard','SINGLE_CHOICE','Obfuscation pour sécurité et optimisation.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Rendre le reverse engineering difficile',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Réduire la taille',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Optimiser',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-SEC-021') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-SEC-021',v_cert_id,v_theme_id,'Pourquoi obfusquer les chaînes sensibles ?','hard','SINGLE_CHOICE','Protéger les informations sensibles.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Cacher clés API, URLs',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Performance',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Compatibilité',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Debug',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-SEC-022') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-SEC-022',v_cert_id,v_theme_id,'Qu''est-ce que DexGuard ?','hard','SINGLE_CHOICE','DexGuard est une solution de protection avancée.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Obfuscateur commercial avancé',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Alternative à ProGuard',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Outil de chiffrement',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-SEC-023') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-SEC-023',v_cert_id,v_theme_id,'Comment sécuriser SharedPreferences ?','hard','SINGLE_CHOICE','EncryptedSharedPreferences chiffre les données.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','EncryptedSharedPreferences',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Android Keystore',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Chiffrement manuel',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A et B',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-SEC-024') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-SEC-024',v_cert_id,v_theme_id,'Comment créer EncryptedSharedPreferences ?','hard','SINGLE_CHOICE','create() avec masterKey et schéma.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','EncryptedSharedPreferences.create()',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','new EncryptedSharedPreferences()',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','SharedPreferences.createEncrypted()',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','getEncryptedSharedPreferences()',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-SEC-025') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-SEC-025',v_cert_id,v_theme_id,'À quoi sert EncryptedFile ?','hard','SINGLE_CHOICE','EncryptedFile pour chiffrer des fichiers.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Chiffrer des fichiers',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Chiffrer des préférences',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Chiffrer des bases',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Chiffrer le réseau',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-SEC-026') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-SEC-026',v_cert_id,v_theme_id,'Quel algorithme de hash est recommandé ?','hard','SINGLE_CHOICE','SHA-256 est l''algorithme de hash recommandé.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','SHA-256',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','MD5',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','SHA-1',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','CRC32',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-SEC-027') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-SEC-027',v_cert_id,v_theme_id,'Pourquoi ajouter un sel (salt) au hash ?','hard','SINGLE_CHOICE','Le sel rend les hash uniques même pour mots de passe identiques.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Prévenir les attaques par tables arc-en-ciel',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Augmenter la performance',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Réduire la taille',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Compatibilité',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-SEC-028') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-SEC-028',v_cert_id,v_theme_id,'À quoi sert SecureRandom ?','hard','SINGLE_CHOICE','SecureRandom pour la génération de clés, IV, sels.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Générer des nombres aléatoires cryptographiquement sûrs',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Générer des nombres aléatoires simples',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Chiffrer des données',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Hacher des données',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-SEC-029') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-SEC-029',v_cert_id,v_theme_id,'Comment sécuriser une WebView ?','hard','SINGLE_CHOICE','Désactiver les fonctionnalités dangereuses.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','setJavaScriptEnabled(false)',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','setAllowFileAccess(false)',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','setSavePassword(false)',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-SEC-030') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-SEC-030',v_cert_id,v_theme_id,'Qu''est-ce que l''addJavaScriptInterface ?','hard','SINGLE_CHOICE','Peut être dangereux si mal utilisé.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Expose un objet Java à JavaScript',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Danger de sécurité',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Permet l''injection de code',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-SEC-031') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-SEC-031',v_cert_id,v_theme_id,'Comment sécuriser les Intents ?','hard','SINGLE_CHOICE','Plusieurs pratiques pour sécuriser les Intents.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','PendingIntent immuables',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Vérifier les Intent',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Utiliser des permissions',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-SEC-032') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-SEC-032',v_cert_id,v_theme_id,'Pourquoi PendingIntent doit être immuable ?','hard','SINGLE_CHOICE','Immuable depuis Android 12 (flag).','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Prévenir les modifications malveillantes',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Performance',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Compatibilité',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Debug',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-SEC-033') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-SEC-033',v_cert_id,v_theme_id,'Comment sécuriser un ContentProvider ?','hard','SINGLE_CHOICE','Configuration des permissions d''accès.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','android:exported="false"',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','android:permission',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','android:readPermission',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-SEC-034') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-SEC-034',v_cert_id,v_theme_id,'Comment sécuriser un BroadcastReceiver ?','hard','SINGLE_CHOICE','Protection contre les broadcasts malveillants.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','android:exported="false"',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Permissions',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','LocalBroadcastManager',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-SEC-035') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-SEC-035',v_cert_id,v_theme_id,'Comment sécuriser un Service ?','hard','SINGLE_CHOICE','Protection des services exposés.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','android:exported="false"',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','android:permission',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','bind avec permission',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-SEC-036') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-SEC-036',v_cert_id,v_theme_id,'Comment sécuriser les deep links ?','hard','SINGLE_CHOICE','Vérifier que les deep links sont légitimes.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Digital Asset Links',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Vérification des URLs',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Validation des paramètres',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-SEC-037') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-SEC-037',v_cert_id,v_theme_id,'Comment vérifier la signature de l''app ?','hard','SINGLE_CHOICE','Vérification de la signature de l''app.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','PackageManager.getPackageInfo()',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Vérifier le certificat',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','SignatureInfo',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A et B',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-SEC-038') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-SEC-038',v_cert_id,v_theme_id,'Qu''est-ce que Google Play signing ?','hard','SINGLE_CHOICE','Google Play gère la signature des apps.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Signature gérée par Google',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Signature locale',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Pas de signature',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Signature double',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-SEC-039') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-SEC-039',v_cert_id,v_theme_id,'Comment vérifier l''intégrité de l''app ?','hard','SINGLE_CHOICE','Vérifier que l''app n''a pas été modifiée.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Play Integrity API',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','SafetyNet',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Signature',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A et B',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-SEC-040') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-SEC-040',v_cert_id,v_theme_id,'Comment détecter la modification du code ?','hard','SINGLE_CHOICE','Détecter si le code a été modifié.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Vérifier la signature',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Hash du code',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Dex checksum',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-SEC-041') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-SEC-041',v_cert_id,v_theme_id,'Pourquoi détecter les émulateurs ?','hard','SINGLE_CHOICE','Les émulateurs sont souvent utilisés pour analyser les apps.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Prévenir la fraude',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Protéger les données',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Analyse malveillante',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-SEC-042') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-SEC-042',v_cert_id,v_theme_id,'Comment détecter un émulateur ?','hard','SINGLE_CHOICE','Plusieurs méthodes de détection d''émulateur.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Propriétés système (ro.kernel.qemu)',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Caractéristiques matérielles',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Fichiers spécifiques',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-SEC-043') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-SEC-043',v_cert_id,v_theme_id,'Comment détecter le mode debug ?','hard','SINGLE_CHOICE','Détecter si l''app est debuguée.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','android.os.Debug.isDebuggerConnected()',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','android.os.Debug.waitingForDebugger()',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','ApplicationInfo.FLAG_DEBUGGABLE',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-SEC-044') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-SEC-044',v_cert_id,v_theme_id,'Avantage du certificate pinning ?','hard','SINGLE_CHOICE','Pinning empêche les certificats frauduleux.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Prévenir les attaques MITM',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Accélérer les connexions',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Réduire la bande passante',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Compatibilité',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-SEC-045') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-SEC-045',v_cert_id,v_theme_id,'Inconvénient du certificate pinning ?','hard','SINGLE_CHOICE','Nécessite une mise à jour régulière.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Expiration des certificats',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Complexité',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Maintenance',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-SEC-046') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-SEC-046',v_cert_id,v_theme_id,'À quoi sert Firebase App Check ?','hard','SINGLE_CHOICE','App Check protège les ressources backend.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Vérifier que les requêtes viennent de l''app',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Authentifier les utilisateurs',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Chiffrer les données',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Logger',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-SEC-047') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-SEC-047',v_cert_id,v_theme_id,'Quels fournisseurs App Check supporte-t-il ?','hard','SINGLE_CHOICE','Attestation d''intégrité de l''app.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Play Integrity, SafetyNet, DeviceCheck',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','ReCaptcha',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Auth0',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Firebase Auth',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-SEC-048') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-SEC-048',v_cert_id,v_theme_id,'Comment implémenter OAuth2 sur Android ?','hard','SINGLE_CHOICE','Plusieurs bibliothèques OAuth2.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','AppAuth',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Google Sign-In',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Facebook Login',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-SEC-049') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-SEC-049',v_cert_id,v_theme_id,'Où stocker les tokens OAuth ?','hard','SINGLE_CHOICE','Stockage sécurisé des tokens.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','EncryptedSharedPreferences',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Keystore',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','DataStore chiffré',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-SEC-050') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-SEC-050',v_cert_id,v_theme_id,'Quel est le principe de moindre privilège ?','hard','SINGLE_CHOICE','Ne demander que les permissions strictement nécessaires.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Demander uniquement les permissions nécessaires',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Demander toutes les permissions',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Ignorer les permissions',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Forcer les permissions',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-SEC-051') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-SEC-051',v_cert_id,v_theme_id,'Comment demander une permission runtime ?','hard','SINGLE_CHOICE','API moderne (Activity Result) ou legacy.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','requestPermissions()',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','ActivityResultContracts.RequestPermission',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','checkSelfPermission()',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A et B',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-SEC-052') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-SEC-052',v_cert_id,v_theme_id,'Que faire si l''utilisateur refuse définitivement ?','hard','SINGLE_CHOICE','Gérer le refus permanent (shouldShowRequestPermissionRationale).','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Expliquer pourquoi la permission est nécessaire',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Désactiver la fonctionnalité',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Rediriger vers les paramètres',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-SEC-053') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-SEC-053',v_cert_id,v_theme_id,'Pourquoi éviter de logger les données sensibles ?','hard','SINGLE_CHOICE','Ne jamais logger mots de passe, tokens, données personnelles.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Les logs sont lisibles',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Les logs persistent',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Risque de fuite',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-SEC-054') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-SEC-054',v_cert_id,v_theme_id,'Comment désactiver les logs en production ?','hard','SINGLE_CHOICE','Désactiver logs en production.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','BuildConfig.DEBUG',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','ProGuard supprime les logs',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Timber.plant(Timber.DebugTree()) conditionnel',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-SEC-055') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-SEC-055',v_cert_id,v_theme_id,'Les crash reports peuvent-ils contenir des données sensibles ?','hard','SINGLE_CHOICE','Éviter d''inclure des données sensibles dans les crash reports.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Oui, les logs et variables',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Non, automatiquement filtrés',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Oui, si mal configuré',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A et C',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-SEC-056') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-SEC-056',v_cert_id,v_theme_id,'Comment anonymiser les données analytics ?','hard','SINGLE_CHOICE','Protéger la vie privée des utilisateurs.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Ne pas envoyer d''identifiants',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Hacher les IDs',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Aggréger les données',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-SEC-057') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-SEC-057',v_cert_id,v_theme_id,'Que faut-il pour être conforme GDPR ?','hard','SINGLE_CHOICE','Respecter les droits des utilisateurs européens.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Consentement utilisateur',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Droit à l''oubli',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Portabilité des données',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-SEC-058') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-SEC-058',v_cert_id,v_theme_id,'Combien de temps conserver les données ?','hard','SINGLE_CHOICE','Principe de minimisation des données.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Uniquement le temps nécessaire',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Indéfiniment',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','5 ans',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','1 an',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-SEC-059') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-SEC-059',v_cert_id,v_theme_id,'Quels outils pour tester la sécurité ?','hard','SINGLE_CHOICE','Outils d''analyse de sécurité Android.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','MobSF (Mobile Security Framework)',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Drozer',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Qark',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-SEC-060') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-SEC-060',v_cert_id,v_theme_id,'Qu''est-ce qu''un pentest ?','hard','SINGLE_CHOICE','Simulation d''attaque pour trouver des vulnérabilités.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Test d''intrusion',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Test unitaire',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Test fonctionnel',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Test de performance',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-SEC-061') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-SEC-061',v_cert_id,v_theme_id,'Sélectionnez TOUTES les affirmations correctes concernant l''encryption AES :','medium','SINGLE_CHOICE','AES est effectivement un algorithme symétrique, ce qui signifie qu''il utilise la même clé pour chiffrer et déchiffrer les données. Il supporte des clés de 128, 192 ou 256 bits. Cependant, AES est généralement plus rapide que RSA, qui est un algorithme asymétrique. L''utilisation d''AES pour l''authentification biologique n''est pas une utilisation standard.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','AES est un algorithme symétrique',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','AES utilise des clés de 128, 192 ou 256 bits',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','AES est plus lent que le chiffrement RSA',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','AES est utilisé pour l''authentification biologique',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-SEC-062') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-SEC-062',v_cert_id,v_theme_id,'Quelle est la principale différence entre SSL et TLS ?','easy','SINGLE_CHOICE','TLS est la version mise à jour de SSL et apporte des améliorations en matière de sécurité. Les autres options sont incorrectes car SSL n''est pas plus sécurisé que TLS, les certificats SSL peuvent être émis par des autorités de certification tierces, et TLS supporte les protocoles HTTP.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','SSL est plus sécurisé que TLS',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','TLS est la version mise à jour de SSL',TRUE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','SSL utilise des certificats émis par l''OS',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','TLS ne supporte pas les protocoles HTTP',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-SEC-063') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-SEC-063',v_cert_id,v_theme_id,'Quelles sont les deux principales fonctions de ProGuard/R8 ?','hard','SINGLE_CHOICE','ProGuard/R8 obfusque le code source pour rendre plus difficile la compréhension du code par des attaquants. Il minifie également les fichiers de ressources pour réduire la taille de l''application. L''optimisation du bytecode améliore les performances de l''application, mais ce n''est pas une fonction principale. La gestion des permissions d''application est généralement gérée par le système Android, pas par ProGuard/R8.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Obfusquer le code source',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Minifier les fichiers de ressources',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Optimiser le bytecode',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Gérer les permissions d''application',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-SEC-064') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-SEC-064',v_cert_id,v_theme_id,'Quelle méthode est la plus sûre pour l''authentification biométrique sur Android ?','medium','SINGLE_CHOICE','L''authentification faciale est généralement considérée comme la méthode la plus sûre sur Android en raison de l''utilisation d''algorithmes avancés pour vérifier l''identité de l''utilisateur. Bien que les empreintes digitales soient également sécuritaires, l''authentification faciale offre une couche supplémentaire de sécurité en vérifiant également la présence du visage.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Empreinte digitale',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Authentification faciale',TRUE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Mot de passe',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Code PIN',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-SEC-065') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-SEC-065',v_cert_id,v_theme_id,'Quelles sont les trois principales utilisations de Firebase App Check ?','hard','SINGLE_CHOICE','Firebase App Check est principalement utilisé pour protéger les appels API contre l''usurpation d''identité en vérifiant que les requêtes proviennent de votre application authentifiée. Il peut également aider à assurer la conformité aux réglementations de sécurité en limitant l''accès non autorisé. La gestion des mises à jour de l''application et le cryptage des données sont généralement gérés par d''autres outils ou services.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Protéger les appels API contre l''usurpation d''identité',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Gérer les mises à jour de l''application',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Crypter les données stockées dans Firebase',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Assurer la conformité aux réglementations de sécurité',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-SEC-066') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-SEC-066',v_cert_id,v_theme_id,'Quelles sont les DEUX principales méthodes d''encryption utilisées dans Android ?','medium','SINGLE_CHOICE','AES et RSA sont des méthodes d''encryption couramment utilisées dans Android. SHA-256 est un algorithme de hachage, pas d''encryption. MD5 n''est plus considéré comme sécurisé et ne devrait pas être utilisé pour l''encryption.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','AES',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','RSA',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','SHA-256',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','MD5',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-SEC-067') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-SEC-067',v_cert_id,v_theme_id,'Quelle est la principale fonction de l''Android Keystore ?','easy','SINGLE_CHOICE','L''Android Keystore est utilisé pour stocker de manière sécurisée des clés cryptographiques, ce qui permet de protéger les données sensibles. Les autres options ne sont pas des fonctions principales du Keystore.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Stockage sécurisé de clés cryptographiques',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Gestion des permissions d''applications',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Sauvegarde de données utilisateur',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Cryptage des fichiers',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-SEC-068') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-SEC-068',v_cert_id,v_theme_id,'Quelles sont les DEUX méthodes de biometric authentication disponibles dans Android ?','hard','SINGLE_CHOICE','Fingerprint et Face recognition sont les deux méthodes de biometric authentication disponibles dans Android. Voice recognition n''est pas une méthode native et Signature est une méthode de signature digitale, pas d''authentification biologique.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Fingerprint',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Face recognition',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Voice recognition',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Signature',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-SEC-069') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-SEC-069',v_cert_id,v_theme_id,'Quelle est la principale fonction de ProGuard/R8 dans un projet Android ?','medium','SINGLE_CHOICE','ProGuard/R8 est utilisé pour optimiser et minimifier le code, ce qui réduit la taille de l''APK et améliore les performances. Les autres options ne sont pas des fonctions principales de ProGuard/R8.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Optimiser et minimifier le code',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Gérer les permissions d''applications',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Crypter les données sensibles',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Déboguer l''application',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-SEC-070') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-SEC-070',v_cert_id,v_theme_id,'Quelles sont les DEUX principales fonctions de SSL/TLS dans une communication sécurisée ?','hard','SINGLE_CHOICE','SSL/TLS chiffre les données pour assurer leur confidentialité et effectue une authentification mutuelle entre le client et le serveur. L''intégrité des messages est également assurée, mais la compression n''est pas une fonction de SSL/TLS.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Chiffrement des données',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Authentification mutuelle',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Intégrité des messages',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Compression des données',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-SEC-071') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-SEC-071',v_cert_id,v_theme_id,'Sélectionnez TOUTES les affirmations correctes concernant l''encryption AES :','medium','SINGLE_CHOICE','AES est effectivement un algorithme symétrique utilisé pour le chiffrement de données, ce qui fait d''Options A et B correctes. Option C est incorrecte car AES n''est pas asymétrique, et Option D est incorrecte car AES n''est pas utilisé pour la signature numérique.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','AES est un algorithme symétrique',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','AES est utilisé pour le chiffrement de données',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','AES est un algorithme asymétrique',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','AES est utilisé pour la signature numérique',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-SEC-072') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-SEC-072',v_cert_id,v_theme_id,'Quelle est la principale fonction de l''Android Keystore ?','easy','SINGLE_CHOICE','L''Android Keystore est principalement utilisé pour stocker des clés cryptographiques de manière sécurisée, ce qui fait d''Option A la réponse correcte. Les autres options ne sont pas les fonctions principales du Keystore.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Stockage sécurisé des clés cryptographiques',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Gestion de la mémoire du système',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Stockage des préférences utilisateur',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Gestion des permissions d''application',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-SEC-073') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-SEC-073',v_cert_id,v_theme_id,'Quelles sont les DEUX principales méthodes de biometric authentication sur Android ?','hard','SINGLE_CHOICE','L''authentification par empreinte digitale et la reconnaissance faciale sont les deux principales méthodes de biometric authentication sur Android, ce qui fait d''Options A et B correctes. Les autres options sont des méthodes de vérification non biométriques.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Authentification par empreinte digitale',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Authentification par reconnaissance faciale',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Authentification par mot de passe',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Authentification par PIN',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-SEC-074') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-SEC-074',v_cert_id,v_theme_id,'Quelle est la principale utilité de SSL/TLS dans une application Android ?','medium','SINGLE_CHOICE','La principale utilité de SSL/TLS dans une application Android est le chiffrement des données en transit, ce qui protège les informations sensibles lors de l''échange avec un serveur. Cela fait d''Option A la réponse correcte.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Chiffrement des données en transit',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Stockage sécurisé des clés privées',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Gestion des permissions d''application',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Authentification de l''utilisateur',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-SEC-075') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-SEC-075',v_cert_id,v_theme_id,'Quelles sont les DEUX principales méthodes de détection de root sur un appareil Android ?','hard','SINGLE_CHOICE','La détection de root peut être réalisée en vérifiant les fichiers système qui sont modifiés lorsqu''un appareil est rooté (Option A) et en utilisant des bibliothèques tierces spécialisées dans cette tâche (Option B). Les autres options ne sont pas des méthodes de détection de root.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Vérification des fichiers système',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Utilisation de bibliothèques tierces',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Vérification des permissions d''application',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Gestion des préférences utilisateur',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-SEC-076') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-SEC-076',v_cert_id,v_theme_id,'Sélectionnez TOUTES les affirmations correctes concernant l''encryption en Android :','medium','SINGLE_CHOICE','L''encryption est effectivement utilisée pour protéger les données sensibles. Le chiffrement AES est symétrique et rapide, ce qui en fait un choix populaire pour la protection des données. Le chiffrement RSA est asymétrique et bien que plus lent, il est souvent utilisé pour échanger des clés de chiffrement symétriques. L''encryption peut être utilisée pour protéger les fichiers sur le stockage externe, mais cela dépend de la mise en œuvre correcte.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','L''encryption peut être utilisée pour protéger les données sensibles.',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Le chiffrement AES est symétrique et rapide.',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Le chiffrement RSA est asymétrique mais plus lent que le chiffrement AES.',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','L''encryption peut être utilisée pour protéger les fichiers sur le stockage externe.',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-SEC-078') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-SEC-078',v_cert_id,v_theme_id,'Quelles sont les DEUX principales méthodes de biometric authentication disponibles sur Android ?','hard','SINGLE_CHOICE','L''authentification par empreinte digitale et l''authentification par reconnaissance faciale sont les deux principales méthodes de biometric authentication disponibles sur Android. Bien que l''authentification par mot de passe et PIN soit également disponible, ces méthodes ne sont pas considérées comme biometric.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Authentification par empreinte digitale',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Authentification par reconnaissance faciale',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Authentification par mot de passe',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Authentification par PIN',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-SEC-079') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-SEC-079',v_cert_id,v_theme_id,'Quelle est la principale fonction de ProGuard/R8 lors du build d''une application Android ?','medium','SINGLE_CHOICE','La principale fonction de ProGuard/R8 lors du build d''une application Android est de minimiser et d''obfusquer le code Java/Kotlin, ce qui aide à protéger le code source et à réduire la taille de l''APK.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Minimiser et obfusquer le code Java/Kotlin',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Gérer les permissions de l''application',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Optimiser les performances du GPU',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Crypter les données sensibles',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-SEC-080') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AND-SEC-080',v_cert_id,v_theme_id,'Quelles sont les DEUX principales utilisations de Firebase App Check ?','hard','SINGLE_CHOICE','Firebase App Check est principalement utilisé pour protéger les appels à l''API Firebase contre les utilisateurs non autorisés en vérifiant que les requêtes proviennent d''applications authentifiées. Bien que Firebase offre des fonctionnalités de cryptage pour protéger les données sensibles, cela n''est pas la principale fonction de Firebase App Check.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Protéger les appels à l''API Firebase contre les utilisateurs non autorisés',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Crypter les données sensibles stockées dans Firebase',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Gérer les mises à jour de l''application',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Optimiser le stockage dans Firebase',FALSE,3);
    END IF;
END $$;
