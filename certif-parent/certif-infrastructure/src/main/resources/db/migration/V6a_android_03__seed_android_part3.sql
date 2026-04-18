-- V6a_android_03__seed_android_part3.sql
-- android: questions 301–352
-- Idempotent via legacy_id check

-- ANDROID: 52 questions
DO $$
DECLARE
    v_cert_id TEXT := 'android';
    v_theme_id UUID; v_q_id UUID;
BEGIN
    IF NOT EXISTS (SELECT 1 FROM certifications WHERE id = v_cert_id) THEN
        RAISE NOTICE 'Cert % absent', v_cert_id; RETURN; END IF;
    INSERT INTO certification_themes (id,certification_id,code,label,question_count,display_order)
    VALUES (uuid_generate_v4(),v_cert_id,'security','Security',0,0)
    ON CONFLICT (certification_id,code) DO NOTHING;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-SEC-028') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AND-SEC-028',v_cert_id,v_theme_id,'À quoi sert SecureRandom ?','hard','SINGLE_CHOICE','SecureRandom pour la génération de clés, IV, sels.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Générer des nombres aléatoires cryptographiquement sûrs',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Générer des nombres aléatoires simples',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Chiffrer des données',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Hacher des données',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-SEC-029') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AND-SEC-029',v_cert_id,v_theme_id,'Comment sécuriser une WebView ?','hard','SINGLE_CHOICE','Désactiver les fonctionnalités dangereuses.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','setJavaScriptEnabled(false)',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','setAllowFileAccess(false)',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','setSavePassword(false)',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-SEC-030') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AND-SEC-030',v_cert_id,v_theme_id,'Qu''est-ce que l''addJavaScriptInterface ?','hard','SINGLE_CHOICE','Peut être dangereux si mal utilisé.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Expose un objet Java à JavaScript',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Danger de sécurité',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Permet l''injection de code',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-SEC-031') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AND-SEC-031',v_cert_id,v_theme_id,'Comment sécuriser les Intents ?','hard','SINGLE_CHOICE','Plusieurs pratiques pour sécuriser les Intents.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','PendingIntent immuables',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Vérifier les Intent',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Utiliser des permissions',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-SEC-032') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AND-SEC-032',v_cert_id,v_theme_id,'Pourquoi PendingIntent doit être immuable ?','hard','SINGLE_CHOICE','Immuable depuis Android 12 (flag).','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Prévenir les modifications malveillantes',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Performance',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Compatibilité',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Debug',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-SEC-033') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AND-SEC-033',v_cert_id,v_theme_id,'Comment sécuriser un ContentProvider ?','hard','SINGLE_CHOICE','Configuration des permissions d''accès.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','android:exported="false"',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','android:permission',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','android:readPermission',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-SEC-034') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AND-SEC-034',v_cert_id,v_theme_id,'Comment sécuriser un BroadcastReceiver ?','hard','SINGLE_CHOICE','Protection contre les broadcasts malveillants.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','android:exported="false"',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Permissions',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','LocalBroadcastManager',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-SEC-035') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AND-SEC-035',v_cert_id,v_theme_id,'Comment sécuriser un Service ?','hard','SINGLE_CHOICE','Protection des services exposés.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','android:exported="false"',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','android:permission',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','bind avec permission',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-SEC-036') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AND-SEC-036',v_cert_id,v_theme_id,'Comment sécuriser les deep links ?','hard','SINGLE_CHOICE','Vérifier que les deep links sont légitimes.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Digital Asset Links',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Vérification des URLs',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Validation des paramètres',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-SEC-037') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AND-SEC-037',v_cert_id,v_theme_id,'Comment vérifier la signature de l''app ?','hard','SINGLE_CHOICE','Vérification de la signature de l''app.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','PackageManager.getPackageInfo()',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Vérifier le certificat',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','SignatureInfo',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','A et B',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-SEC-038') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AND-SEC-038',v_cert_id,v_theme_id,'Qu''est-ce que Google Play signing ?','hard','SINGLE_CHOICE','Google Play gère la signature des apps.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Signature gérée par Google',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Signature locale',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Pas de signature',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Signature double',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-SEC-039') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AND-SEC-039',v_cert_id,v_theme_id,'Comment vérifier l''intégrité de l''app ?','hard','SINGLE_CHOICE','Vérifier que l''app n''a pas été modifiée.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Play Integrity API',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','SafetyNet',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Signature',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','A et B',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-SEC-040') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AND-SEC-040',v_cert_id,v_theme_id,'Comment détecter la modification du code ?','hard','SINGLE_CHOICE','Détecter si le code a été modifié.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Vérifier la signature',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Hash du code',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Dex checksum',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-SEC-041') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AND-SEC-041',v_cert_id,v_theme_id,'Pourquoi détecter les émulateurs ?','hard','SINGLE_CHOICE','Les émulateurs sont souvent utilisés pour analyser les apps.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Prévenir la fraude',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Protéger les données',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Analyse malveillante',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-SEC-042') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AND-SEC-042',v_cert_id,v_theme_id,'Comment détecter un émulateur ?','hard','SINGLE_CHOICE','Plusieurs méthodes de détection d''émulateur.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Propriétés système (ro.kernel.qemu)',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Caractéristiques matérielles',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Fichiers spécifiques',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-SEC-043') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AND-SEC-043',v_cert_id,v_theme_id,'Comment détecter le mode debug ?','hard','SINGLE_CHOICE','Détecter si l''app est debuguée.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','android.os.Debug.isDebuggerConnected()',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','android.os.Debug.waitingForDebugger()',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','ApplicationInfo.FLAG_DEBUGGABLE',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-SEC-044') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AND-SEC-044',v_cert_id,v_theme_id,'Avantage du certificate pinning ?','hard','SINGLE_CHOICE','Pinning empêche les certificats frauduleux.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Prévenir les attaques MITM',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Accélérer les connexions',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Réduire la bande passante',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Compatibilité',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-SEC-045') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AND-SEC-045',v_cert_id,v_theme_id,'Inconvénient du certificate pinning ?','hard','SINGLE_CHOICE','Nécessite une mise à jour régulière.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Expiration des certificats',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Complexité',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Maintenance',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-SEC-046') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AND-SEC-046',v_cert_id,v_theme_id,'À quoi sert Firebase App Check ?','hard','SINGLE_CHOICE','App Check protège les ressources backend.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Vérifier que les requêtes viennent de l''app',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Authentifier les utilisateurs',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Chiffrer les données',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Logger',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-SEC-047') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AND-SEC-047',v_cert_id,v_theme_id,'Quels fournisseurs App Check supporte-t-il ?','hard','SINGLE_CHOICE','Attestation d''intégrité de l''app.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Play Integrity, SafetyNet, DeviceCheck',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','ReCaptcha',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Auth0',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Firebase Auth',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-SEC-048') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AND-SEC-048',v_cert_id,v_theme_id,'Comment implémenter OAuth2 sur Android ?','hard','SINGLE_CHOICE','Plusieurs bibliothèques OAuth2.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','AppAuth',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Google Sign-In',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Facebook Login',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-SEC-049') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AND-SEC-049',v_cert_id,v_theme_id,'Où stocker les tokens OAuth ?','hard','SINGLE_CHOICE','Stockage sécurisé des tokens.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','EncryptedSharedPreferences',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Keystore',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','DataStore chiffré',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-SEC-050') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AND-SEC-050',v_cert_id,v_theme_id,'Quel est le principe de moindre privilège ?','hard','SINGLE_CHOICE','Ne demander que les permissions strictement nécessaires.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Demander uniquement les permissions nécessaires',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Demander toutes les permissions',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Ignorer les permissions',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Forcer les permissions',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-SEC-051') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AND-SEC-051',v_cert_id,v_theme_id,'Comment demander une permission runtime ?','hard','SINGLE_CHOICE','API moderne (Activity Result) ou legacy.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','requestPermissions()',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','ActivityResultContracts.RequestPermission',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','checkSelfPermission()',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','A et B',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-SEC-052') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AND-SEC-052',v_cert_id,v_theme_id,'Que faire si l''utilisateur refuse définitivement ?','hard','SINGLE_CHOICE','Gérer le refus permanent (shouldShowRequestPermissionRationale).','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Expliquer pourquoi la permission est nécessaire',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Désactiver la fonctionnalité',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Rediriger vers les paramètres',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-SEC-053') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AND-SEC-053',v_cert_id,v_theme_id,'Pourquoi éviter de logger les données sensibles ?','hard','SINGLE_CHOICE','Ne jamais logger mots de passe, tokens, données personnelles.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Les logs sont lisibles',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Les logs persistent',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Risque de fuite',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-SEC-054') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AND-SEC-054',v_cert_id,v_theme_id,'Comment désactiver les logs en production ?','hard','SINGLE_CHOICE','Désactiver logs en production.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','BuildConfig.DEBUG',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','ProGuard supprime les logs',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Timber.plant(Timber.DebugTree()) conditionnel',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-SEC-055') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AND-SEC-055',v_cert_id,v_theme_id,'Les crash reports peuvent-ils contenir des données sensibles ?','hard','SINGLE_CHOICE','Éviter d''inclure des données sensibles dans les crash reports.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Oui, les logs et variables',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Non, automatiquement filtrés',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Oui, si mal configuré',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','A et C',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-SEC-056') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AND-SEC-056',v_cert_id,v_theme_id,'Comment anonymiser les données analytics ?','hard','SINGLE_CHOICE','Protéger la vie privée des utilisateurs.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Ne pas envoyer d''identifiants',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Hacher les IDs',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Aggréger les données',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-SEC-057') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AND-SEC-057',v_cert_id,v_theme_id,'Que faut-il pour être conforme GDPR ?','hard','SINGLE_CHOICE','Respecter les droits des utilisateurs européens.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Consentement utilisateur',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Droit à l''oubli',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Portabilité des données',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-SEC-058') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AND-SEC-058',v_cert_id,v_theme_id,'Combien de temps conserver les données ?','hard','SINGLE_CHOICE','Principe de minimisation des données.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Uniquement le temps nécessaire',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Indéfiniment',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','5 ans',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','1 an',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-SEC-059') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AND-SEC-059',v_cert_id,v_theme_id,'Quels outils pour tester la sécurité ?','hard','SINGLE_CHOICE','Outils d''analyse de sécurité Android.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','MobSF (Mobile Security Framework)',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Drozer',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Qark',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-SEC-060') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AND-SEC-060',v_cert_id,v_theme_id,'Qu''est-ce qu''un pentest ?','hard','SINGLE_CHOICE','Simulation d''attaque pour trouver des vulnérabilités.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Test d''intrusion',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Test unitaire',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Test fonctionnel',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Test de performance',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-SEC-061') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AND-SEC-061',v_cert_id,v_theme_id,'Sélectionnez TOUTES les affirmations correctes concernant l''encryption AES :','medium','SINGLE_CHOICE','AES est effectivement un algorithme symétrique, ce qui signifie qu''il utilise la même clé pour chiffrer et déchiffrer les données. Il supporte des clés de 128, 192 ou 256 bits. Cependant, AES est généralement plus rapide que RSA, qui est un algorithme asymétrique. L''utilisation d''AES pour l''authentification biologique n''est pas une utilisation standard.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','AES est un algorithme symétrique',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','AES utilise des clés de 128, 192 ou 256 bits',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','AES est plus lent que le chiffrement RSA',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','AES est utilisé pour l''authentification biologique',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-SEC-062') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AND-SEC-062',v_cert_id,v_theme_id,'Quelle est la principale différence entre SSL et TLS ?','easy','SINGLE_CHOICE','TLS est la version mise à jour de SSL et apporte des améliorations en matière de sécurité. Les autres options sont incorrectes car SSL n''est pas plus sécurisé que TLS, les certificats SSL peuvent être émis par des autorités de certification tierces, et TLS supporte les protocoles HTTP.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','SSL est plus sécurisé que TLS',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','TLS est la version mise à jour de SSL',TRUE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','SSL utilise des certificats émis par l''OS',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','TLS ne supporte pas les protocoles HTTP',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-SEC-063') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AND-SEC-063',v_cert_id,v_theme_id,'Quelles sont les deux principales fonctions de ProGuard/R8 ?','hard','SINGLE_CHOICE','ProGuard/R8 obfusque le code source pour rendre plus difficile la compréhension du code par des attaquants. Il minifie également les fichiers de ressources pour réduire la taille de l''application. L''optimisation du bytecode améliore les performances de l''application, mais ce n''est pas une fonction principale. La gestion des permissions d''application est généralement gérée par le système Android, pas par ProGuard/R8.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Obfusquer le code source',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Minifier les fichiers de ressources',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Optimiser le bytecode',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Gérer les permissions d''application',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-SEC-064') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AND-SEC-064',v_cert_id,v_theme_id,'Quelle méthode est la plus sûre pour l''authentification biométrique sur Android ?','medium','SINGLE_CHOICE','L''authentification faciale est généralement considérée comme la méthode la plus sûre sur Android en raison de l''utilisation d''algorithmes avancés pour vérifier l''identité de l''utilisateur. Bien que les empreintes digitales soient également sécuritaires, l''authentification faciale offre une couche supplémentaire de sécurité en vérifiant également la présence du visage.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Empreinte digitale',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Authentification faciale',TRUE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Mot de passe',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Code PIN',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-SEC-065') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AND-SEC-065',v_cert_id,v_theme_id,'Quelles sont les trois principales utilisations de Firebase App Check ?','hard','SINGLE_CHOICE','Firebase App Check est principalement utilisé pour protéger les appels API contre l''usurpation d''identité en vérifiant que les requêtes proviennent de votre application authentifiée. Il peut également aider à assurer la conformité aux réglementations de sécurité en limitant l''accès non autorisé. La gestion des mises à jour de l''application et le cryptage des données sont généralement gérés par d''autres outils ou services.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Protéger les appels API contre l''usurpation d''identité',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Gérer les mises à jour de l''application',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Crypter les données stockées dans Firebase',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Assurer la conformité aux réglementations de sécurité',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-SEC-066') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AND-SEC-066',v_cert_id,v_theme_id,'Quelles sont les DEUX principales méthodes d''encryption utilisées dans Android ?','medium','SINGLE_CHOICE','AES et RSA sont des méthodes d''encryption couramment utilisées dans Android. SHA-256 est un algorithme de hachage, pas d''encryption. MD5 n''est plus considéré comme sécurisé et ne devrait pas être utilisé pour l''encryption.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','AES',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','RSA',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','SHA-256',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','MD5',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-SEC-067') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AND-SEC-067',v_cert_id,v_theme_id,'Quelle est la principale fonction de l''Android Keystore ?','easy','SINGLE_CHOICE','L''Android Keystore est utilisé pour stocker de manière sécurisée des clés cryptographiques, ce qui permet de protéger les données sensibles. Les autres options ne sont pas des fonctions principales du Keystore.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Stockage sécurisé de clés cryptographiques',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Gestion des permissions d''applications',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Sauvegarde de données utilisateur',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Cryptage des fichiers',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-SEC-068') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AND-SEC-068',v_cert_id,v_theme_id,'Quelles sont les DEUX méthodes de biometric authentication disponibles dans Android ?','hard','SINGLE_CHOICE','Fingerprint et Face recognition sont les deux méthodes de biometric authentication disponibles dans Android. Voice recognition n''est pas une méthode native et Signature est une méthode de signature digitale, pas d''authentification biologique.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Fingerprint',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Face recognition',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Voice recognition',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Signature',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-SEC-069') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AND-SEC-069',v_cert_id,v_theme_id,'Quelle est la principale fonction de ProGuard/R8 dans un projet Android ?','medium','SINGLE_CHOICE','ProGuard/R8 est utilisé pour optimiser et minimifier le code, ce qui réduit la taille de l''APK et améliore les performances. Les autres options ne sont pas des fonctions principales de ProGuard/R8.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Optimiser et minimifier le code',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Gérer les permissions d''applications',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Crypter les données sensibles',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Déboguer l''application',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-SEC-070') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AND-SEC-070',v_cert_id,v_theme_id,'Quelles sont les DEUX principales fonctions de SSL/TLS dans une communication sécurisée ?','hard','SINGLE_CHOICE','SSL/TLS chiffre les données pour assurer leur confidentialité et effectue une authentification mutuelle entre le client et le serveur. L''intégrité des messages est également assurée, mais la compression n''est pas une fonction de SSL/TLS.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Chiffrement des données',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Authentification mutuelle',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Intégrité des messages',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Compression des données',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-SEC-071') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AND-SEC-071',v_cert_id,v_theme_id,'Sélectionnez TOUTES les affirmations correctes concernant l''encryption AES :','medium','SINGLE_CHOICE','AES est effectivement un algorithme symétrique utilisé pour le chiffrement de données, ce qui fait d''Options A et B correctes. Option C est incorrecte car AES n''est pas asymétrique, et Option D est incorrecte car AES n''est pas utilisé pour la signature numérique.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','AES est un algorithme symétrique',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','AES est utilisé pour le chiffrement de données',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','AES est un algorithme asymétrique',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','AES est utilisé pour la signature numérique',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-SEC-072') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AND-SEC-072',v_cert_id,v_theme_id,'Quelle est la principale fonction de l''Android Keystore ?','easy','SINGLE_CHOICE','L''Android Keystore est principalement utilisé pour stocker des clés cryptographiques de manière sécurisée, ce qui fait d''Option A la réponse correcte. Les autres options ne sont pas les fonctions principales du Keystore.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Stockage sécurisé des clés cryptographiques',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Gestion de la mémoire du système',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Stockage des préférences utilisateur',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Gestion des permissions d''application',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-SEC-073') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AND-SEC-073',v_cert_id,v_theme_id,'Quelles sont les DEUX principales méthodes de biometric authentication sur Android ?','hard','SINGLE_CHOICE','L''authentification par empreinte digitale et la reconnaissance faciale sont les deux principales méthodes de biometric authentication sur Android, ce qui fait d''Options A et B correctes. Les autres options sont des méthodes de vérification non biométriques.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Authentification par empreinte digitale',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Authentification par reconnaissance faciale',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Authentification par mot de passe',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Authentification par PIN',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-SEC-074') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AND-SEC-074',v_cert_id,v_theme_id,'Quelle est la principale utilité de SSL/TLS dans une application Android ?','medium','SINGLE_CHOICE','La principale utilité de SSL/TLS dans une application Android est le chiffrement des données en transit, ce qui protège les informations sensibles lors de l''échange avec un serveur. Cela fait d''Option A la réponse correcte.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Chiffrement des données en transit',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Stockage sécurisé des clés privées',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Gestion des permissions d''application',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Authentification de l''utilisateur',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-SEC-075') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AND-SEC-075',v_cert_id,v_theme_id,'Quelles sont les DEUX principales méthodes de détection de root sur un appareil Android ?','hard','SINGLE_CHOICE','La détection de root peut être réalisée en vérifiant les fichiers système qui sont modifiés lorsqu''un appareil est rooté (Option A) et en utilisant des bibliothèques tierces spécialisées dans cette tâche (Option B). Les autres options ne sont pas des méthodes de détection de root.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Vérification des fichiers système',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Utilisation de bibliothèques tierces',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Vérification des permissions d''application',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Gestion des préférences utilisateur',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-SEC-076') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AND-SEC-076',v_cert_id,v_theme_id,'Sélectionnez TOUTES les affirmations correctes concernant l''encryption en Android :','medium','SINGLE_CHOICE','L''encryption est effectivement utilisée pour protéger les données sensibles. Le chiffrement AES est symétrique et rapide, ce qui en fait un choix populaire pour la protection des données. Le chiffrement RSA est asymétrique et bien que plus lent, il est souvent utilisé pour échanger des clés de chiffrement symétriques. L''encryption peut être utilisée pour protéger les fichiers sur le stockage externe, mais cela dépend de la mise en œuvre correcte.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','L''encryption peut être utilisée pour protéger les données sensibles.',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Le chiffrement AES est symétrique et rapide.',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Le chiffrement RSA est asymétrique mais plus lent que le chiffrement AES.',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','L''encryption peut être utilisée pour protéger les fichiers sur le stockage externe.',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-SEC-078') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AND-SEC-078',v_cert_id,v_theme_id,'Quelles sont les DEUX principales méthodes de biometric authentication disponibles sur Android ?','hard','SINGLE_CHOICE','L''authentification par empreinte digitale et l''authentification par reconnaissance faciale sont les deux principales méthodes de biometric authentication disponibles sur Android. Bien que l''authentification par mot de passe et PIN soit également disponible, ces méthodes ne sont pas considérées comme biometric.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Authentification par empreinte digitale',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Authentification par reconnaissance faciale',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Authentification par mot de passe',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Authentification par PIN',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-SEC-079') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AND-SEC-079',v_cert_id,v_theme_id,'Quelle est la principale fonction de ProGuard/R8 lors du build d''une application Android ?','medium','SINGLE_CHOICE','La principale fonction de ProGuard/R8 lors du build d''une application Android est de minimiser et d''obfusquer le code Java/Kotlin, ce qui aide à protéger le code source et à réduire la taille de l''APK.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Minimiser et obfusquer le code Java/Kotlin',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Gérer les permissions de l''application',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Optimiser les performances du GPU',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Crypter les données sensibles',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AND-SEC-080') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AND-SEC-080',v_cert_id,v_theme_id,'Quelles sont les DEUX principales utilisations de Firebase App Check ?','hard','SINGLE_CHOICE','Firebase App Check est principalement utilisé pour protéger les appels à l''API Firebase contre les utilisateurs non autorisés en vérifiant que les requêtes proviennent d''applications authentifiées. Bien que Firebase offre des fonctionnalités de cryptage pour protéger les données sensibles, cela n''est pas la principale fonction de Firebase App Check.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Protéger les appels à l''API Firebase contre les utilisateurs non autorisés',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Crypter les données sensibles stockées dans Firebase',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Gérer les mises à jour de l''application',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Optimiser le stockage dans Firebase',FALSE,3);
    END IF;
END $$;
