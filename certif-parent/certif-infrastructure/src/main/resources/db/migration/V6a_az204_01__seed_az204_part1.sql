-- V6a_az204_01__seed_az204_part1.sql
-- az204: questions 1–150
-- Idempotent via legacy_id check

-- AZ204: 150 questions
DO $$
DECLARE
    v_cert_id TEXT := 'az204';
    v_theme_id UUID; v_q_id UUID;
BEGIN
    IF NOT EXISTS (SELECT 1 FROM certifications WHERE id = v_cert_id) THEN
        RAISE NOTICE 'Cert % absent', v_cert_id; RETURN; END IF;
    INSERT INTO certification_themes (id,certification_id,code,label,question_count,display_order)
    VALUES (uuid_generate_v4(),v_cert_id,'azure_compute','Azure Compute',0,0)
    ON CONFLICT (certification_id,code) DO NOTHING;
    INSERT INTO certification_themes (id,certification_id,code,label,question_count,display_order)
    VALUES (uuid_generate_v4(),v_cert_id,'azure_storage','Azure Storage',0,0)
    ON CONFLICT (certification_id,code) DO NOTHING;
    INSERT INTO certification_themes (id,certification_id,code,label,question_count,display_order)
    VALUES (uuid_generate_v4(),v_cert_id,'azure_cosmos_db','Azure Cosmos DB',0,0)
    ON CONFLICT (certification_id,code) DO NOTHING;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-204-001') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='azure_compute' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AZ-204-001',v_cert_id,v_theme_id,'Quel service Azure est un PaaS pour héberger des applications web ?','easy','SINGLE_CHOICE','App Service héberge des applications web, API, et mobile backends.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Azure App Service',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Azure Virtual Machines',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Azure Functions',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Azure Container Instances',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-204-002') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='azure_compute' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AZ-204-002',v_cert_id,v_theme_id,'Quels langages sont supportés par App Service ?','easy','SINGLE_CHOICE','App Service supporte de nombreux langages.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','.NET, Java, Node.js, Python, PHP, Ruby',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','.NET seulement',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Java seulement',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Node.js seulement',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-204-003') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='azure_compute' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AZ-204-003',v_cert_id,v_theme_id,'Qu''est-ce qu''un plan App Service ?','medium','SINGLE_CHOICE','Le plan définit la région, le nombre de VMs, la taille des instances.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Ensemble de ressources de calcul pour les applications',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Type d''application',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Région',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Groupe de ressources',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-204-004') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='azure_compute' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AZ-204-004',v_cert_id,v_theme_id,'Quels sont les niveaux (SKU) du plan App Service ?','hard','SINGLE_CHOICE','Plusieurs niveaux avec différentes capacités et fonctionnalités.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Free, Shared, Basic, Standard, Premium, Isolated',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Free seulement',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Basic seulement',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Premium seulement',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-204-005') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='azure_compute' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AZ-204-005',v_cert_id,v_theme_id,'Qu''est-ce qu''un slot de déploiement ?','hard','SINGLE_CHOICE','Les slots permettent le déploiement sans temps d''arrêt (swap).','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Environnement de staging pour tester avant production',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Instance de base de données',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Région',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Groupe de sécurité',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-204-006') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='azure_compute' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AZ-204-006',v_cert_id,v_theme_id,'Combien de slots de déploiement peut-on avoir par application ?','hard','SINGLE_CHOICE','Le nombre de slots dépend du niveau du plan App Service.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Jusqu''à 20 (selon le SKU)',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','5',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','10',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Illimité',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-204-007') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='azure_compute' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AZ-204-007',v_cert_id,v_theme_id,'Qu''est-ce que le swap de slots ?','hard','SINGLE_CHOICE','Le swap permet de mettre en production un nouveau déploiement sans interruption.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Échanger le slot de staging avec le slot de production',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Copier les fichiers',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Redémarrer l''application',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Changer de région',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-204-008') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='azure_compute' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AZ-204-008',v_cert_id,v_theme_id,'Qu''est-ce que les paramètres d''application (app settings) ?','hard','SINGLE_CHOICE','Les paramètres d''application sont injectés comme variables d''environnement.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Variables d''environnement pour l''application',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Paramètres de build',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Configuration réseau',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Règles de sécurité',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-204-009') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='azure_compute' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AZ-204-009',v_cert_id,v_theme_id,'Les paramètres d''application peuvent-ils être marqués comme ''slot setting'' ?','hard','SINGLE_CHOICE','Les slot settings restent associés à un slot lors du swap.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Oui (collés au slot)',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Uniquement pour les connexions',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Uniquement pour les chaînes',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-204-010') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='azure_compute' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AZ-204-010',v_cert_id,v_theme_id,'Qu''est-ce que l''authentification intégrée App Service ?','hard','SINGLE_CHOICE','App Service fournit une couche d''authentification intégrée (Easy Auth).','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Authentification facile avec AAD, Facebook, Google, etc.',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Authentification personnalisée',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Firewall',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','SSL',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-204-011') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='azure_compute' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AZ-204-011',v_cert_id,v_theme_id,'Qu''est-ce que App Service Managed Certificates ?','hard','SINGLE_CHOICE','App Service peut fournir des certificats SSL gratuits pour les domaines personnalisés.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Certificats SSL gratuits pour les domaines personnalisés',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Certificats payants',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Certificats auto-signés',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Certificats pour les slots',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-204-012') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='azure_compute' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AZ-204-012',v_cert_id,v_theme_id,'Qu''est-ce que l''auto-scaling dans App Service ?','hard','SINGLE_CHOICE','L''auto-scaling ajuste les instances en fonction des métriques (CPU, mémoire, requêtes).','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Ajuster automatiquement le nombre d''instances',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Redimensionner la VM',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Changer de région',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Mettre à jour le plan',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-204-013') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='azure_compute' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AZ-204-013',v_cert_id,v_theme_id,'Qu''est-ce que les diagnostics d''application ?','hard','SINGLE_CHOICE','App Service peut enregistrer les logs d''application, du serveur web, etc.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Collecte des journaux et des traces',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Redémarrage',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Sauvegarde',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Monitoring',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-204-014') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='azure_compute' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AZ-204-014',v_cert_id,v_theme_id,'Où sont stockés les journaux d''App Service ?','hard','SINGLE_CHOICE','Les logs peuvent être envoyés vers plusieurs destinations.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Système de fichiers, Blob Storage, Log Analytics',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Seulement le système de fichiers',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Seulement Blob Storage',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Seulement Log Analytics',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-204-015') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='azure_compute' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AZ-204-015',v_cert_id,v_theme_id,'Qu''est-ce que la fonctionnalité ''Always On'' ?','hard','SINGLE_CHOICE','Always On empêche l''application de se décharger en cas d''inactivité.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Garder l''application chargée en mémoire',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Redémarrer automatiquement',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Mise à l''échelle',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Sauvegarde',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-204-016') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='azure_compute' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AZ-204-016',v_cert_id,v_theme_id,'Qu''est-ce que WebJobs ?','hard','SINGLE_CHOICE','WebJobs permet d''exécuter des scripts en arrière-plan (continu ou déclenché).','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Tâches en arrière-plan dans App Service',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Jobs de base de données',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Jobs de stockage',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Jobs de réseau',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-204-017') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='azure_compute' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AZ-204-017',v_cert_id,v_theme_id,'WebJobs peut-il être déclenché par une file d''attente ?','hard','SINGLE_CHOICE','WebJobs peut être déclenché par des messages de files d''attente (Azure Queue).','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Oui',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Uniquement par timer',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Uniquement par blob',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-204-018') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='azure_compute' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AZ-204-018',v_cert_id,v_theme_id,'Qu''est-ce qu''Azure Functions ?','easy','SINGLE_CHOICE','Azure Functions est le FaaS (Function as a Service) d''Azure.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Service serverless pour exécuter du code',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Service de base de données',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Service de stockage',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Service de réseau',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-204-019') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='azure_compute' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AZ-204-019',v_cert_id,v_theme_id,'Quels langages sont supportés par Azure Functions ?','easy','SINGLE_CHOICE','Azure Functions supporte plusieurs langages.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','C#, JavaScript, Python, Java, PowerShell, TypeScript',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','C# seulement',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','JavaScript seulement',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Python seulement',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-204-020') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='azure_compute' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AZ-204-020',v_cert_id,v_theme_id,'Qu''est-ce qu''un déclencheur (trigger) de fonction ?','medium','SINGLE_CHOICE','Les déclencheurs sont des événements (HTTP, timer, queue, blob, etc.) qui démarrent la fonction.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Événement qui déclenche l''exécution de la fonction',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Sortie de la fonction',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Paramètre de la fonction',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Configuration',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-204-021') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='azure_compute' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AZ-204-021',v_cert_id,v_theme_id,'Quels sont les déclencheurs supportés ?','hard','SINGLE_CHOICE','Azure Functions a de nombreux déclencheurs.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','HTTP, Timer, Blob, Queue, Event Hub, Cosmos DB, etc.',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','HTTP seulement',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Timer seulement',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Blob seulement',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-204-022') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='azure_compute' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AZ-204-022',v_cert_id,v_theme_id,'Qu''est-ce que le plan de consommation (Consumption plan) ?','hard','SINGLE_CHOICE','Le plan de consommation facture l''exécution et le temps CPU.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Facturation par exécution, mise à l''échelle automatique',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Instance dédiée',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Plan premium',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Plan dédié',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-204-023') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='azure_compute' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AZ-204-023',v_cert_id,v_theme_id,'Qu''est-ce que le plan Premium pour Functions ?','hard','SINGLE_CHOICE','Le plan Premium offre des fonctionnalités supplémentaires (VNet, préchauffage).','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Instances toujours prêtes, VNet, plus longue durée',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Facturation par exécution',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Instance dédiée',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Gratuit',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-204-024') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='azure_compute' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AZ-204-024',v_cert_id,v_theme_id,'Qu''est-ce que Durable Functions ?','hard','SINGLE_CHOICE','Durable Functions permet d''écrire des workflows avec état.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Orchestration d''un workflow stateful',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Fonctions durables',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Fonctions longues',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Fonctions récurrentes',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-204-025') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='azure_compute' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AZ-204-025',v_cert_id,v_theme_id,'Quels sont les types de fonctions durables ?','hard','SINGLE_CHOICE','Durable Functions a plusieurs types de fonctions.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Client, Orchestrator, Activity, Entity',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Client seulement',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Orchestrator seulement',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Activity seulement',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-204-026') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='azure_compute' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AZ-204-026',v_cert_id,v_theme_id,'Qu''est-ce que la liaison de sortie (output binding) ?','hard','SINGLE_CHOICE','Les liaisons de sortie simplifient l''écriture vers des services (Blob, Queue, etc.).','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Permet d''écrire des données dans un service sans code',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Entrée de la fonction',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Paramètre',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Configuration',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-204-027') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='azure_compute' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AZ-204-027',v_cert_id,v_theme_id,'Qu''est-ce que le fichier host.json ?','hard','SINGLE_CHOICE','host.json configure les paramètres du runtime (timeout, logging, extensions).','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Configuration globale de l''application Functions',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Fichier de code',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Fichier de déclencheur',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Fichier de liaison',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-204-028') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='azure_compute' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AZ-204-028',v_cert_id,v_theme_id,'Qu''est-ce que le fichier local.settings.json ?','hard','SINGLE_CHOICE','local.settings.json contient les paramètres pour l''exécution locale.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Configuration locale pour le développement',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Configuration de production',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Fichier de code',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Fichier de build',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-204-029') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='azure_compute' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AZ-204-029',v_cert_id,v_theme_id,'Comment sont gérés les secrets dans Functions ?','hard','SINGLE_CHOICE','Les secrets doivent être stockés dans Key Vault ou les paramètres d''application.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Key Vault, paramètres d''application',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Fichier de configuration',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Variables d''environnement locales',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Code',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-204-030') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='azure_compute' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AZ-204-030',v_cert_id,v_theme_id,'Qu''est-ce que le Cold Start dans Functions ?','hard','SINGLE_CHOICE','Le cold start est le temps de chargement d''une fonction qui n''a pas été utilisée récemment.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Délai de démarrage d''une fonction inactive',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Arrêt de la fonction',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Erreur de démarrage',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Redémarrage',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-204-031') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='azure_compute' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AZ-204-031',v_cert_id,v_theme_id,'Comment réduire le cold start ?','hard','SINGLE_CHOICE','Le plan Premium maintient des instances préchauffées pour réduire le cold start.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Plan Premium avec Always Ready',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Plan Consommation',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Réduire le code',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Augmenter la mémoire',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-204-032') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='azure_compute' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AZ-204-032',v_cert_id,v_theme_id,'Quelle est la durée maximale d''une fonction dans le plan Consommation ?','hard','SINGLE_CHOICE','Le timeout maximum est de 10 minutes (configurable, par défaut 5 min).','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','10 minutes',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','5 minutes',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','30 minutes',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','1 heure',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-204-033') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='azure_compute' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AZ-204-033',v_cert_id,v_theme_id,'Quelle est la durée maximale dans le plan Premium ?','hard','SINGLE_CHOICE','Le plan Premium peut aller jusqu''à 1 heure (60 minutes).','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','30 minutes',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','10 minutes',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','1 heure',TRUE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Illimité',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-204-034') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='azure_compute' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AZ-204-034',v_cert_id,v_theme_id,'Qu''est-ce que la mise à l''échelle des Functions ?','hard','SINGLE_CHOICE','Les Functions se mettent à l''échelle automatiquement selon le nombre d''événements.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Ajout automatique d''instances en fonction des événements',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Redimensionnement manuel',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Augmentation de la mémoire',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Changement de région',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-204-035') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='azure_compute' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AZ-204-035',v_cert_id,v_theme_id,'Qu''est-ce que le déclencheur Timer ?','hard','SINGLE_CHOICE','Le déclencheur timer utilise une expression CRON.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Exécute la fonction selon un planning CRON',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Déclencheur HTTP',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Déclencheur blob',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Déclencheur queue',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-204-036') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='azure_compute' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AZ-204-036',v_cert_id,v_theme_id,'Qu''est-ce que le déclencheur HTTP ?','hard','SINGLE_CHOICE','Le déclencheur HTTP permet d''appeler la fonction via une URL.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Déclenche la fonction via une requête HTTP',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Timer',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Queue',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Blob',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-204-037') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='azure_compute' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AZ-204-037',v_cert_id,v_theme_id,'Qu''est-ce que le déclencheur Blob ?','hard','SINGLE_CHOICE','Le déclencheur blob réagit aux événements dans un conteneur blob.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Déclenche la fonction lors de la création/modification d''un blob',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Timer',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Queue',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','HTTP',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-204-038') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='azure_compute' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AZ-204-038',v_cert_id,v_theme_id,'Qu''est-ce que le déclencheur Queue ?','hard','SINGLE_CHOICE','Le déclencheur queue traite les messages d''une file Azure Queue.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Déclenche la fonction lors de l''arrivée d''un message dans une file',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Timer',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Blob',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','HTTP',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-204-039') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='azure_compute' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AZ-204-039',v_cert_id,v_theme_id,'Qu''est-ce que le déclencheur Cosmos DB ?','hard','SINGLE_CHOICE','Le déclencheur Cosmos DB réagit au flux de modifications (change feed).','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Déclenche la fonction sur les changements dans Cosmos DB (Change Feed)',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Timer',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Queue',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Blob',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-204-040') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='azure_compute' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AZ-204-040',v_cert_id,v_theme_id,'Qu''est-ce que le déclencheur Event Hub ?','hard','SINGLE_CHOICE','Le déclencheur Event Hub ingère des flux de données à grande échelle.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Traite des événements en streaming',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Timer',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Queue',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Blob',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-204-041') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='azure_compute' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AZ-204-041',v_cert_id,v_theme_id,'Qu''est-ce que le déclencheur Service Bus ?','hard','SINGLE_CHOICE','Le déclencheur Service Bus lit les messages des files ou abonnements.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Traite des messages de Service Bus (Queue/Topic)',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Timer',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Queue',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Blob',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-204-042') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='azure_compute' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AZ-204-042',v_cert_id,v_theme_id,'Comment gérer les connexions dans Functions ?','hard','SINGLE_CHOICE','Il est recommandé de réutiliser les clients HTTP, Cosmos, etc., pour éviter l''épuisement des ports.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Réutiliser les clients statiques',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Créer un nouveau client à chaque appel',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Utiliser des singletons',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','A et C',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-204-043') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='azure_compute' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AZ-204-043',v_cert_id,v_theme_id,'Qu''est-ce que le mode d''exécution synchrone des fonctions ?','hard','SINGLE_CHOICE','Les fonctions peuvent être synchrones (attendre le résultat) ou asynchrones.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','La fonction s''exécute et retourne une réponse',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','La fonction s''exécute en arrière-plan',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','La fonction est asynchrone',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','La fonction est planifiée',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-204-044') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='azure_compute' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AZ-204-044',v_cert_id,v_theme_id,'Qu''est-ce que les dépendances injectées dans Functions ?','hard','SINGLE_CHOICE','Azure Functions prend en charge l''injection de dépendances (comme ASP.NET Core).','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Injection de dépendances via le constructeur',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Variables globales',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Paramètres',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Configuration',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-204-045') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='azure_compute' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AZ-204-045',v_cert_id,v_theme_id,'Qu''est-ce que le middleware dans Functions ?','hard','SINGLE_CHOICE','Le middleware permet d''intercepter et de traiter les requêtes HTTP avant qu''elles n''atteignent la fonction.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Pipeline de traitement des requêtes HTTP',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Déclencheur',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Liaison',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Configuration',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-204-046') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='azure_compute' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AZ-204-046',v_cert_id,v_theme_id,'Comment déployer une fonction depuis Visual Studio ?','hard','SINGLE_CHOICE','Visual Studio a une option ''Publier'' pour déployer directement sur Azure.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Publier vers Azure',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Copier les fichiers',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','FTP',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','CLI',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-204-047') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='azure_compute' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AZ-204-047',v_cert_id,v_theme_id,'Comment déployer une fonction avec Azure CLI ?','hard','SINGLE_CHOICE','La commande ''func azure functionapp publish'' déploie l''application de fonction.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','func azure functionapp publish',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','az function deploy',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','az webapp deploy',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','az functionapp start',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-204-048') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='azure_compute' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AZ-204-048',v_cert_id,v_theme_id,'Qu''est-ce que l''intégration continue pour Functions ?','hard','SINGLE_CHOICE','Functions peut être configuré pour se déployer automatiquement à partir d''un dépôt Git.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Déploiement automatique depuis GitHub, Azure DevOps, etc.',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Déploiement manuel',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Mise à jour manuelle',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Backup',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-204-049') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='azure_compute' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AZ-204-049',v_cert_id,v_theme_id,'Qu''est-ce que le monitorage des fonctions avec Application Insights ?','hard','SINGLE_CHOICE','Application Insights s''intègre aux Functions pour la surveillance.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Collecte des métriques, logs, traces, et dépendances',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Seulement les logs',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Seulement les métriques',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Seulement les traces',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-204-050') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='azure_compute' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AZ-204-050',v_cert_id,v_theme_id,'Qu''est-ce que le niveau de journalisation (log level) dans Functions ?','hard','SINGLE_CHOICE','Les fonctions supportent plusieurs niveaux de log.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Trace, Debug, Information, Warning, Error, Critical',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Seulement Error',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Seulement Information',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Seulement Warning',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-204-051') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='azure_compute' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AZ-204-051',v_cert_id,v_theme_id,'Comment configurer les variables d''environnement pour Functions ?','hard','SINGLE_CHOICE','Les paramètres d''application sont la méthode recommandée.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Paramètres d''application dans le portail ou local.settings.json',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Fichier .env',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Fichier config',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Variables système',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-204-052') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='azure_compute' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AZ-204-052',v_cert_id,v_theme_id,'Qu''est-ce que les extensions de liaison (binding extensions) ?','hard','SINGLE_CHOICE','Les extensions sont nécessaires pour utiliser certains déclencheurs (Cosmos DB, Event Hub, etc.).','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Extensions qui ajoutent des déclencheurs et des liaisons',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Extensions de code',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Extensions de build',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Extensions de logging',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-204-053') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='azure_compute' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AZ-204-053',v_cert_id,v_theme_id,'Qu''est-ce que le plan Elastic Premium ?','hard','SINGLE_CHOICE','Le plan Premium (anciennement Elastic Premium) offre des fonctionnalités intermédiaires.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Plan avec instances préchauffées, VNet, etc.',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Plan Consommation',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Plan Dédié',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Plan Gratuit',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-204-054') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='azure_compute' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AZ-204-054',v_cert_id,v_theme_id,'Quelle est la limite de mémoire pour une fonction dans le plan Consommation ?','hard','SINGLE_CHOICE','La mémoire maximale est de 1.5 Go dans le plan Consommation.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','1.5 Go',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','2 Go',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','512 Mo',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','4 Go',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-204-055') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='azure_compute' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AZ-204-055',v_cert_id,v_theme_id,'Quelle est la limite de mémoire pour une fonction dans le plan Premium ?','hard','SINGLE_CHOICE','Le plan Premium peut aller jusqu''à 4 Go de mémoire.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','4 Go',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','8 Go',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','2 Go',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','16 Go',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-204-056') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='azure_compute' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AZ-204-056',v_cert_id,v_theme_id,'Qu''est-ce que la fonction proxy dans Functions ?','hard','SINGLE_CHOICE','Les proxies permettent de réécrire les URLs et de rediriger les requêtes.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Redirige les requêtes vers d''autres endpoints',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Proxy HTTP',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Déclencheur',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Liaison',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-204-057') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='azure_compute' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AZ-204-057',v_cert_id,v_theme_id,'Qu''est-ce qu''Azure Container Instances (ACI) ?','hard','SINGLE_CHOICE','ACI permet d''exécuter des conteneurs de manière serverless.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Exécution de conteneurs sans gestion de serveurs',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Service Kubernetes',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Registry de conteneurs',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Orchestration',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-204-058') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='azure_compute' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AZ-204-058',v_cert_id,v_theme_id,'ACI peut-il monter des volumes Azure Files ?','hard','SINGLE_CHOICE','ACI peut monter des partages Azure Files.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Oui',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Uniquement des volumes vides',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Uniquement des volumes secrets',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-204-059') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='azure_compute' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AZ-204-059',v_cert_id,v_theme_id,'ACI peut-il avoir une IP publique ?','hard','SINGLE_CHOICE','ACI peut attribuer une IP publique au conteneur.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Oui',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Uniquement IP privée',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Uniquement avec load balancer',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-204-060') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='azure_compute' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AZ-204-060',v_cert_id,v_theme_id,'ACI est-il facturé à la seconde ?','hard','SINGLE_CHOICE','ACI facture à la seconde de temps d''exécution.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Oui',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','À la minute',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','À l''heure',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-204-061') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='azure_compute' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AZ-204-061',v_cert_id,v_theme_id,'Qu''est-ce qu''Azure Container Registry (ACR) ?','hard','SINGLE_CHOICE','ACR stocke les images de conteneurs privées.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Registre privé pour les images Docker',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Orchestration de conteneurs',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Service de conteneurs serverless',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Kubernetes',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-204-062') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='azure_compute' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AZ-204-062',v_cert_id,v_theme_id,'ACR peut-il être intégré à AKS pour le déploiement ?','hard','SINGLE_CHOICE','AKS peut s''authentifier auprès d''ACR pour tirer les images.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Oui',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Uniquement avec ACI',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Uniquement avec App Service',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-204-063') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='azure_compute' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AZ-204-063',v_cert_id,v_theme_id,'ACR supporte-t-il la réplication géographique ?','hard','SINGLE_CHOICE','La réplication géographique est disponible dans le niveau Premium.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Oui',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Uniquement dans la même région',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Uniquement avec Premium',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-204-064') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='azure_compute' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AZ-204-064',v_cert_id,v_theme_id,'Quelles sont les tâches ACR (ACR Tasks) ?','hard','SINGLE_CHOICE','ACR Tasks permet de construire des images dans le cloud sans Docker Engine local.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Construction et correction d''images dans le cloud',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Scan des vulnérabilités',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Nettoyage',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Réplication',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-204-065') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='azure_compute' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AZ-204-065',v_cert_id,v_theme_id,'Qu''est-ce qu''AKS ?','hard','SINGLE_CHOICE','AKS est le service Kubernetes managé d''Azure.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Service Kubernetes managé',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Service de conteneurs serverless',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Registre de conteneurs',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Service de fonctions',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-204-066') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='azure_compute' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AZ-204-066',v_cert_id,v_theme_id,'AKS gère-t-il le plan de contrôle ?','hard','SINGLE_CHOICE','AKS gère le plan de contrôle (API server, etcd) gratuitement.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Oui',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Partiellement',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Uniquement les nœuds',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-204-067') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='azure_compute' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AZ-204-067',v_cert_id,v_theme_id,'Comment se connecter à AKS ?','hard','SINGLE_CHOICE','La commande ''az aks get-credentials'' configure kubectl.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','kubectl avec az aks get-credentials',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','SSH',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','RDP',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Portail',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-204-068') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='azure_compute' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AZ-204-068',v_cert_id,v_theme_id,'AKS peut-il mettre à l''échelle automatiquement les nœuds ?','hard','SINGLE_CHOICE','Le cluster autoscaler ajuste le nombre de nœuds en fonction de la charge.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Oui (cluster autoscaler)',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Uniquement manuel',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Uniquement horizontal',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-204-069') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='azure_compute' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AZ-204-069',v_cert_id,v_theme_id,'Qu''est-ce que le module de mise à l''échelle horizontale des pods (HPA) ?','hard','SINGLE_CHOICE','HPA ajuste les réplicas de pods en fonction de l''utilisation du CPU, de la mémoire, ou de métriques personnalisées.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Ajuste le nombre de pods en fonction des métriques',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Ajuste le nombre de nœuds',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Redimensionne les pods',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Redéploie les pods',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-204-070') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='azure_compute' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AZ-204-070',v_cert_id,v_theme_id,'Qu''est-ce qu''un groupe de disponibilité pour VMs ?','hard','SINGLE_CHOICE','Les groupes de disponibilité améliorent la disponibilité des VMs.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Ensemble de VMs dans des domaines d''erreur et de mise à jour distincts',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Groupe de sécurité',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Groupe de ressources',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Groupe de mise à l''échelle',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-204-071') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='azure_compute' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AZ-204-071',v_cert_id,v_theme_id,'Qu''est-ce qu''un scale set de machines virtuelles (VMSS) ?','hard','SINGLE_CHOICE','VMSS permet de créer et gérer un ensemble de VMs identiques avec mise à l''échelle automatique.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Groupe de VMs identiques avec mise à l''échelle automatique',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Groupe de disponibilité',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Groupe de sécurité',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Groupe de ressources',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-204-072') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='azure_compute' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AZ-204-072',v_cert_id,v_theme_id,'Qu''est-ce qu''une image de machine virtuelle (managed image) ?','hard','SINGLE_CHOICE','Une image gérée contient le système d''exploitation et les disques de données.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Snapshot d''une VM utilisable pour créer d''autres VMs',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Disque de VM',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Sauvegarde',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Snapshot de disque',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-204-073') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='azure_compute' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AZ-204-073',v_cert_id,v_theme_id,'Qu''est-ce que les extensions de VM ?','hard','SINGLE_CHOICE','Les extensions permettent de configurer ou d''installer des logiciels sur les VMs.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Logiciels installés sur la VM après déploiement (ex: Custom Script)',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Disques supplémentaires',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Interfaces réseau',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Groupes de sécurité',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-204-074') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='azure_compute' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AZ-204-074',v_cert_id,v_theme_id,'Qu''est-ce que l''extension Custom Script ?','hard','SINGLE_CHOICE','Custom Script exécute un script PowerShell ou Bash.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Exécute un script au démarrage de la VM',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Installe un logiciel',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Configure le réseau',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Sauvegarde la VM',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-204-075') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='azure_compute' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AZ-204-075',v_cert_id,v_theme_id,'Qu''est-ce que l''extension DSC (Desired State Configuration) ?','hard','SINGLE_CHOICE','L''extension DSC applique une configuration DSC pour maintenir l''état souhaité.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Applique une configuration DSC',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Exécute un script',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Installe des mises à jour',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Sauvegarde',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-204-076') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='azure_compute' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AZ-204-076',v_cert_id,v_theme_id,'Qu''est-ce que l''extension d''accès à la VM (VMAccess) ?','hard','SINGLE_CHOICE','VMAccess permet de réinitialiser les identifiants d''accès à la VM.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Réinitialiser le mot de passe ou la clé SSH',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Exécuter un script',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Installer un logiciel',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Configurer le réseau',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-204-077') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='azure_compute' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AZ-204-077',v_cert_id,v_theme_id,'Qu''est-ce que le diagnostic de VM ?','hard','SINGLE_CHOICE','Les diagnostics de VM envoient les données de performance vers Azure Monitor.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Collecte des métriques de performance et des logs',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Redémarrage',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Sauvegarde',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Monitoring',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-204-078') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='azure_compute' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AZ-204-078',v_cert_id,v_theme_id,'Qu''est-ce que la gestion des mises à jour pour les VMs ?','hard','SINGLE_CHOICE','Azure Automation peut gérer les mises à jour des VMs Windows et Linux.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Gérer les mises à jour du système d''exploitation via Azure Automation',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Mises à jour manuelles',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Mises à jour automatiques',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Désactiver les mises à jour',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-204-079') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='azure_compute' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AZ-204-079',v_cert_id,v_theme_id,'Qu''est-ce que le redimensionnement d''une VM ?','hard','SINGLE_CHOICE','Le redimensionnement nécessite généralement un arrêt de la VM.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Changer la taille (SKU) de la VM',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Ajouter des disques',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Ajouter des interfaces réseau',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Ajouter des extensions',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-204-080') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='azure_compute' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AZ-204-080',v_cert_id,v_theme_id,'Qu''est-ce que la capture d''une VM ?','hard','SINGLE_CHOICE','La capture (sysprep) prépare la VM pour créer une image réutilisable.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Créer une image généralisée à partir de la VM',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Faire un snapshot',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Sauvegarder',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Arrêter',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-204-081') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='azure_storage' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AZ-204-081',v_cert_id,v_theme_id,'Quels sont les types de comptes de stockage Azure ?','easy','SINGLE_CHOICE','Plusieurs types de comptes pour différents cas d''usage.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','General-purpose v2, BlobStorage, FileStorage, BlockBlobStorage',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','General-purpose seulement',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','BlobStorage seulement',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','FileStorage seulement',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-204-082') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='azure_storage' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AZ-204-082',v_cert_id,v_theme_id,'Quels sont les services de stockage Azure ?','easy','SINGLE_CHOICE','Le compte de stockage expose plusieurs services.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Blob, File, Queue, Table, Disk',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Blob seulement',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','File seulement',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Queue seulement',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-204-083') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='azure_storage' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AZ-204-083',v_cert_id,v_theme_id,'Quels sont les types de blobs ?','easy','SINGLE_CHOICE','Block blob pour les fichiers, Append blob pour les logs, Page blob pour les disques VHD.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Block blob, Append blob, Page blob',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Block blob seulement',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Append blob seulement',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Page blob seulement',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-204-084') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='azure_storage' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AZ-204-084',v_cert_id,v_theme_id,'Qu''est-ce qu''un conteneur de blobs ?','medium','SINGLE_CHOICE','Les conteneurs organisent les blobs et contrôlent l''accès.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Groupement logique de blobs (comme un dossier)',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Type de blob',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Compte de stockage',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Service',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-204-085') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='azure_storage' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AZ-204-085',v_cert_id,v_theme_id,'Quelle est la taille maximale d''un block blob ?','hard','SINGLE_CHOICE','La taille maximale est d''environ 4.75 To (50 000 blocs de 100 Mo).','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Environ 4.75 To',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','1 To',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','5 To',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','2 To',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-204-086') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='azure_storage' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AZ-204-086',v_cert_id,v_theme_id,'Qu''est-ce que le niveau d''accès pour un blob ?','hard','SINGLE_CHOICE','Les niveaux Hot, Cool, Cold, Archive optimisent les coûts selon la fréquence d''accès.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Hot, Cool, Cold, Archive',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Standard, Premium',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Basic, Advanced',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','LRS, ZRS, GRS',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-204-087') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='azure_storage' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AZ-204-087',v_cert_id,v_theme_id,'Quel est le temps de réhydratation d''un blob depuis Archive ?','hard','SINGLE_CHOICE','La réhydratation depuis le niveau Archive peut prendre jusqu''à 15 heures.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Jusqu''à 15 heures',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','1 heure',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','24 heures',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','48 heures',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-204-088') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='azure_storage' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AZ-204-088',v_cert_id,v_theme_id,'Qu''est-ce que le chargement par blocs (block upload) ?','hard','SINGLE_CHOICE','Le chargement par blocs permet d''uploader des fichiers de grande taille de manière fiable.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Diviser un fichier en plusieurs blocs pour l''upload',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Upload en parallèle',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Upload de gros fichiers',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-204-089') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='azure_storage' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AZ-204-089',v_cert_id,v_theme_id,'Qu''est-ce que le service SAS (Shared Access Signature) ?','hard','SINGLE_CHOICE','Une SAS permet un accès délégué sécurisé aux ressources.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','URI donnant un accès limité dans le temps et en permissions',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Clé d''accès complète',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Token OAuth',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Certificat',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-204-090') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='azure_storage' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AZ-204-090',v_cert_id,v_theme_id,'Quels sont les types de SAS ?','hard','SINGLE_CHOICE','Il existe trois types de SAS selon la portée et l''authentification.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Account SAS, Service SAS, User Delegation SAS',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Account SAS seulement',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Service SAS seulement',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','User Delegation SAS seulement',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-204-091') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='azure_storage' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AZ-204-091',v_cert_id,v_theme_id,'Qu''est-ce que la User Delegation SAS ?','hard','SINGLE_CHOICE','La User Delegation SAS utilise un jeton Azure AD pour déléguer l''accès.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','SAS basée sur Azure AD, pas sur les clés',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','SAS au niveau du compte',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','SAS au niveau du service',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','SAS au niveau du conteneur',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-204-092') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='azure_storage' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AZ-204-092',v_cert_id,v_theme_id,'Qu''est-ce que la politique d''accès stockée (stored access policy) ?','hard','SINGLE_CHOICE','Les politiques stockées permettent de gérer et révoquer des SAS facilement.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Définition réutilisable des permissions SAS',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Politique IAM',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Politique de cycle de vie',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Politique de chiffrement',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-204-093') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='azure_storage' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AZ-204-093',v_cert_id,v_theme_id,'Qu''est-ce que le chiffrement côté serveur (SSE) ?','hard','SINGLE_CHOICE','Azure Storage chiffre automatiquement les données au repos avec SSE.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Chiffrement automatique au repos',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Chiffrement côté client',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Chiffrement en transit',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Chiffrement des clés',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-204-094') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='azure_storage' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AZ-204-094',v_cert_id,v_theme_id,'Qu''est-ce que le chiffrement côté client ?','hard','SINGLE_CHOICE','Le client chiffre les données localement avant de les envoyer à Azure.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Chiffrement avant envoi à Azure',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Chiffrement par Azure',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Chiffrement par KMS',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Chiffrement par SSL',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-204-095') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='azure_storage' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AZ-204-095',v_cert_id,v_theme_id,'Qu''est-ce que le journal d''activité (access logs) ?','hard','SINGLE_CHOICE','Les logs d''accès peuvent être activés pour le dépannage.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Enregistrement des requêtes réussies ou échouées',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Journal des erreurs',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Journal des performances',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Journal des modifications',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-204-096') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='azure_storage' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AZ-204-096',v_cert_id,v_theme_id,'Qu''est-ce qu''Azure Files ?','easy','SINGLE_CHOICE','Azure Files offre des partages de fichiers accessibles via SMB.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Partage de fichiers SMB dans le cloud',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Stockage objet',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Base de données',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','File d''attente',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-204-097') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='azure_storage' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AZ-204-097',v_cert_id,v_theme_id,'Azure Files peut-il être monté sur une VM Windows ?','hard','SINGLE_CHOICE','Les partages Azure Files peuvent être montés sur Windows, Linux, et macOS.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Oui',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Uniquement Linux',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Uniquement avec AD',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-204-098') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='azure_storage' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AZ-204-098',v_cert_id,v_theme_id,'Quels sont les niveaux pour Azure Files ?','hard','SINGLE_CHOICE','Les niveaux Transaction optimised (général), Premium (faible latence), Cool (archivage).','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Transaction optimised, Premium, Cool',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Hot, Cool, Cold',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Standard, Premium',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','LRS, ZRS, GRS',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-204-099') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='azure_storage' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AZ-204-099',v_cert_id,v_theme_id,'Qu''est-ce que le snapshot d''un partage de fichiers ?','hard','SINGLE_CHOICE','Les snapshots permettent de restaurer des versions antérieures.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Copie ponctuelle en lecture seule',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Sauvegarde',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Versioning',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Réplication',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-204-100') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='azure_storage' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AZ-204-100',v_cert_id,v_theme_id,'Azure Files peut-il être utilisé avec Azure AD ?','hard','SINGLE_CHOICE','Azure Files peut s''intégrer à Active Directory pour l''authentification.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Oui (identités AD)',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Uniquement avec clés',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Uniquement avec SAS',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-204-101') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='azure_storage' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AZ-204-101',v_cert_id,v_theme_id,'Qu''est-ce qu''Azure Queue Storage ?','easy','SINGLE_CHOICE','Queue Storage est une file d''attente pour le découplage d''applications.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','File d''attente de messages simple',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','File d''attente complexe',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Bus de messages',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Topic de messages',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-204-102') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='azure_storage' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AZ-204-102',v_cert_id,v_theme_id,'Quelle est la taille maximale d''un message dans Queue Storage ?','hard','SINGLE_CHOICE','La taille maximale est 64 Ko (256 Ko avec encodage base64).','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','64 Ko',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','256 Ko',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','1 Mo',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','8 Ko',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-204-103') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='azure_storage' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AZ-204-103',v_cert_id,v_theme_id,'Qu''est-ce que le visibility timeout ?','hard','SINGLE_CHOICE','Le visibility timeout empêche d''autres consommateurs de traiter le même message.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Période pendant laquelle un message est invisible après lecture',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Durée de vie du message',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Délai de livraison',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Timeout de la file',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-204-104') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='azure_storage' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AZ-204-104',v_cert_id,v_theme_id,'Qu''est-ce que le TTL (Time To Live) d''un message ?','hard','SINGLE_CHOICE','Le TTL détermine combien de temps un message reste dans la file avant suppression.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Durée de validité du message dans la file',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Temps de visibilité',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Temps de traitement',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Temps d''inactivité',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-204-105') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='azure_storage' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AZ-204-105',v_cert_id,v_theme_id,'Comment ajouter un message à une file ?','hard','SINGLE_CHOICE','Les API .NET (CloudQueue) et .NET Core (QueueClient) existent.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','CloudQueue.AddMessage()',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','QueueClient.SendMessage()',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Queue.CreateMessage()',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','A et B',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-204-106') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='azure_storage' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AZ-204-106',v_cert_id,v_theme_id,'Comment traiter un message d''une file ?','hard','SINGLE_CHOICE','La réception rend le message invisible, il faut le supprimer après traitement.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','CloudQueue.GetMessage() puis DeleteMessage()',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','QueueClient.ReceiveMessage() puis DeleteMessage()',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Queue.Dequeue()',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','A et B',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-204-107') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='azure_storage' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AZ-204-107',v_cert_id,v_theme_id,'Qu''est-ce qu''Azure Table Storage ?','easy','SINGLE_CHOICE','Table Storage est une base NoSQL clé-valeur (comme Cosmos DB Table API).','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Base NoSQL clé-valeur',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Base relationnelle',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Base document',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Base graphe',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-204-108') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='azure_storage' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AZ-204-108',v_cert_id,v_theme_id,'Quelles sont les clés dans Table Storage ?','hard','SINGLE_CHOICE','PartitionKey partitionne les données, RowKey identifie l''entité dans la partition.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','PartitionKey et RowKey',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Id seulement',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Name seulement',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Key seulement',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-204-109') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='azure_storage' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AZ-204-109',v_cert_id,v_theme_id,'Les requêtes sans PartitionKey sont-elles efficaces ?','hard','SINGLE_CHOICE','Il est recommandé d''inclure PartitionKey pour des requêtes efficaces.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Non (scan de toutes les partitions)',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Oui',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Oui avec RowKey',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Oui avec index',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-204-110') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='azure_storage' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AZ-204-110',v_cert_id,v_theme_id,'Qu''est-ce que la Table Storage API vs Cosmos DB Table API ?','hard','SINGLE_CHOICE','Cosmos DB Table API offre des performances plus élevées et une distribution mondiale.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Cosmos DB Table API est plus performant et globalement distribué',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Identiques',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Table Storage plus performant',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Cosmos DB Table API moins cher',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-204-111') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='azure_storage' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AZ-204-111',v_cert_id,v_theme_id,'Quels sont les types de redondance pour Azure Storage ?','hard','SINGLE_CHOICE','Plusieurs options de redondance (local, zone, géographique, avec accès en lecture).','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','LRS, ZRS, GRS, GZRS, RA-GRS, RA-GZRS',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','LRS seulement',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','ZRS seulement',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','GRS seulement',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-204-112') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='azure_storage' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AZ-204-112',v_cert_id,v_theme_id,'Qu''est-ce que LRS (Locally Redundant Storage) ?','hard','SINGLE_CHOICE','LRS réplique les données 3 fois dans un même centre de données.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Réplication dans un même centre de données',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Réplication dans une zone',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Réplication dans une région',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Réplication géographique',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-204-113') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='azure_storage' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AZ-204-113',v_cert_id,v_theme_id,'Qu''est-ce que ZRS (Zone-Redundant Storage) ?','hard','SINGLE_CHOICE','ZRS réplique les données sur 3 zones de disponibilité dans une région.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Réplication sur 3 zones de disponibilité',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Réplication sur 2 centres',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Réplication géographique',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Réplication locale',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-204-114') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='azure_storage' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AZ-204-114',v_cert_id,v_theme_id,'Qu''est-ce que GRS (Geo-Redundant Storage) ?','hard','SINGLE_CHOICE','GRS réplique les données dans une région secondaire distante.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Réplication dans une région secondaire',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Réplication locale',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Réplication en zone',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Réplication en ligne',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-204-115') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='azure_storage' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AZ-204-115',v_cert_id,v_theme_id,'Qu''est-ce que RA-GRS (Read-Access Geo-Redundant Storage) ?','hard','SINGLE_CHOICE','RA-GRS permet de lire les données depuis la région secondaire.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','GRS avec accès en lecture à la région secondaire',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','GRS seulement',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','ZRS avec accès en lecture',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','LRS avec accès en lecture',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-204-116') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='azure_storage' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AZ-204-116',v_cert_id,v_theme_id,'Qu''est-ce que la gestion du cycle de vie (lifecycle management) ?','hard','SINGLE_CHOICE','Les règles de cycle de vie automatisent le passage entre les niveaux d''accès.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Règles automatiques pour déplacer ou supprimer des blobs',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Sauvegarde automatique',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Réplication automatique',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Chiffrement automatique',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-204-117') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='azure_storage' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AZ-204-117',v_cert_id,v_theme_id,'Azure Storage peut-il héberger un site web statique ?','hard','SINGLE_CHOICE','Le stockage Blob peut héberger des sites web statiques (HTML, CSS, JS).','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Oui',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Uniquement avec CDN',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Uniquement avec App Service',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-204-118') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='azure_storage' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AZ-204-118',v_cert_id,v_theme_id,'Quel est l''endpoint pour un site statique ?','hard','SINGLE_CHOICE','L''endpoint de site statique est différent de l''endpoint blob.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','https://account.z6.web.core.windows.net',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','https://account.blob.core.windows.net',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','https://account.file.core.windows.net',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','https://account.queue.core.windows.net',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-204-119') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='azure_storage' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AZ-204-119',v_cert_id,v_theme_id,'Qu''est-ce qu''Azure Data Lake Storage (ADLS) Gen2 ?','hard','SINGLE_CHOICE','ADLS Gen2 combine le stockage blob avec un système de fichiers hiérarchique.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Stockage hiérarchique pour big data',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Stockage objet',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Base de données',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Cache',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-204-120') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='azure_storage' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AZ-204-120',v_cert_id,v_theme_id,'ADLS Gen2 supporte-t-il les ACL POSIX ?','hard','SINGLE_CHOICE','ADLS Gen2 supporte les ACL POSIX pour le contrôle d''accès granulaire.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Oui',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Uniquement les ACL Windows',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Uniquement les RBAC',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-204-121') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='azure_storage' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AZ-204-121',v_cert_id,v_theme_id,'Qu''est-ce qu''Azure Storage Explorer ?','hard','SINGLE_CHOICE','Storage Explorer est une application de bureau multiplateforme.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Outil graphique pour gérer le stockage',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','CLI',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','API',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Portail',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-204-122') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='azure_storage' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AZ-204-122',v_cert_id,v_theme_id,'Qu''est-ce qu''AzCopy ?','hard','SINGLE_CHOICE','AzCopy est un utilitaire de copie de données performant.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Outil en ligne de commande pour copier des données',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Outil graphique',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','API',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Service',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-204-123') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='azure_storage' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AZ-204-123',v_cert_id,v_theme_id,'AzCopy peut-il synchroniser des dossiers locaux avec un conteneur blob ?','hard','SINGLE_CHOICE','AzCopy supporte la synchronisation (upload, download, copie).','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Oui',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Uniquement l''upload',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Uniquement le download',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-204-124') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='azure_storage' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AZ-204-124',v_cert_id,v_theme_id,'Azure Storage SDK existe-t-il pour .NET ?','hard','SINGLE_CHOICE','Azure SDK est disponible pour .NET, Java, Python, JavaScript, Go, etc.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Oui',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Uniquement pour Java',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Uniquement pour Python',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-204-125') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='azure_storage' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AZ-204-125',v_cert_id,v_theme_id,'Comment se connecter au stockage avec le SDK .NET ?','hard','SINGLE_CHOICE','Le SDK supporte les chaînes de connexion et l''authentification Azure AD.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Utiliser la chaîne de connexion ou DefaultAzureCredential',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Mot de passe',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Certificat',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Token',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-204-126') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='azure_storage' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AZ-204-126',v_cert_id,v_theme_id,'Qu''est-ce que la suppression réversible (soft delete) dans Blob Storage ?','hard','SINGLE_CHOICE','Soft delete permet de récupérer des blobs supprimés accidentellement.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Conservation des blobs supprimés pendant une période récupérable',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Suppression définitive',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Archivage',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Snapshot',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-204-127') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='azure_storage' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AZ-204-127',v_cert_id,v_theme_id,'Qu''est-ce que le versioning des blobs ?','hard','SINGLE_CHOICE','Le versioning crée automatiquement une nouvelle version à chaque modification.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Conserve les versions antérieures des blobs',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Supprime les versions',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Snapshot',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Soft delete',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-204-128') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='azure_storage' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AZ-204-128',v_cert_id,v_theme_id,'Qu''est-ce que le change feed (flux de modifications) ?','hard','SINGLE_CHOICE','Le change feed enregistre les événements de création, modification, suppression de blobs.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Journal des modifications des blobs',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Snapshot',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Versioning',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Soft delete',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-204-129') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='azure_storage' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AZ-204-129',v_cert_id,v_theme_id,'Qu''est-ce que la réplication d''objets ?','hard','SINGLE_CHOICE','La réplication d''objets copie les blobs vers un autre compte pour la DR ou la proximité.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Réplique les blobs asynchrone entre comptes',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Réplication synchrone',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Réplication locale',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Réplication de zones',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-204-130') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='azure_storage' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AZ-204-130',v_cert_id,v_theme_id,'Azure Storage peut-il envoyer des événements à Event Grid ?','hard','SINGLE_CHOICE','Les événements de stockage (création, suppression) peuvent être envoyés à Event Grid.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Oui',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Uniquement pour les blobs',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Uniquement pour les files',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-204-131') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='azure_storage' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AZ-204-131',v_cert_id,v_theme_id,'Quelles métriques sont disponibles pour le stockage ?','hard','SINGLE_CHOICE','Azure Monitor collecte des métriques détaillées pour le stockage.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Capacité, transactions, latence, disponibilité',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Seulement capacité',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Seulement transactions',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Seulement latence',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-204-132') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='azure_storage' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AZ-204-132',v_cert_id,v_theme_id,'Où sont envoyés les journaux de diagnostic de stockage ?','hard','SINGLE_CHOICE','Les paramètres de diagnostic peuvent envoyer les logs vers plusieurs destinations.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Log Analytics, Storage Account, Event Hub',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Seulement Log Analytics',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Seulement Storage Account',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Seulement Event Hub',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-204-133') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='azure_storage' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AZ-204-133',v_cert_id,v_theme_id,'Azure Storage peut-il utiliser Azure AD pour l''authentification ?','hard','SINGLE_CHOICE','Azure AD est supporté pour Blob, Queue, Table (pas encore pour Files).','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Oui (pour Blob, Queue, Table)',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Uniquement pour Files',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Uniquement pour Blob',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-204-134') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='azure_storage' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AZ-204-134',v_cert_id,v_theme_id,'Qu''est-ce que l''authentification par clé partagée ?','hard','SINGLE_CHOICE','Les clés d''accès donnent un accès complet au compte.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Utilisation des clés d''accès du compte de stockage',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Azure AD',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','SAS',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Certificat',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-204-135') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='azure_storage' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AZ-204-135',v_cert_id,v_theme_id,'Peut-on restreindre l''accès au stockage à des réseaux spécifiques ?','hard','SINGLE_CHOICE','Les pare-feu et les règles de réseau virtuel limitent l''accès.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Oui',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Uniquement à des IP publiques',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Uniquement à des VNet',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-204-136') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='azure_storage' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AZ-204-136',v_cert_id,v_theme_id,'Qu''est-ce qu''un point de terminaison privé (private endpoint) ?','hard','SINGLE_CHOICE','Les points de terminaison privés permettent un accès sécurisé via le réseau privé.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','IP privée dans un VNet pour accéder au stockage',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','IP publique',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Service endpoint',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','VPN',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-204-137') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='azure_storage' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AZ-204-137',v_cert_id,v_theme_id,'Qu''est-ce qu''un service endpoint ?','hard','SINGLE_CHOICE','Les service endpoints étendent l''identité du VNet au service Azure.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Permet d''accéder au stockage depuis un VNet via Azure backbone',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','IP privée',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','VPN',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','ExpressRoute',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-204-138') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='azure_storage' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AZ-204-138',v_cert_id,v_theme_id,'Comment réduire les coûts de stockage ?','hard','SINGLE_CHOICE','Les lifecycle policies et le choix du niveau d''accès sont clés.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Utiliser les niveaux d''accès appropriés, lifecycle policies, suppression des données inutiles',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Augmenter la redondance',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Utiliser le stockage premium',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Désactiver le chiffrement',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-204-139') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='azure_storage' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AZ-204-139',v_cert_id,v_theme_id,'Quelle est la bonne pratique pour les clés d''accès ?','hard','SINGLE_CHOICE','Les clés d''accès doivent être tournées et protégées (Key Vault).','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Rotation régulière, ne pas les coder en dur',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Les partager largement',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Les coder dans l''application',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Ne jamais les changer',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-204-140') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='azure_storage' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AZ-204-140',v_cert_id,v_theme_id,'Pour les charges lourdes, comment améliorer les performances ?','hard','SINGLE_CHOICE','Les noms aléatoires répartissent la charge sur les partitions.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Utiliser des noms de blobs aléatoires pour éviter les goulots d''étranglement',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Noms séquentiels',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Petits blobs',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Beaucoup de conteneurs',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-204-141') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='azure_cosmos_db' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AZ-204-141',v_cert_id,v_theme_id,'Qu''est-ce qu''Azure Cosmos DB ?','easy','SINGLE_CHOICE','Cosmos DB est une base NoSQL multi-modèle et globalement distribuée.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Base de données NoSQL distribuée globalement',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Base relationnelle',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Data warehouse',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Cache',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-204-142') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='azure_cosmos_db' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AZ-204-142',v_cert_id,v_theme_id,'Quels modèles de données (API) sont supportés ?','easy','SINGLE_CHOICE','Cosmos DB supporte plusieurs API pour la compatibilité.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Core (SQL), MongoDB, Cassandra, Gremlin, Table',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','SQL seulement',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','MongoDB seulement',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Cassandra seulement',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-204-143') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='azure_cosmos_db' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AZ-204-143',v_cert_id,v_theme_id,'Qu''est-ce que la distribution globale (global distribution) ?','medium','SINGLE_CHOICE','La distribution globale permet une faible latence pour les utilisateurs du monde entier.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Répliquer les données dans plusieurs régions',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Partitionnement',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Indexation',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Backup',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-204-144') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='azure_cosmos_db' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AZ-204-144',v_cert_id,v_theme_id,'Qu''est-ce que le throughput (débit) en RU/s ?','hard','SINGLE_CHOICE','RU/s mesure le débit de traitement, normalisé pour tous les types d''opérations.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Request Units par seconde (mesure de débit normalisé)',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Nombre de requêtes',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Taille des données',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Latence',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-204-145') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='azure_cosmos_db' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AZ-204-145',v_cert_id,v_theme_id,'Qu''est-ce que le partitionnement (partitioning) ?','hard','SINGLE_CHOICE','Le partitionnement est clé pour la scalabilité horizontale.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Division des données en partitions physiques pour la scalabilité',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Réplication',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Indexation',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Sauvegarde',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-204-146') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='azure_cosmos_db' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AZ-204-146',v_cert_id,v_theme_id,'Qu''est-ce qu''une clé de partition (partition key) ?','hard','SINGLE_CHOICE','La clé de partition détermine comment les données sont distribuées.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Attribut utilisé pour répartir les données entre les partitions',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Clé primaire',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Clé étrangère',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Index',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-204-147') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='azure_cosmos_db' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AZ-204-147',v_cert_id,v_theme_id,'Qu''est-ce qu''une partition logique ?','hard','SINGLE_CHOICE','Les partitions logiques sont contenues dans des partitions physiques.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Ensemble d''éléments avec la même valeur de clé de partition',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Partition physique',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Shard',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Réplica',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-204-148') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='azure_cosmos_db' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AZ-204-148',v_cert_id,v_theme_id,'Quel langage de requête utilise l''API Core (SQL) ?','hard','SINGLE_CHOICE','L''API Core utilise une syntaxe SQL-like pour interroger les documents JSON.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','SQL-like (syntaxe proche de SQL)',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','MongoDB Query Language',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Gremlin',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Cassandra CQL',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-204-149') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='azure_cosmos_db' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AZ-204-149',v_cert_id,v_theme_id,'Comment sélectionner tous les documents d''un conteneur ?','hard','SINGLE_CHOICE','La requête utilise ''c'' comme alias du conteneur.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','SELECT * FROM c',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','SELECT * FROM container',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','SELECT * FROM documents',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','SELECT * FROM items',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-204-150') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='azure_cosmos_db' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AZ-204-150',v_cert_id,v_theme_id,'Comment filtrer avec une condition ?','hard','SINGLE_CHOICE','La clause WHERE filtre les documents.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','SELECT * FROM c WHERE c.age > 18',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','WHERE c.age > 18',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','FILTER c.age > 18',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','c.age > 18',FALSE,3);
    END IF;
END $$;
