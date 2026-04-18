-- =============================================================================
-- V6b__seed_questions_pool_b.sql
-- CertifApp — Import pool questions (500 questions, aws_saa certifications)
-- Idempotent : INSERT ... ON CONFLICT DO NOTHING
-- =============================================================================

-- ── AWS_SAA (500 questions) ──────
DO $$
DECLARE
    v_cert_id TEXT := 'aws_saa';
    v_theme_id UUID; v_q_id UUID; v_opt_id UUID;
BEGIN
    IF NOT EXISTS (SELECT 1 FROM certifications WHERE id = v_cert_id) THEN
        RAISE NOTICE 'Certification % absente', v_cert_id; RETURN;
    END IF;
    INSERT INTO certification_themes (id, certification_id, code, label, question_count, display_order)
    VALUES (uuid_generate_v4(), v_cert_id, 'compute', 'Compute', 0, 0)
    ON CONFLICT (certification_id, code) DO NOTHING;
    INSERT INTO certification_themes (id, certification_id, code, label, question_count, display_order)
    VALUES (uuid_generate_v4(), v_cert_id, 'storage', 'Storage', 0, 0)
    ON CONFLICT (certification_id, code) DO NOTHING;
    INSERT INTO certification_themes (id, certification_id, code, label, question_count, display_order)
    VALUES (uuid_generate_v4(), v_cert_id, 'database', 'Database', 0, 0)
    ON CONFLICT (certification_id, code) DO NOTHING;
    INSERT INTO certification_themes (id, certification_id, code, label, question_count, display_order)
    VALUES (uuid_generate_v4(), v_cert_id, 'networking', 'Networking', 0, 0)
    ON CONFLICT (certification_id, code) DO NOTHING;
    INSERT INTO certification_themes (id, certification_id, code, label, question_count, display_order)
    VALUES (uuid_generate_v4(), v_cert_id, 'security___iam', 'Security & IAM', 0, 0)
    ON CONFLICT (certification_id, code) DO NOTHING;
    INSERT INTO certification_themes (id, certification_id, code, label, question_count, display_order)
    VALUES (uuid_generate_v4(), v_cert_id, 'high_availability___scalability', 'High Availability & Scalability', 0, 0)
    ON CONFLICT (certification_id, code) DO NOTHING;
    INSERT INTO certification_themes (id, certification_id, code, label, question_count, display_order)
    VALUES (uuid_generate_v4(), v_cert_id, 'monitoring___logging', 'Monitoring & Logging', 0, 0)
    ON CONFLICT (certification_id, code) DO NOTHING;
    INSERT INTO certification_themes (id, certification_id, code, label, question_count, display_order)
    VALUES (uuid_generate_v4(), v_cert_id, 'pricing___support', 'Pricing & Support', 0, 0)
    ON CONFLICT (certification_id, code) DO NOTHING;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-001') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='compute' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-001',v_cert_id,v_theme_id,'Quel type d''adresse IP est associé à une instance EC2 et change à chaque arrêt/démarrage ?','easy','SINGLE_CHOICE','L''adresse IP publique d''une instance EC2 change à chaque arrêt/démarrage. L''Elastic IP est statique.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Elastic IP',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Public IP',TRUE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Private IP',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Static IP',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-002') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='compute' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-002',v_cert_id,v_theme_id,'Qu''est-ce qu''une Elastic IP ?','easy','SINGLE_CHOICE','Une Elastic IP est une adresse IPv4 publique statique que vous pouvez associer à une instance EC2.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Adresse IP statique publique',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Adresse IP privée',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Adresse IP changeante',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Adresse IP de loopback',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-003') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='compute' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-003',v_cert_id,v_theme_id,'Quel type d''instance EC2 est optimisé pour le calcul (compute optimized) ?','easy','SINGLE_CHOICE','c5 est optimisé pour le calcul (Compute optimized).','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','c5',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','m5',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','r5',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','i3',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-004') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='compute' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-004',v_cert_id,v_theme_id,'Quel type d''instance EC2 est optimisé pour la mémoire ?','easy','SINGLE_CHOICE','r5 est optimisé pour la mémoire (Memory optimized).','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','r5',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','m5',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','c5',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','i3',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-005') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='compute' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-005',v_cert_id,v_theme_id,'Quel type d''instance EC2 est à usage général ?','medium','SINGLE_CHOICE','m5 est à usage général (General purpose).','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','m5',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','c5',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','r5',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','i3',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-006') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='compute' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-006',v_cert_id,v_theme_id,'Quelle est la différence entre un Security Group et un Network ACL ?','medium','SINGLE_CHOICE','Security Group est stateful (retour automatique), NACL est stateless (règles aller/retour séparées).','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Security Group est stateful, NACL est stateless',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Security Group est stateless, NACL est stateful',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Les deux sont stateful',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Les deux sont stateless',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-007') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='compute' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-007',v_cert_id,v_theme_id,'Combien de Security Groups peut-on associer à une instance EC2 ?','medium','SINGLE_CHOICE','Jusqu''à 5 Security Groups par interface réseau (par défaut).','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Jusqu''à 5',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Jusqu''à 10',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Jusqu''à 20',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Illimité',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-008') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='compute' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-008',v_cert_id,v_theme_id,'Quelle est la règle par défaut d''un Security Group ?','hard','SINGLE_CHOICE','Par défaut, inbound est bloqué, outbound est autorisé.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Tout le trafic entrant est bloqué, tout le trafic sortant est autorisé',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Tout le trafic entrant est autorisé, tout le trafic sortant est bloqué',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Tout le trafic est bloqué',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Tout le trafic est autorisé',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-009') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='compute' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-009',v_cert_id,v_theme_id,'Qu''est-ce qu''un placement group ?','hard','SINGLE_CHOICE','Un placement group détermine comment les instances sont placées physiquement.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Groupement d''instances EC2',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Type d''instance',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Région AWS',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Zone de disponibilité',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-010') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='compute' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-010',v_cert_id,v_theme_id,'Quel placement group est utilisé pour une faible latence réseau ?','hard','SINGLE_CHOICE','Cluster Placement Group regroupe les instances dans une même AZ pour une faible latence.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Cluster',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Spread',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Partition',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Default',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-011') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='compute' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-011',v_cert_id,v_theme_id,'Quel placement group répartit les instances sur du matériel distinct ?','hard','SINGLE_CHOICE','Spread Placement Group place chaque instance sur du matériel distinct.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Spread',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Cluster',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Partition',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Distributed',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-012') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='compute' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-012',v_cert_id,v_theme_id,'Combien d''instances maximum dans un Spread Placement Group ?','hard','SINGLE_CHOICE','Maximum 7 instances par AZ dans un Spread Placement Group.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','7',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','10',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','20',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Illimité',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-013') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='compute' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-013',v_cert_id,v_theme_id,'Qu''est-ce qu''une AMI ?','hard','SINGLE_CHOICE','Une AMI est un template contenant le système d''exploitation et les logiciels.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Amazon Machine Image (template d''instance)',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','AWS Management Interface',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Amazon Memory Instance',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Application Management Image',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-014') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='compute' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-014',v_cert_id,v_theme_id,'Peut-on partager une AMI avec un autre compte AWS ?','medium','SINGLE_CHOICE','On peut partager une AMI avec des comptes spécifiques ou la rendre publique.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Oui',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Uniquement avec AWS Organizations',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Uniquement si publique',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-015') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='compute' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-015',v_cert_id,v_theme_id,'Qu''est-ce qu''un EC2 User Data ?','hard','SINGLE_CHOICE','User Data permet d''exécuter des scripts au premier démarrage de l''instance.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Script exécuté au démarrage de l''instance',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Données utilisateur chiffrées',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Métadonnées de l''instance',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Configuration réseau',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-016') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='compute' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-016',v_cert_id,v_theme_id,'Quelle est la limite de taille des User Data ?','hard','SINGLE_CHOICE','Les User Data sont limités à 16 KB.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','16 KB',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','64 KB',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','256 KB',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','1 MB',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-017') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='compute' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-017',v_cert_id,v_theme_id,'Qu''est-ce que le EC2 Instance Metadata Service (IMDS) ?','hard','SINGLE_CHOICE','IMDS donne accès aux métadonnées de l''instance (IP, AMI, rôle IAM, etc.).','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Service fournissant des informations sur l''instance',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Service de monitoring',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Service de logging',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Service de backup',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-018') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='compute' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-018',v_cert_id,v_theme_id,'Quelle version d''IMDS est recommandée pour la sécurité ?','hard','SINGLE_CHOICE','IMDSv2 est plus sécurisé (requiert un token).','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','IMDSv2',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','IMDSv1',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Les deux',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Aucune',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-019') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='compute' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-019',v_cert_id,v_theme_id,'Qu''est-ce que le EC2 Instance Recovery ?','hard','SINGLE_CHOICE','Instance Recovery redémarre l''instance sur un nouveau matériel en cas de défaillance.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Redémarrage automatique sur un nouveau matériel',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Backup automatique',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Snapshot automatique',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Migration vers une autre région',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-020') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='compute' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-020',v_cert_id,v_theme_id,'Qu''est-ce qu''une instance spot ?','hard','SINGLE_CHOICE','Les instances spot utilisent la capacité excédentaire à prix réduit, mais peuvent être interrompues.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Instance à prix réduit avec risque d''interruption',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Instance dédiée',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Instance réservée',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Instance à la demande',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-021') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='compute' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-021',v_cert_id,v_theme_id,'Quel est le préavis avant interruption d''une instance spot ?','hard','SINGLE_CHOICE','AWS donne un préavis de 2 minutes avant l''interruption d''une instance spot.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','2 minutes',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','5 minutes',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','10 minutes',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','30 minutes',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-022') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='compute' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-022',v_cert_id,v_theme_id,'Que sont les instances réservées ?','hard','SINGLE_CHOICE','Les instances réservées offrent des réductions en échange d''un engagement.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Engagement de 1 ou 3 ans pour une réduction de prix',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Instances gratuites',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Instances à la demande',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Instances spot',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-023') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='compute' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-023',v_cert_id,v_theme_id,'Quelles sont les options de paiement pour les instances réservées ?','hard','SINGLE_CHOICE','Trois options de paiement : tout upfront, partiel upfront, sans upfront.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','All Upfront, Partial Upfront, No Upfront',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Mensuel, Trimestriel, Annuel',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','À la demande uniquement',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Pay as you go',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-024') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='compute' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-024',v_cert_id,v_theme_id,'Que sont les instances dédiées (Dedicated Instances) ?','hard','SINGLE_CHOICE','Les instances dédiées s''exécutent sur du matériel dédié à votre compte.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Instances sur matériel dédié',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Instances partagées',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Instances réservées',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Instances spot',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-025') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='compute' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-025',v_cert_id,v_theme_id,'Qu''est-ce qu''un hôte dédié (Dedicated Host) ?','hard','SINGLE_CHOICE','Un hôte dédié vous donne un serveur physique entier.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Serveur physique complet dédié',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Instance dédiée',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Matériel partagé',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Zone de disponibilité',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-026') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='compute' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-026',v_cert_id,v_theme_id,'Quelle est la différence entre Dedicated Host et Dedicated Instance ?','hard','SINGLE_CHOICE','Dedicated Host permet de voir et contrôler le placement des instances sur le serveur.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Dedicated Host donne contrôle sur le placement des instances',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Identiques',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Dedicated Instance donne contrôle sur le matériel',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Dedicated Host moins cher',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-027') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='compute' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-027',v_cert_id,v_theme_id,'Qu''est-ce qu''un Auto Scaling Group ?','hard','SINGLE_CHOICE','Auto Scaling Group ajuste le nombre d''instances selon la charge.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Groupe d''instances qui s''ajustent automatiquement',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Groupe de sécurité',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Placement group',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Load balancer',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-028') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='compute' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-028',v_cert_id,v_theme_id,'Quels sont les trois composants d''un Auto Scaling Group ?','hard','SINGLE_CHOICE','Les composants sont : template de lancement, politiques de scaling, taille min/max/désirée.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Launch template, Scaling policies, Size',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Launch template, VPC, Subnet',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Launch template, Security Group, IAM',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Launch template, AMI, Instance type',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-029') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='compute' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-029',v_cert_id,v_theme_id,'Qu''est-ce qu''une politique de scaling dynamique ?','hard','SINGLE_CHOICE','Le scaling dynamique utilise des métriques CloudWatch (CPU, réseau, etc.).','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Ajuste le nombre d''instances en fonction des métriques',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Planification fixe',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Scaling manuel',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Scaling prédictif',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-030') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='compute' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-030',v_cert_id,v_theme_id,'Qu''est-ce qu''un scheduled scaling ?','hard','SINGLE_CHOICE','Scheduled scaling planifie des changements à des moments prévus.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Scaling à heures fixes',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Scaling basé sur métriques',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Scaling manuel',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Scaling prédictif',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-031') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='compute' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-031',v_cert_id,v_theme_id,'Quel service AWS permet d''exécuter du code sans provisionner de serveurs ?','easy','SINGLE_CHOICE','Lambda est le service serverless d''AWS.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Lambda',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','EC2',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','ECS',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Fargate',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-032') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='compute' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-032',v_cert_id,v_theme_id,'Quel est le timeout maximum pour une fonction Lambda ?','medium','SINGLE_CHOICE','Le timeout maximum est 15 minutes (900 secondes).','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','15 minutes',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','5 minutes',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','30 minutes',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','1 heure',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-033') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='compute' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-033',v_cert_id,v_theme_id,'Quelle est la mémoire maximale pour Lambda ?','medium','SINGLE_CHOICE','La mémoire maximale est 10 Go (et jusqu''à 6 vCPU).','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','10 Go',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','5 Go',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','3 Go',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','1 Go',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-034') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='compute' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-034',v_cert_id,v_theme_id,'Quelle est la taille maximale du code déployé pour Lambda ?','hard','SINGLE_CHOICE','50 Mo compressé, 250 Mo non compressé.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','50 Mo (zip), 250 Mo (non compressé)',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','100 Mo',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','250 Mo',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','500 Mo',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-035') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='compute' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-035',v_cert_id,v_theme_id,'Lambda peut-il être déclenché par un événement S3 ?','hard','SINGLE_CHOICE','Lambda peut être déclenché par des événements S3 (création, suppression).','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Oui',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Uniquement avec SQS',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Uniquement avec SNS',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-036') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='compute' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-036',v_cert_id,v_theme_id,'Lambda peut-il être déclenché par un événement DynamoDB Streams ?','hard','SINGLE_CHOICE','Lambda peut traiter les changements de DynamoDB via Streams.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Oui',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Uniquement avec Kinesis',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Uniquement avec SQS',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-037') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='compute' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-037',v_cert_id,v_theme_id,'Lambda peut-il être déclenché par API Gateway ?','hard','SINGLE_CHOICE','API Gateway est un déclencheur courant pour Lambda (REST/HTTP APIs).','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Oui',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Uniquement avec REST',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Uniquement avec HTTP',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-038') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='compute' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-038',v_cert_id,v_theme_id,'Qu''est-ce que Lambda@Edge ?','hard','SINGLE_CHOICE','Lambda@Edge exécute du code près des utilisateurs via CloudFront.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Lambda exécuté sur les edge locations CloudFront',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Lambda en Europe',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Lambda global',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Lambda avec plus de mémoire',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-039') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='compute' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-039',v_cert_id,v_theme_id,'Qu''est-ce que le provisionned concurrency ?','hard','SINGLE_CHOICE','Provisioned concurrency maintient des instances chaudes pour réduire la latence.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Garde des instances Lambda pré-initialisées',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Limite le nombre d''exécutions',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Augmente le timeout',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Réduit la mémoire',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-040') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='compute' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-040',v_cert_id,v_theme_id,'Qu''est-ce que le reserved concurrency ?','hard','SINGLE_CHOICE','Reserved concurrency limite le nombre d''instances simultanées.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Limite le nombre d''exécutions concurrentes',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Réserve de la capacité',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Augmente la mémoire',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Réduit les coûts',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-041') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='compute' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-041',v_cert_id,v_theme_id,'Que signifie ECS ?','easy','SINGLE_CHOICE','ECS est le service d''orchestration de conteneurs d''AWS.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Elastic Container Service',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Elastic Compute Service',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Elastic Container System',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Elastic Compute System',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-042') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='compute' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-042',v_cert_id,v_theme_id,'Quels sont les modes de lancement ECS ?','medium','SINGLE_CHOICE','ECS peut s''exécuter sur Fargate (serverless) ou sur EC2 (géré par client).','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Fargate et EC2',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Fargate seulement',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','EC2 seulement',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Lambda et EC2',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-043') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='compute' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-043',v_cert_id,v_theme_id,'Qu''est-ce que Fargate ?','hard','SINGLE_CHOICE','Fargate exécute des conteneurs sans gérer les serveurs.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Moteur serverless pour conteneurs',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Type d''instance EC2',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Service de stockage',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Base de données',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-044') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='compute' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-044',v_cert_id,v_theme_id,'Qu''est-ce qu''une task definition ECS ?','hard','SINGLE_CHOICE','La task definition décrit les conteneurs (image, CPU, mémoire, etc.).','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Configuration d''un conteneur',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Instance EC2',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Service',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Cluster',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-045') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='compute' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-045',v_cert_id,v_theme_id,'Qu''est-ce qu''un service ECS ?','hard','SINGLE_CHOICE','Un service ECS garantit qu''un certain nombre de tâches tournent.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Maintient un nombre de tâches en cours d''exécution',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Task definition',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Cluster',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Load balancer',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-046') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='compute' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-046',v_cert_id,v_theme_id,'Quel service AWS est utilisé pour stocker les images Docker ?','hard','SINGLE_CHOICE','ECR (Elastic Container Registry) stocke les images Docker.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','ECR',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','S3',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','EFS',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','EBS',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-047') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='compute' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-047',v_cert_id,v_theme_id,'Que signifie EKS ?','easy','SINGLE_CHOICE','EKS est le service Kubernetes managé d''AWS.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Elastic Kubernetes Service',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Elastic Kinesis Service',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Elastic Key Service',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Elastic Knowledge Service',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-048') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='compute' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-048',v_cert_id,v_theme_id,'EKS est-il compatible avec Kubernetes upstream ?','hard','SINGLE_CHOICE','EKS est certifié Kubernetes conforme.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Oui',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Partiellement',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Version modifiée',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-049') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='compute' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-049',v_cert_id,v_theme_id,'Quel plan de contrôle EKS est géré par AWS ?','hard','SINGLE_CHOICE','AWS gère le control plane, le client gère les worker nodes.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Control plane (API server, etcd)',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Worker nodes',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Les deux',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Aucun',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-050') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='compute' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-050',v_cert_id,v_theme_id,'Quelles sont les options pour les worker nodes EKS ?','hard','SINGLE_CHOICE','Les worker nodes peuvent être EC2 ou Fargate.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','EC2, Fargate',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','EC2 seulement',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Fargate seulement',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Lambda',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-051') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='compute' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-051',v_cert_id,v_theme_id,'Qu''est-ce que AWS Batch ?','hard','SINGLE_CHOICE','Batch exécute des jobs de calcul par lots.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Service de traitement par lots',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Base de données',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Cache',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','CDN',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-052') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='compute' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-052',v_cert_id,v_theme_id,'Qu''est-ce que AWS Outposts ?','hard','SINGLE_CHOICE','Outposts permet d''exécuter des services AWS dans votre datacenter.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Matériel AWS déployé sur site',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Service cloud',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Zone de disponibilité',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Région',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-053') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='compute' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-053',v_cert_id,v_theme_id,'Qu''est-ce que AWS Wavelength ?','hard','SINGLE_CHOICE','Wavelength déploie des applications aux abords des réseaux 5G.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Infrastructure aux edge des réseaux 5G',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Service de calcul',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Base de données',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Stockage',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-054') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='compute' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-054',v_cert_id,v_theme_id,'Qu''est-ce que AWS Local Zones ?','hard','SINGLE_CHOICE','Local Zones placent l''infrastructure près des utilisateurs finaux.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Infrastructure AWS proche des grandes villes',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Région',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Zone de disponibilité',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Edge location',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-055') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='compute' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-055',v_cert_id,v_theme_id,'Quel service AWS est utilisé pour les applications serverless basées sur des événements ?','hard','SINGLE_CHOICE','Lambda exécute du code en réponse à des événements.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','EventBridge',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Lambda',TRUE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','SQS',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','SNS',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-056') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='compute' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-056',v_cert_id,v_theme_id,'Qu''est-ce qu''EventBridge ?','hard','SINGLE_CHOICE','EventBridge connecte des applications via des événements.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Bus d''événements serverless',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Base de données',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Cache',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','CDN',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-057') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='compute' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-057',v_cert_id,v_theme_id,'Qu''est-ce que Step Functions ?','hard','SINGLE_CHOICE','Step Functions orchestre plusieurs services AWS.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Orchestration de workflows',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Base de données',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Cache',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','CDN',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-058') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='compute' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-058',v_cert_id,v_theme_id,'Quels types de workflows Step Functions supporte-t-il ?','hard','SINGLE_CHOICE','Standard pour long running, Express pour haute fréquence.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Standard et Express',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Standard seulement',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Express seulement',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Premium',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-059') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='compute' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-059',v_cert_id,v_theme_id,'Qu''est-ce que AWS App Runner ?','hard','SINGLE_CHOICE','App Runner déploie des applications conteneurisées sans gestion d''infrastructure.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Service pour déployer des applications conteneurisées',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Base de données',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Cache',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','CDN',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-060') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='compute' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-060',v_cert_id,v_theme_id,'Qu''est-ce que AWS Copilot ?','hard','SINGLE_CHOICE','Copilot simplifie le déploiement d''applications conteneurisées.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','CLI pour déployer des applications sur ECS',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Service de calcul',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Base de données',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','CDN',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-061') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='compute' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-061',v_cert_id,v_theme_id,'Qu''est-ce que AWS Proton ?','hard','SINGLE_CHOICE','Proton automatise le déploiement d''infrastructure pour les microservices.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Service de gestion d''infrastructure as code',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Base de données',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Cache',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','CDN',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-062') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='compute' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-062',v_cert_id,v_theme_id,'Qu''est-ce que AWS Compute Optimizer ?','hard','SINGLE_CHOICE','Compute Optimizer analyse les métriques pour recommander des instances.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Recommande des types d''instance optimaux',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Service de calcul',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Base de données',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Cache',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-063') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='compute' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-063',v_cert_id,v_theme_id,'Qu''est-ce qu''une instance graviton ?','hard','SINGLE_CHOICE','Les instances Graviton utilisent des processeurs ARM personnalisés d''AWS.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Instance basée sur des processeurs ARM',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Instance x86',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Instance GPU',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Instance spot',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-064') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='compute' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-064',v_cert_id,v_theme_id,'Quel est l''avantage des instances Graviton ?','hard','SINGLE_CHOICE','Les instances Graviton offrent jusqu''à 40% de meilleur rapport performance/prix.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Meilleur rapport performance/prix',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Plus rapides',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Plus sécurisées',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A et B',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-065') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='compute' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-065',v_cert_id,v_theme_id,'Qu''est-ce que AWS Elastic Beanstalk ?','hard','SINGLE_CHOICE','Elastic Beanstalk est un PaaS qui gère l''infrastructure automatiquement.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','PaaS pour déployer des applications',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','IaaS',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','SaaS',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','FaaS',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-066') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='compute' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-066',v_cert_id,v_theme_id,'Elastic Beanstalk supporte-t-il plusieurs langages ?','hard','SINGLE_CHOICE','Beanstalk supporte de nombreux langages et environnements.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Oui (Java, .NET, Python, Node.js, etc.)',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Non, seulement Java',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Oui, mais avec conteneurs',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Non, seulement Node.js',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-067') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='compute' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-067',v_cert_id,v_theme_id,'Qu''est-ce qu''AWS Lightsail ?','hard','SINGLE_CHOICE','Lightsail offre des VPS simples à prix fixe.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Service simplifié pour petites applications',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Compute optimisé',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Base de données',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Stockage',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-068') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='compute' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-068',v_cert_id,v_theme_id,'Qu''est-ce qu''AWS ParallelCluster ?','hard','SINGLE_CHOICE','ParallelCluster simplifie le déploiement de clusters HPC.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Outil pour clusters HPC',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Service de calcul',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Base de données',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Cache',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-069') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='compute' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-069',v_cert_id,v_theme_id,'Qu''est-ce qu''AWS Compute Savings Plans ?','hard','SINGLE_CHOICE','Savings Plans offre des réductions en échange d''un engagement d''utilisation.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Engagement de réduction de coûts sur le calcul',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Instance spot',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Instance réservée',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Instance dédiée',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-070') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='compute' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-070',v_cert_id,v_theme_id,'Différence entre Savings Plans et Reserved Instances ?','hard','SINGLE_CHOICE','Savings Plans couvrent EC2, Fargate, Lambda avec plus de flexibilité.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Savings Plans sont plus flexibles (famille d''instances)',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Identiques',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Reserved Instances plus flexibles',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Savings Plans uniquement pour EC2',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-071') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='compute' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-071',v_cert_id,v_theme_id,'Qu''est-ce que le scaling prédictif ?','hard','SINGLE_CHOICE','Predictive scaling utilise ML pour anticiper les pics.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Utilise le machine learning pour prévoir la charge',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Scaling basé sur métriques',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Scaling manuel',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Scaling planifié',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-072') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='compute' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-072',v_cert_id,v_theme_id,'Qu''est-ce qu''un launch template vs launch configuration ?','hard','SINGLE_CHOICE','Launch template supporte les versions et plus de paramètres.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Launch template est plus récent et plus flexible',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Identiques',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Launch configuration plus récent',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Launch template moins cher',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-073') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='compute' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-073',v_cert_id,v_theme_id,'Qu''est-ce que le hibernation d''instance EC2 ?','hard','SINGLE_CHOICE','Hibernation sauvegarde la RAM sur EBS pour reprendre plus tard.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Met l''instance en pause, préserve la RAM',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Arrête l''instance',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Redémarre l''instance',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Termine l''instance',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-074') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='compute' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-074',v_cert_id,v_theme_id,'Quelles instances supportent l''hibernation ?','hard','SINGLE_CHOICE','L''hibernation est supportée pour les instances avec RAM <= 16 Go.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Instances avec RAM <= 16 Go',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Toutes les instances',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Aucune',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Uniquement les instances graviton',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-075') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='compute' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-075',v_cert_id,v_theme_id,'Qu''est-ce que le Nitro System ?','hard','SINGLE_CHOICE','Nitro System est la plateforme de virtualisation d''AWS.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Plateforme matérielle sous-jacente d''EC2',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Service de calcul',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Base de données',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','CDN',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-076') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='compute' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-076',v_cert_id,v_theme_id,'Quel est l''avantage du Nitro System ?','hard','SINGLE_CHOICE','Nitro offre des performances quasi-natives et une isolation renforcée.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Meilleures performances, plus de sécurité',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Moins cher',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Plus de mémoire',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Plus de CPU',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-077') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='compute' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-077',v_cert_id,v_theme_id,'Qu''est-ce qu''une instance bare metal ?','hard','SINGLE_CHOICE','Les instances bare metal (type *.metal) donnent accès au matériel physique.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Accès direct au matériel physique',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Instance virtualisée',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Instance conteneur',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Instance spot',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-078') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='compute' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-078',v_cert_id,v_theme_id,'Qu''est-ce que AWS Elastic Fabric Adapter (EFA) ?','hard','SINGLE_CHOICE','EFA améliore les performances réseau pour les applications HPC.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Réseau haute performance pour HPC',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Type d''instance',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Service de stockage',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Base de données',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-079') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='compute' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-079',v_cert_id,v_theme_id,'Qu''est-ce qu''AWS Elastic Graphics ?','hard','SINGLE_CHOICE','Elastic Graphics ajoute des GPU à des instances EC2.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Attache des GPU à des instances',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Type d''instance',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Service de stockage',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Base de données',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-080') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='compute' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-080',v_cert_id,v_theme_id,'Qu''est-ce qu''une instance convertible Reserved Instance ?','hard','SINGLE_CHOICE','Les instances réservées convertibles permettent de changer de type/famille.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Peut changer de type d''instance',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Non convertible',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Moins chère',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Plus chère',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-081') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='storage' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-081',v_cert_id,v_theme_id,'Que signifie S3 ?','easy','SINGLE_CHOICE','S3 est le stockage objet d''AWS.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Simple Storage Service',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Secure Storage Service',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Simple Storage System',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Standard Storage Service',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-082') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='storage' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-082',v_cert_id,v_theme_id,'Quelle est la taille maximale d''un objet S3 ?','easy','SINGLE_CHOICE','La taille maximale d''un objet S3 est 5 To.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','5 To',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','1 To',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','500 Go',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','10 To',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-083') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='storage' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-083',v_cert_id,v_theme_id,'Quelle est la taille maximale d''un PUT unique sur S3 ?','easy','SINGLE_CHOICE','Un PUT unique est limité à 5 Go. Au-delà, utiliser le multipart upload.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','5 Go',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','1 Go',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','500 Mo',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','10 Go',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-084') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='storage' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-084',v_cert_id,v_theme_id,'Quelle classe de stockage S3 est la moins chère ?','medium','SINGLE_CHOICE','Glacier Deep Archive est la classe la moins chère (récupération en 12-48h).','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','S3 Glacier Deep Archive',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','S3 Glacier Flexible Retrieval',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','S3 Standard-IA',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','S3 One Zone-IA',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-085') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='storage' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-085',v_cert_id,v_theme_id,'Quelle classe de stockage est pour les données consultées rarement ?','medium','SINGLE_CHOICE','Standard-IA (Infrequent Access) pour accès peu fréquents.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','S3 Standard-IA',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','S3 Standard',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','S3 Glacier',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','S3 Intelligent-Tiering',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-086') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='storage' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-086',v_cert_id,v_theme_id,'Quelle classe de stockage réplique les données sur une seule AZ ?','medium','SINGLE_CHOICE','One Zone-IA stocke uniquement dans une AZ (moins chère mais moins résiliente).','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','S3 One Zone-IA',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','S3 Standard',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','S3 Standard-IA',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','S3 Intelligent-Tiering',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-087') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='storage' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-087',v_cert_id,v_theme_id,'Quelle classe de stockage déplace automatiquement les données entre niveaux ?','hard','SINGLE_CHOICE','Intelligent-Tiering surveille les accès et déplace automatiquement les données.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','S3 Intelligent-Tiering',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','S3 Standard',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','S3 Glacier',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','S3 One Zone-IA',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-088') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='storage' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-088',v_cert_id,v_theme_id,'Combien de temps faut-il pour récupérer des données depuis Glacier Deep Archive ?','hard','SINGLE_CHOICE','Le délai de récupération standard pour Deep Archive est de 12 à 48 heures.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','12-48 heures',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','1-5 minutes',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','1-5 heures',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','1-2 jours',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-089') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='storage' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-089',v_cert_id,v_theme_id,'Qu''est-ce que S3 Transfer Acceleration ?','hard','SINGLE_CHOICE','Transfer Acceleration utilise CloudFront edge locations pour accélérer les uploads.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Accélère les transferts via edge locations',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Compresse les fichiers',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Chiffre les données',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Versionne les objets',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-090') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='storage' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-090',v_cert_id,v_theme_id,'Qu''est-ce que S3 Multipart Upload ?','hard','SINGLE_CHOICE','Multipart upload divise les gros fichiers en parties uploadées en parallèle.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Upload d''objets en plusieurs parties',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Upload en parallèle',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Upload de gros fichiers',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-091') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='storage' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-091',v_cert_id,v_theme_id,'Qu''est-ce que S3 Pre-signed URL ?','hard','SINGLE_CHOICE','Pre-signed URL donne un accès temporaire à un objet privé.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','URL temporaire pour accès privé',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','URL permanente',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','URL publique',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','URL chiffrée',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-092') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='storage' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-092',v_cert_id,v_theme_id,'Quelle est la durée de validité maximale d''une Pre-signed URL ?','hard','SINGLE_CHOICE','La durée maximale est de 7 jours (par défaut 1 heure).','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','7 jours',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','1 jour',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','12 heures',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','30 jours',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-093') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='storage' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-093',v_cert_id,v_theme_id,'Qu''est-ce que S3 Versioning ?','hard','SINGLE_CHOICE','Le versioning conserve toutes les versions d''un objet pour restauration.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Conserve plusieurs versions d''un objet',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Supprime les anciennes versions',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Archive les versions',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Chiffre les versions',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-094') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='storage' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-094',v_cert_id,v_theme_id,'Peut-on désactiver le versioning après l''avoir activé ?','hard','SINGLE_CHOICE','Une fois activé, on ne peut que suspendre, pas désactiver.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Non, seulement suspendre',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Oui',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Oui, avec délai',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Uniquement après suppression du bucket',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-095') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='storage' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-095',v_cert_id,v_theme_id,'Qu''est-ce que S3 MFA Delete ?','hard','SINGLE_CHOICE','MFA Delete exige une authentification MFA pour supprimer des versions.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Suppression nécessitant MFA',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Suppression automatique',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Suppression en masse',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Suppression définitive',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-096') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='storage' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-096',v_cert_id,v_theme_id,'Qu''est-ce que S3 Object Lock ?','hard','SINGLE_CHOICE','Object Lock protège contre les suppressions (WORM).','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Empêche la suppression/modification pendant une période',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Verrouille l''objet',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Chiffre l''objet',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Versionne l''objet',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-097') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='storage' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-097',v_cert_id,v_theme_id,'Quels sont les modes d''Object Lock ?','hard','SINGLE_CHOICE','Governance (peut être contourné par certains utilisateurs), Compliance (strict).','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Governance, Compliance',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Governance seulement',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Compliance seulement',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Retention seulement',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-098') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='storage' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-098',v_cert_id,v_theme_id,'Qu''est-ce qu''une S3 Lifecycle Policy ?','hard','SINGLE_CHOICE','Les lifecycle policies automatisent le cycle de vie des objets.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Déplace automatiquement les objets entre classes de stockage',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Supprime les objets',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Archive les objets',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-099') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='storage' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-099',v_cert_id,v_theme_id,'Quels sont les types d''actions dans une Lifecycle Policy ?','hard','SINGLE_CHOICE','Transition (changement de classe) et Expiration (suppression).','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Transition et Expiration',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Transition seulement',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Expiration seulement',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Replication',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-100') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='storage' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-100',v_cert_id,v_theme_id,'Qu''est-ce que S3 Replication ?','hard','SINGLE_CHOICE','La réplication copie automatiquement les objets vers un bucket de destination.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Réplique les objets vers un autre bucket',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Copie les objets',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Sauvegarde les objets',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Archive les objets',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-101') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='storage' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-101',v_cert_id,v_theme_id,'Quels sont les types de réplication S3 ?','hard','SINGLE_CHOICE','CRR vers une autre région, SRR dans la même région.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Cross-Region (CRR) et Same-Region (SRR)',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Cross-Region seulement',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Same-Region seulement',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Multi-Region',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-102') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='storage' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-102',v_cert_id,v_theme_id,'Qu''est-ce que S3 Event Notifications ?','hard','SINGLE_CHOICE','S3 peut envoyer des notifications vers SNS, SQS, Lambda.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Notifications sur événements (création, suppression)',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Logs',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Monitoring',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Alertes',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-103') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='storage' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-103',v_cert_id,v_theme_id,'Quelles sont les destinations possibles pour S3 Event Notifications ?','hard','SINGLE_CHOICE','Les destinations supportées sont SNS, SQS, Lambda (et EventBridge).','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','SNS, SQS, Lambda',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','S3 seulement',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','CloudWatch',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','EventBridge',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-104') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='storage' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-104',v_cert_id,v_theme_id,'Qu''est-ce que S3 Access Points ?','hard','SINGLE_CHOICE','Les Access Points simplifient la gestion des permissions par application.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Points d''accès avec politiques spécifiques',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Endpoints VPC',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','URLs personnalisées',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Load balancers',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-105') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='storage' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-105',v_cert_id,v_theme_id,'Qu''est-ce que S3 Object Lambda ?','hard','SINGLE_CHOICE','Object Lambda modifie les données retournées par S3 GET.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Transforme les données à la volée',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Lambda sur S3',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Traitement batch',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Streaming',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-106') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='storage' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-106',v_cert_id,v_theme_id,'Qu''est-ce que S3 Storage Lens ?','hard','SINGLE_CHOICE','Storage Lens fournit des métriques agrégées sur l''utilisation S3.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Analyse d''utilisation et métriques',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Lentille de stockage',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Outil de monitoring',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Dashboard',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-107') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='storage' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-107',v_cert_id,v_theme_id,'Qu''est-ce que S3 Batch Operations ?','hard','SINGLE_CHOICE','Batch Operations exécute des actions sur de grands ensembles d''objets.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Opérations en masse sur des objets',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Traitement batch',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Copy, tag, restore',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-108') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='storage' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-108',v_cert_id,v_theme_id,'Qu''est-ce que S3 Select ?','hard','SINGLE_CHOICE','S3 Select permet d''extraire des sous-ensembles de données (CSV, JSON).','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Interroge des données dans S3 sans les télécharger',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Sélectionne des objets',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Filtre des objets',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Jointure',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-109') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='storage' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-109',v_cert_id,v_theme_id,'Qu''est-ce que S3 Glacier Select ?','hard','SINGLE_CHOICE','Glacier Select permet d''interroger des données sans restaurer l''objet entier.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Interroge des données dans Glacier',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Sélectionne des archives',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Restauration partielle',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A et C',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-110') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='storage' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-110',v_cert_id,v_theme_id,'Que signifie EBS ?','easy','SINGLE_CHOICE','EBS est le stockage bloc pour EC2.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Elastic Block Store',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Elastic Bulk Storage',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Elastic Backup Storage',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Elastic Byte Storage',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-111') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='storage' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-111',v_cert_id,v_theme_id,'Quel type de volume EBS est SSD généraliste ?','easy','SINGLE_CHOICE','gp2/gp3 sont les volumes SSD à usage général.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','gp2/gp3',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','io1/io2',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','st1',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','sc1',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-112') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='storage' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-112',v_cert_id,v_theme_id,'Quel type de volume EBS est optimisé IOPS ?','medium','SINGLE_CHOICE','io1/io2 sont les volumes SSD provisioned IOPS.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','io1/io2',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','gp2/gp3',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','st1',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','sc1',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-113') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='storage' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-113',v_cert_id,v_theme_id,'Quel type de volume EBS est optimisé pour le débit (HDD) ?','medium','SINGLE_CHOICE','st1 est optimisé pour le débit (Throughput Optimized HDD).','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','st1',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','sc1',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','gp2',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','io1',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-114') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='storage' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-114',v_cert_id,v_theme_id,'Quel type de volume EBS est pour les charges froides (HDD) ?','hard','SINGLE_CHOICE','sc1 est le Cold HDD, le moins cher.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','sc1',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','st1',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','gp2',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','io1',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-115') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='storage' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-115',v_cert_id,v_theme_id,'Quelle est la différence entre gp2 et gp3 ?','hard','SINGLE_CHOICE','gp3 offre 3000 IOPS de base sans provisionnement (gp2 dépend de la taille).','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','gp3 a des IOPS de base sans provisionnement',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','gp2 est plus récent',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','gp3 plus cher',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Identiques',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-116') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='storage' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-116',v_cert_id,v_theme_id,'Qu''est-ce qu''un snapshot EBS ?','hard','SINGLE_CHOICE','Les snapshots EBS sont incrémentaux (seuls les blocs modifiés sont sauvegardés).','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Sauvegarde incrémentale',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Copie complète',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Archive',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Clone',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-117') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='storage' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-117',v_cert_id,v_theme_id,'Peut-on créer une instance EC2 à partir d''un snapshot EBS ?','hard','SINGLE_CHOICE','Il faut d''abord créer une AMI à partir du snapshot.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Oui, via AMI',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Oui, directement',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Uniquement avec EBS direct',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-118') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='storage' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-118',v_cert_id,v_theme_id,'Qu''est-ce que EBS Encryption ?','hard','SINGLE_CHOICE','Le chiffrement EBS couvre les volumes et snapshots au repos.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Chiffrement au repos',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Chiffrement en transit',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Chiffrement des snapshots',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A et C',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-119') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='storage' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-119',v_cert_id,v_theme_id,'Qu''est-ce que EBS Multi-Attach ?','hard','SINGLE_CHOICE','Multi-Attach permet d''attacher un même volume à plusieurs instances (io1/io2).','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Attachement à plusieurs instances',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Attachement unique',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Réplication',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Snapshot',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-120') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='storage' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-120',v_cert_id,v_theme_id,'Quels types de volumes supportent Multi-Attach ?','hard','SINGLE_CHOICE','Seuls les volumes provisioned IOPS (io1/io2) supportent Multi-Attach.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','io1/io2',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','gp2/gp3',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','st1',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','sc1',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-121') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='storage' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-121',v_cert_id,v_theme_id,'Qu''est-ce qu''EFS ?','easy','SINGLE_CHOICE','EFS est un système de fichiers NFS partagé.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Elastic File System (NFS)',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Elastic Block Store',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Elastic Container Service',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Elastic Compute Service',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-122') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='storage' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-122',v_cert_id,v_theme_id,'Combien d''instances EC2 peuvent monter un EFS ?','hard','SINGLE_CHOICE','EFS peut être monté par un grand nombre d''instances.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Illimité',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','1',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','10',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','100',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-123') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='storage' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-123',v_cert_id,v_theme_id,'Quels sont les classes de stockage EFS ?','hard','SINGLE_CHOICE','EFS Standard, EFS-IA (Infrequent Access), EFS Archive.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Standard, Infrequent Access, Archive',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Standard seulement',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Infrequent Access seulement',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Archive seulement',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-124') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='storage' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-124',v_cert_id,v_theme_id,'EFS peut-il être monté sur-premise ?','hard','SINGLE_CHOICE','EFS est accessible via VPC, donc via Direct Connect ou VPN.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Oui, via Direct Connect ou VPN',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Oui, via Internet',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Oui, via VPC peering',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-125') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='storage' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-125',v_cert_id,v_theme_id,'EFS supporte-t-il les modes de montage NFSv4 ?','hard','SINGLE_CHOICE','EFS supporte NFSv4.0 et NFSv4.1.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Oui',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','NFSv3 seulement',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','SMB seulement',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-126') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='storage' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-126',v_cert_id,v_theme_id,'Qu''est-ce qu''Amazon FSx ?','hard','SINGLE_CHOICE','FSx propose des systèmes de fichiers managés (Windows, Lustre, NetApp, OpenZFS).','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Systèmes de fichiers managés',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Base de données',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Cache',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','CDN',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-127') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='storage' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-127',v_cert_id,v_theme_id,'Quels types de FSx existent ?','hard','SINGLE_CHOICE','Quatre types : Windows File Server, Lustre, NetApp ONTAP, OpenZFS.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','FSx for Windows, FSx for Lustre, FSx for NetApp, FSx for OpenZFS',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','FSx for Windows seulement',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','FSx for Lustre seulement',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','FSx for NetApp seulement',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-128') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='storage' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-128',v_cert_id,v_theme_id,'Qu''est-ce qu''AWS Storage Gateway ?','hard','SINGLE_CHOICE','Storage Gateway intègre le stockage on-premise avec AWS.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Passerelle entre on-premise et AWS',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Service de stockage',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Base de données',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Cache',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-129') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='storage' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-129',v_cert_id,v_theme_id,'Quels sont les types de Storage Gateway ?','hard','SINGLE_CHOICE','Quatre types pour différents cas d''usage.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','S3 File Gateway, FSx File Gateway, Volume Gateway, Tape Gateway',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','S3 Gateway seulement',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Volume Gateway seulement',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Tape Gateway seulement',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-130') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='storage' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-130',v_cert_id,v_theme_id,'À quoi sert Tape Gateway ?','hard','SINGLE_CHOICE','Tape Gateway virtualise des bandes vers S3/Glacier.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Remplace les bibliothèques de bandes virtuelles',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Backup disque',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Archive',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Cache',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-131') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='storage' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-131',v_cert_id,v_theme_id,'Qu''est-ce qu''AWS Backup ?','hard','SINGLE_CHOICE','AWS Backup centralise les sauvegardes de plusieurs services AWS.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Service centralisé de sauvegarde',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Snapshot EBS',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Backup S3',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Archive',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-132') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='storage' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-132',v_cert_id,v_theme_id,'Quels services peuvent être sauvegardés par AWS Backup ?','hard','SINGLE_CHOICE','AWS Backup supporte de nombreux services.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','EC2, EBS, RDS, DynamoDB, EFS, FSx, S3',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','EC2 seulement',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','RDS seulement',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','S3 seulement',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-133') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='storage' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-133',v_cert_id,v_theme_id,'À quoi sert AWS Snow Family ?','hard','SINGLE_CHOICE','Snow Family (Snowcone, Snowball, Snowmobile) transfère des données physiquement.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Transfert de données physiques',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Backup',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Archive',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Cache',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-134') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='storage' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-134',v_cert_id,v_theme_id,'Quel est le plus petit appareil Snow Family ?','hard','SINGLE_CHOICE','Snowcone est le plus petit (2,1 kg, 8 To).','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Snowcone',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Snowball Edge',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Snowmobile',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Snowball',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-135') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='storage' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-135',v_cert_id,v_theme_id,'Quel appareil Snow Family est utilisé pour l''Exabyte ?','hard','SINGLE_CHOICE','Snowmobile est un conteneur de 45 pieds pour des pétaoctets/exaoctets.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Snowmobile',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Snowball',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Snowcone',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Snowball Edge',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-136') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='storage' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-136',v_cert_id,v_theme_id,'Quand utiliser S3 plutôt que EBS ?','hard','SINGLE_CHOICE','S3 pour stockage objet scalable, EBS pour volumes attachés à EC2.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Stockage objet illimité',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Base de données',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Système de fichiers partagé',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Volume boot',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-137') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='storage' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-137',v_cert_id,v_theme_id,'Quand utiliser EFS plutôt que EBS ?','hard','SINGLE_CHOICE','EFS pour partage NFS entre plusieurs instances.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Partage de fichiers entre instances',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Volume boot',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Haute performance',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Faible coût',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-138') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='storage' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-138',v_cert_id,v_theme_id,'EBS peut-il être partagé entre plusieurs instances ?','hard','SINGLE_CHOICE','Seuls les volumes io1/io2 supportent Multi-Attach (limité à 16 instances).','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Oui, avec Multi-Attach (io1/io2)',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Oui, avec gp2',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Oui, avec st1',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-139') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='storage' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-139',v_cert_id,v_theme_id,'Qu''est-ce qu''AWS DataSync ?','hard','SINGLE_CHOICE','DataSync transfère des données entre on-premise et AWS ou entre services AWS.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Service de transfert de données automatisé',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Backup',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Archive',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Cache',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-140') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='storage' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-140',v_cert_id,v_theme_id,'DataSync supporte-t-il la vérification d''intégrité ?','hard','SINGLE_CHOICE','DataSync vérifie l''intégrité des données pendant le transfert.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Oui',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Optionnel',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Uniquement avec chiffrement',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-141') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='storage' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-141',v_cert_id,v_theme_id,'Comment optimiser les coûts S3 ?','hard','SINGLE_CHOICE','Les lifecycle policies et le choix de classe de stockage réduisent les coûts.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Lifecycle policies, classes de stockage',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Plus de versions',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Plus de réplication',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Chiffrement',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-142') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='storage' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-142',v_cert_id,v_theme_id,'Comment améliorer les performances S3 ?','hard','SINGLE_CHOICE','Des clés aléatoires améliorent la distribution, Transfer Acceleration accélère les uploads.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Utiliser des clés d''objet aléatoires',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Utiliser des préfixes',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Transfer Acceleration',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A et C',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-143') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='storage' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-143',v_cert_id,v_theme_id,'Quel est le débit maximum par préfixe S3 ?','hard','SINGLE_CHOICE','Par préfixe, 3 500 requêtes PUT/POST/DELETE et 5 500 GET/HEAD par seconde.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','3 500 PUT/ 5 500 GET par seconde',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','100 par seconde',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','10 000 par seconde',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Illimité',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-144') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='storage' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-144',v_cert_id,v_theme_id,'Comment sécuriser un bucket S3 ?','hard','SINGLE_CHOICE','Plusieurs couches de sécurité pour S3.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Bucket policies, ACLs, IAM, chiffrement',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Bucket policies seulement',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','IAM seulement',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','ACLs seulement',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-145') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='storage' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-145',v_cert_id,v_theme_id,'Qu''est-ce que S3 Block Public Access ?','hard','SINGLE_CHOICE','Block Public Access désactive les politiques et ACLs publiques.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Empêche les accès publics au niveau bucket/account',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Bloque les accès privés',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Supprime les politiques publiques',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A et C',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-146') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='storage' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-146',v_cert_id,v_theme_id,'Quels sont les types de chiffrement S3 ?','hard','SINGLE_CHOICE','SSE-S3 (clés AWS), SSE-KMS (clés KMS), SSE-C (clés client).','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','SSE-S3, SSE-KMS, SSE-C',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','SSE-S3 seulement',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','SSE-KMS seulement',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','SSE-C seulement',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-147') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='storage' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-147',v_cert_id,v_theme_id,'Qu''est-ce que le chiffrement côté client ?','hard','SINGLE_CHOICE','Client-side encryption : le client chiffre avant d''envoyer à S3.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Chiffrement avant upload',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Chiffrement par AWS',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Chiffrement par KMS',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Chiffrement par S3',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-148') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='storage' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-148',v_cert_id,v_theme_id,'Qu''est-ce que S3 Access Analyzer ?','hard','SINGLE_CHOICE','Access Analyzer détecte les politiques qui permettent des accès publics ou croisés.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Analyse les politiques pour accès non intentionnels',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Analyse les performances',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Analyse les coûts',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Analyse les logs',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-149') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='storage' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-149',v_cert_id,v_theme_id,'Quel service pour migrer des données on-premise vers AWS ?','hard','SINGLE_CHOICE','Plusieurs options selon le volume et la bande passante.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Snow Family, DataSync, Storage Gateway',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','EC2 seulement',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','S3 seulement',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','RDS seulement',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-150') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='storage' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-150',v_cert_id,v_theme_id,'Quand utiliser Snowball plutôt que DataSync ?','hard','SINGLE_CHOICE','Snowball pour transferts physiques de grandes quantités (TB/PB).','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Volume très grand, bande passante limitée',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Petit volume',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Transfert continu',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Transfert en ligne',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-151') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='database' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-151',v_cert_id,v_theme_id,'Que signifie RDS ?','easy','SINGLE_CHOICE','RDS est un service de base de données relationnelle managée.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Relational Database Service',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Remote Database Service',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Relational Data Storage',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Redundant Database Service',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-152') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='database' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-152',v_cert_id,v_theme_id,'Quels moteurs de base de données sont supportés par RDS ?','easy','SINGLE_CHOICE','RDS supporte les bases SQL traditionnelles et Db2.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','MySQL, PostgreSQL, Oracle, SQL Server, MariaDB, IBM Db2',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','MongoDB, Cassandra',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','DynamoDB, Redshift',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Neptune, Elasticache',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-153') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='database' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-153',v_cert_id,v_theme_id,'Qu''est-ce que RDS Multi-AZ ?','medium','SINGLE_CHOICE','Multi-AZ réplique synchrone vers une instance standby dans une autre AZ.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Réplication synchrone pour haute disponibilité',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Réplication asynchrone',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Scale-out de lecture',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Backup automatique',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-154') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='database' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-154',v_cert_id,v_theme_id,'Qu''est-ce que RDS Read Replica ?','medium','SINGLE_CHOICE','Les Read Replicas sont asynchrones et permettent de décharger les lectures.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Réplication asynchrone pour lecture seule',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Réplication synchrone',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Haute disponibilité',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Backup',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-155') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='database' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-155',v_cert_id,v_theme_id,'Combien de Read Replicas peut-on avoir par instance RDS ?','hard','SINGLE_CHOICE','Maximum 5 Read Replicas par instance (pour MySQL, PostgreSQL).','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Jusqu''à 5',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Jusqu''à 10',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Jusqu''à 15',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Illimité',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-156') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='database' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-156',v_cert_id,v_theme_id,'Peut-on promouvoir un Read Replica en instance principale ?','hard','SINGLE_CHOICE','On peut promouvoir manuellement un Read Replica en instance autonome.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Oui',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Uniquement avec Multi-AZ',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Uniquement avec Aurora',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-157') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='database' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-157',v_cert_id,v_theme_id,'Qu''est-ce que RDS Proxy ?','hard','SINGLE_CHOICE','RDS Proxy gère les connexions, améliore la scalabilité et la sécurité.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Pool de connexions pour RDS',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Load balancer',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Cache',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Backup',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-158') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='database' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-158',v_cert_id,v_theme_id,'Quels sont les avantages de RDS Proxy ?','hard','SINGLE_CHOICE','RDS Proxy mutualise les connexions et supporte l''authentification IAM.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Pool de connexions, réduction de latence, IAM authentication',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Haute disponibilité',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Backup',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Chiffrement',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-159') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='database' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-159',v_cert_id,v_theme_id,'Qu''est-ce qu''un snapshot RDS ?','hard','SINGLE_CHOICE','Les snapshots sont des sauvegardes manuelles complètes.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Sauvegarde manuelle complète',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Sauvegarde automatique',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Sauvegarde incrémentale',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Réplica',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-160') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='database' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-160',v_cert_id,v_theme_id,'Combien de temps sont conservées les sauvegardes automatiques RDS ?','hard','SINGLE_CHOICE','La période de rétention des sauvegardes automatiques est de 0 à 35 jours.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','0-35 jours',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','1-7 jours',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','7-30 jours',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','30-90 jours',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-161') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='database' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-161',v_cert_id,v_theme_id,'Qu''est-ce qu''Amazon Aurora ?','medium','SINGLE_CHOICE','Aurora est un moteur de base de données compatible MySQL/PostgreSQL.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Base de données relationnelle compatible MySQL/PostgreSQL',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Base NoSQL',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Data warehouse',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Cache',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-162') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='database' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-162',v_cert_id,v_theme_id,'Combien de réplicas Aurora peut-on avoir ?','hard','SINGLE_CHOICE','Aurora supporte jusqu''à 15 réplicas de lecture.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Jusqu''à 15',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Jusqu''à 5',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Jusqu''à 10',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Jusqu''à 20',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-163') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='database' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-163',v_cert_id,v_theme_id,'Qu''est-ce que Aurora Serverless ?','hard','SINGLE_CHOICE','Aurora Serverless s''adapte automatiquement à la charge.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Base de données serverless auto-scalable',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Aurora classique',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Aurora Multi-AZ',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Aurora Global',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-164') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='database' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-164',v_cert_id,v_theme_id,'Qu''est-ce qu''Aurora Global Database ?','hard','SINGLE_CHOICE','Aurora Global Database réplique dans plusieurs régions avec faible latence.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Réplication cross-region avec latence <1s',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Multi-AZ',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Read replicas',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Snapshot',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-165') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='database' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-165',v_cert_id,v_theme_id,'Combien de régions peut couvrir Aurora Global Database ?','hard','SINGLE_CHOICE','Jusqu''à 5 régions secondaires.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Jusqu''à 5',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Jusqu''à 3',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Jusqu''à 10',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Jusqu''à 1',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-166') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='database' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-166',v_cert_id,v_theme_id,'Qu''est-ce qu''Aurora Machine Learning ?','hard','SINGLE_CHOICE','Aurora ML permet d''appeler des modèles ML directement depuis SQL.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Intégration avec SageMaker et Comprehend',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Base de données ML',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Cache ML',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Entraînement ML',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-167') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='database' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-167',v_cert_id,v_theme_id,'Qu''est-ce que DynamoDB ?','easy','SINGLE_CHOICE','DynamoDB est une base NoSQL clé-valeur/documents.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Base de données NoSQL clé-valeur',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Base relationnelle',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Data warehouse',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Cache',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-168') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='database' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-168',v_cert_id,v_theme_id,'Quels sont les modes de capacité DynamoDB ?','medium','SINGLE_CHOICE','Provisioned (RCU/WCU) ou On-Demand (pay-per-request).','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Provisioned et On-Demand',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Standard et Premium',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Basic et Advanced',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Single et Multi-AZ',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-169') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='database' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-169',v_cert_id,v_theme_id,'Qu''est-ce que DynamoDB Accelerator (DAX) ?','hard','SINGLE_CHOICE','DAX est un cache Redis compatible DynamoDB pour des lectures microsecondes.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Cache in-memory pour DynamoDB',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Backup',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Réplication',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Migration',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-170') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='database' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-170',v_cert_id,v_theme_id,'Qu''est-ce que DynamoDB Streams ?','hard','SINGLE_CHOICE','Streams capture les modifications (création, mise à jour, suppression).','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Flux de changements en temps réel',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Backup',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Réplication',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Migration',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-171') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='database' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-171',v_cert_id,v_theme_id,'Combien de temps les données sont conservées dans DynamoDB Streams ?','hard','SINGLE_CHOICE','La rétention par défaut est 24 heures (configurable jusqu''à 7 jours).','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','24 heures',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','7 jours',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','30 jours',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','48 heures',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-172') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='database' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-172',v_cert_id,v_theme_id,'Qu''est-ce qu''une DynamoDB Global Table ?','hard','SINGLE_CHOICE','Les Global Tables répliquent les données dans plusieurs régions, lecture/écriture partout.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Table multi-région multi-actif',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Table répliquée',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Table partitionnée',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Table indexée',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-173') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='database' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-173',v_cert_id,v_theme_id,'Quelle est la taille maximale d''un élément DynamoDB ?','hard','SINGLE_CHOICE','La taille maximale d''un élément est 400 KB.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','400 KB',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','1 MB',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','64 KB',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','256 KB',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-174') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='database' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-174',v_cert_id,v_theme_id,'Qu''est-ce qu''un index secondaire global (GSI) ?','hard','SINGLE_CHOICE','GSI permet d''interroger avec une clé de partition alternative.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Index avec clé de partition différente',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Index avec même partition',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Index local',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Index unique',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-175') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='database' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-175',v_cert_id,v_theme_id,'Qu''est-ce qu''un index secondaire local (LSI) ?','hard','SINGLE_CHOICE','LSI partage la même clé de partition, clé de tri différente.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Index avec même partition, clé de tri différente',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Index avec partition différente',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Index global',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Index unique',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-176') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='database' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-176',v_cert_id,v_theme_id,'Combien de LSI peut-on créer par table ?','hard','SINGLE_CHOICE','Maximum 5 LSI par table.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','5',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','10',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','20',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Illimité',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-177') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='database' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-177',v_cert_id,v_theme_id,'Combien de GSI peut-on créer par table ?','hard','SINGLE_CHOICE','Maximum 20 GSI par table (par défaut).','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','20',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','5',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','10',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','50',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-178') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='database' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-178',v_cert_id,v_theme_id,'Qu''est-ce que DynamoDB Transactions ?','hard','SINGLE_CHOICE','Les transactions offrent des garanties ACID sur plusieurs éléments.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','ACID sur plusieurs opérations',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Lecture seule',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Écriture seule',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Batch',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-179') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='database' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-179',v_cert_id,v_theme_id,'Qu''est-ce que DynamoDB Time To Live (TTL) ?','hard','SINGLE_CHOICE','TTL marque les éléments pour suppression automatique à une date.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Suppression automatique après délai',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Expiration de cache',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Timeout de lecture',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Limite de temps',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-180') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='database' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-180',v_cert_id,v_theme_id,'Qu''est-ce que DynamoDB Backup ?','hard','SINGLE_CHOICE','Les backups manuels (on-demand) sont complets et conservés indéfiniment.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Sauvegarde complète ponctuelle',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Sauvegarde continue',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Snapshot',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Point-in-time recovery',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-181') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='database' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-181',v_cert_id,v_theme_id,'Qu''est-ce que Point-in-Time Recovery (PITR) pour DynamoDB ?','hard','SINGLE_CHOICE','PITR permet de restaurer à n''importe quelle seconde dans les 35 jours.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Restauration à n''importe quel moment dans les 35 jours',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Backup quotidien',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Snapshot',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Réplication',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-182') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='database' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-182',v_cert_id,v_theme_id,'Qu''est-ce qu''Amazon Redshift ?','hard','SINGLE_CHOICE','Redshift est un data warehouse columnar pour l''analytique.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Data warehouse',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Base de données relationnelle',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Base NoSQL',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Cache',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-183') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='database' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-183',v_cert_id,v_theme_id,'Qu''est-ce que Redshift Spectrum ?','hard','SINGLE_CHOICE','Spectrum permet d''interroger des données S3 sans les charger dans Redshift.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Interroge directement des données dans S3',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Cache',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Backup',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Réplication',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-184') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='database' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-184',v_cert_id,v_theme_id,'Qu''est-ce que Redshift RA3 ?','hard','SINGLE_CHOICE','RA3 sépare le calcul du stockage pour une meilleure scalabilité.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Nœuds avec stockage géré (compute/storage séparés)',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Nœuds classiques',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Nœuds serveurless',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Nœuds GPU',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-185') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='database' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-185',v_cert_id,v_theme_id,'Qu''est-ce que Redshift Serverless ?','hard','SINGLE_CHOICE','Serverless ajuste automatiquement les ressources.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Data warehouse serverless auto-scalable',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Redshift classique',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Redshift Spectrum',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Redshift RA3',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-186') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='database' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-186',v_cert_id,v_theme_id,'Qu''est-ce qu''ElastiCache ?','easy','SINGLE_CHOICE','ElastiCache est un service de cache in-memory managé.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Cache managé (Redis/Memcached)',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Base de données',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Stockage',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','CDN',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-187') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='database' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-187',v_cert_id,v_theme_id,'Quels moteurs sont supportés par ElastiCache ?','hard','SINGLE_CHOICE','ElastiCache supporte Redis et Memcached.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Redis et Memcached',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Redis seulement',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Memcached seulement',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Redis et MongoDB',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-188') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='database' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-188',v_cert_id,v_theme_id,'Qu''est-ce que Redis Cluster ?','hard','SINGLE_CHOICE','Redis Cluster permet de partitionner les données sur plusieurs nœuds.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Sharding horizontal pour Redis',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Réplication',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Persistance',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Backup',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-189') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='database' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-189',v_cert_id,v_theme_id,'Qu''est-ce que Redis Replication Group ?','hard','SINGLE_CHOICE','Replication Group offre haute disponibilité avec un maître et des réplicas.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Réplication maître-esclave avec failover',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Cluster',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Sharding',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Backup',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-190') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='database' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-190',v_cert_id,v_theme_id,'Qu''est-ce que Redis Multi-AZ ?','hard','SINGLE_CHOICE','Multi-AZ garantit la disponibilité en cas de panne d''AZ.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Réplication cross-AZ avec failover automatique',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Cluster',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Sharding',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Backup',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-191') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='database' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-191',v_cert_id,v_theme_id,'Qu''est-ce qu''Amazon Neptune ?','hard','SINGLE_CHOICE','Neptune est une base de données graphe (RDF/Property Graph).','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Base de données graphe',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Base relationnelle',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Data warehouse',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Cache',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-192') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='database' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-192',v_cert_id,v_theme_id,'Quels langages de requête supporte Neptune ?','hard','SINGLE_CHOICE','Neptune supporte Gremlin (Apache TinkerPop), SPARQL, openCypher.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Gremlin, SPARQL, openCypher',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','SQL',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','GraphQL',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Cypher seulement',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-193') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='database' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-193',v_cert_id,v_theme_id,'Qu''est-ce qu''Amazon DocumentDB ?','hard','SINGLE_CHOICE','DocumentDB est compatible avec MongoDB (MongoDB 3.6, 4.0, 5.0).','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Base de données MongoDB compatible',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Base relationnelle',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Data warehouse',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Cache',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-194') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='database' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-194',v_cert_id,v_theme_id,'DocumentDB est-il un remplacement direct de MongoDB ?','hard','SINGLE_CHOICE','DocumentDB imite l''API MongoDB, mais n''est pas un fork.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Oui, compatible',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Non, différent',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Partiellement',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','API différentes',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-195') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='database' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-195',v_cert_id,v_theme_id,'Qu''est-ce qu''Amazon QLDB ?','hard','SINGLE_CHOICE','QLDB est un registre cryptographiquement vérifiable.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Registre immutable (blockchain-like)',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Base relationnelle',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Data warehouse',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Cache',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-196') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='database' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-196',v_cert_id,v_theme_id,'QLDB est-il centralisé ou décentralisé ?','hard','SINGLE_CHOICE','QLDB est centralisé (géré par AWS), contrairement aux blockchains.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Centralisé',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Décentralisé',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Les deux',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Blockchain public',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-197') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='database' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-197',v_cert_id,v_theme_id,'Qu''est-ce qu''Amazon Timestream ?','hard','SINGLE_CHOICE','Timestream est optimisé pour les séries temporelles (IoT, logs, métriques).','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Base de données time-series',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Base relationnelle',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Data warehouse',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Cache',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-198') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='database' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-198',v_cert_id,v_theme_id,'Qu''est-ce qu''Amazon Keyspaces ?','hard','SINGLE_CHOICE','Keyspaces est un service Cassandra managé.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Base de données Cassandra compatible',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Base relationnelle',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Data warehouse',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Cache',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-199') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='database' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-199',v_cert_id,v_theme_id,'Qu''est-ce qu''AWS Database Migration Service (DMS) ?','hard','SINGLE_CHOICE','DMS migre des bases de données vers AWS avec minimum de downtime.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Migration de bases de données',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Backup',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Réplication',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Monitoring',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-200') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='database' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-200',v_cert_id,v_theme_id,'DMS supporte-t-il la migration homogène et hétérogène ?','hard','SINGLE_CHOICE','DMS peut migrer entre moteurs différents (ex: Oracle vers PostgreSQL).','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Oui',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Homogène seulement',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Hétérogène seulement',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-201') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='database' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-201',v_cert_id,v_theme_id,'Qu''est-ce que AWS Schema Conversion Tool (SCT) ?','hard','SINGLE_CHOICE','SCT convertit les schémas, procédures stockées, etc.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Convertit les schémas entre moteurs',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Migre les données',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Réplique les données',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Backup',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-202') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='database' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-202',v_cert_id,v_theme_id,'Quand utiliser RDS vs DynamoDB ?','hard','SINGLE_CHOICE','RDS pour données relationnelles, DynamoDB pour NoSQL avec scaling automatique.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','RDS pour SQL, relations; DynamoDB pour NoSQL, haute scalabilité',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Toujours RDS',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Toujours DynamoDB',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','RDS pour NoSQL',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-203') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='database' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-203',v_cert_id,v_theme_id,'Comment améliorer les performances de lecture RDS ?','hard','SINGLE_CHOICE','Les Read Replicas déchargent les lectures, ElastiCache réduit la charge.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Read Replicas, cache (ElastiCache)',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Multi-AZ',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Snapshots',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Backup',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-204') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='database' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-204',v_cert_id,v_theme_id,'Comment améliorer la haute disponibilité RDS ?','hard','SINGLE_CHOICE','Multi-AZ réplique synchrone pour failover automatique.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Multi-AZ',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Read Replicas',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Snapshots',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Backup',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-205') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='database' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-205',v_cert_id,v_theme_id,'Comment chiffrer RDS ?','hard','SINGLE_CHOICE','RDS supporte le chiffrement au repos et en transit.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Chiffrement au repos via KMS',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Chiffrement en transit via TLS',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Chiffrement des snapshots',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-206') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='database' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-206',v_cert_id,v_theme_id,'Peut-on chiffrer un RDS existant ?','hard','SINGLE_CHOICE','Pour chiffrer une base non chiffrée, il faut créer un snapshot chiffré et restaurer.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Non, créer un snapshot chiffré puis restaurer',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Oui, directement',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Oui, avec modification',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Uniquement au lancement',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-207') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='database' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-207',v_cert_id,v_theme_id,'Qu''est-ce que RDS IAM Authentication ?','hard','SINGLE_CHOICE','IAM Authentication permet d''utiliser les rôles IAM pour accéder à RDS.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Authentification des utilisateurs via IAM',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Authentification des instances',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Authentification des services',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Authentification des applications',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-208') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='database' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-208',v_cert_id,v_theme_id,'Comment surveiller les performances RDS ?','hard','SINGLE_CHOICE','Plusieurs outils pour monitorer RDS.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','CloudWatch, Performance Insights, Enhanced Monitoring',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','CloudTrail',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','S3',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Lambda',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-209') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='database' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-209',v_cert_id,v_theme_id,'Qu''est-ce que Performance Insights pour RDS ?','hard','SINGLE_CHOICE','Performance Insights visualise la charge de la base.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Analyse des charges et des requêtes',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Métriques de base',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Logs',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Alertes',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-210') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='database' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-210',v_cert_id,v_theme_id,'Comment sauvegarder RDS ?','hard','SINGLE_CHOICE','RDS offre des sauvegardes automatiques (0-35 jours) et des snapshots manuels.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Sauvegardes automatiques, snapshots manuels',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Snapshots seulement',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Backup S3',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','DMS',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-211') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='networking' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-211',v_cert_id,v_theme_id,'Que signifie VPC ?','easy','SINGLE_CHOICE','VPC est un réseau virtuel isolé dans AWS.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Virtual Private Cloud',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Virtual Public Cloud',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Virtual Private Cluster',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Virtual Private Compute',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-212') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='networking' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-212',v_cert_id,v_theme_id,'Quelle est la plage CIDR maximale pour un VPC ?','easy','SINGLE_CHOICE','La plage CIDR maximale pour un VPC est /16 (65 536 adresses).','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','/16',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','/24',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','/28',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','/8',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-213') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='networking' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-213',v_cert_id,v_theme_id,'Quelle est la plage CIDR minimale pour un VPC ?','easy','SINGLE_CHOICE','La plage minimale est /28 (16 adresses).','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','/28',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','/16',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','/24',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','/8',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-214') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='networking' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-214',v_cert_id,v_theme_id,'Qu''est-ce qu''un subnet ?','easy','SINGLE_CHOICE','Un subnet est une plage d''adresses IP dans un VPC.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Sous-réseau dans un VPC',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Type d''instance',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Service de stockage',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Base de données',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-215') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='networking' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-215',v_cert_id,v_theme_id,'Quelle est la différence entre public et private subnet ?','medium','SINGLE_CHOICE','Les subnets publics ont une route vers Internet Gateway.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Public subnet a une route vers Internet Gateway',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Private subnet a accès à Internet',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Identiques',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Public subnet est plus cher',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-216') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='networking' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-216',v_cert_id,v_theme_id,'Combien d''adresses IP sont réservées par subnet ?','hard','SINGLE_CHOICE','AWS réserve 5 adresses par subnet (réseau, routeur, DNS, broadcast, future).','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','5',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','3',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','4',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','2',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-217') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='networking' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-217',v_cert_id,v_theme_id,'À quoi sert un Internet Gateway ?','easy','SINGLE_CHOICE','IGW permet la communication entre le VPC et Internet.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Connecter le VPC à Internet',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Connecter des VPC entre eux',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Connecter on-premise',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Connecter des régions',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-218') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='networking' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-218',v_cert_id,v_theme_id,'Combien d''IGW peut-on attacher à un VPC ?','hard','SINGLE_CHOICE','Un VPC ne peut avoir qu''un seul Internet Gateway.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','1',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','2',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','5',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Illimité',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-219') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='networking' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-219',v_cert_id,v_theme_id,'À quoi sert un NAT Gateway ?','medium','SINGLE_CHOICE','NAT Gateway permet aux instances privées d''accéder à Internet (pas l''inverse).','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Donner accès Internet aux instances privées',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Donner accès public aux instances',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Connecter des VPC',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Filtrer le trafic',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-220') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='networking' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-220',v_cert_id,v_theme_id,'Avantage de NAT Gateway sur NAT Instance ?','hard','SINGLE_CHOICE','NAT Gateway est un service managé avec HA intégrée.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Managé, haute disponibilité, plus de bande passante',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Moins cher',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Plus simple',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Personnalisable',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-221') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='networking' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-221',v_cert_id,v_theme_id,'NAT Gateway est-il redondant au sein d''une AZ ?','hard','SINGLE_CHOICE','NAT Gateway est redondant au sein d''une AZ.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Oui',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Optionnel',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Dépend de la configuration',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-222') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='networking' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-222',v_cert_id,v_theme_id,'Qu''est-ce que VPC Peering ?','medium','SINGLE_CHOICE','VPC Peering connecte deux VPC en utilisant le réseau AWS.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Connexion entre deux VPC',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Connexion à Internet',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Connexion on-premise',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Connexion entre régions',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-223') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='networking' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-223',v_cert_id,v_theme_id,'VPC Peering supporte-t-il le transit routing ?','hard','SINGLE_CHOICE','Le peering ne supporte pas le transit routing (pas de chaînage).','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Non',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Oui',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Optionnel',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Uniquement avec TGW',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-224') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='networking' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-224',v_cert_id,v_theme_id,'Peut-on faire du peering entre VPC de régions différentes ?','hard','SINGLE_CHOICE','Inter-region VPC Peering est possible (cross-region).','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Oui',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Uniquement avec TGW',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Uniquement avec VPN',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-225') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='networking' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-225',v_cert_id,v_theme_id,'Qu''est-ce que Transit Gateway ?','hard','SINGLE_CHOICE','TGW est un hub de transit pour connecter plusieurs VPC et réseaux.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Hub central connectant VPC, VPN, Direct Connect',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Passerelle NAT',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Passerelle Internet',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Passerelle VPN',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-226') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='networking' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-226',v_cert_id,v_theme_id,'Avantage de Transit Gateway sur VPC Peering ?','hard','SINGLE_CHOICE','TGW réduit le nombre de connexions et permet le transit.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Transit routing, moins de connections (N*(N-1)/2)',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Moins cher',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Plus rapide',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Plus sécurisé',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-227') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='networking' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-227',v_cert_id,v_theme_id,'Qu''est-ce qu''AWS VPN ?','hard','SINGLE_CHOICE','AWS VPN connecte un réseau on-premise au VPC via IPsec.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Connexion VPN entre on-premise et AWS',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','VPN entre VPC',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','VPN public',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','VPN client',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-228') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='networking' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-228',v_cert_id,v_theme_id,'Qu''est-ce que AWS Client VPN ?','hard','SINGLE_CHOICE','Client VPN permet à des utilisateurs de se connecter au VPC.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','VPN pour utilisateurs individuels',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','VPN site-to-site',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','VPN entre VPC',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','VPN de gestion',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-229') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='networking' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-229',v_cert_id,v_theme_id,'Qu''est-ce qu''AWS Direct Connect ?','hard','SINGLE_CHOICE','Direct Connect est une connexion réseau physique privée entre on-premise et AWS.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Connexion réseau dédiée privée',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','VPN',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Peering',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Transit Gateway',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-230') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='networking' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-230',v_cert_id,v_theme_id,'Avantages de Direct Connect sur VPN ?','hard','SINGLE_CHOICE','Direct Connect offre des performances constantes et prédictibles.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Latence plus faible, bande passante dédiée',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Moins cher',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Plus simple',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Plus rapide à configurer',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-231') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='networking' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-231',v_cert_id,v_theme_id,'Qu''est-ce que Route53 ?','easy','SINGLE_CHOICE','Route53 est le service DNS d''AWS.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Service DNS',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Service de routage',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Service de calcul',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Base de données',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-232') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='networking' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-232',v_cert_id,v_theme_id,'Quels types d''enregistrements DNS sont supportés ?','easy','SINGLE_CHOICE','Route53 supporte tous les types DNS standards.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','A, AAAA, CNAME, MX, TXT, etc.',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Seulement A',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Seulement CNAME',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Seulement MX',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-233') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='networking' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-233',v_cert_id,v_theme_id,'Quelles sont les politiques de routage Route53 ?','hard','SINGLE_CHOICE','Route53 propose plusieurs politiques de routage.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Simple, Weighted, Latency, Failover, Geolocation, Geoproximity, Multivalue',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Simple seulement',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Weighted seulement',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Latency seulement',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-234') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='networking' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-234',v_cert_id,v_theme_id,'À quoi sert la politique Weighted ?','hard','SINGLE_CHOICE','Weighted répartit le trafic selon des poids (A/B testing).','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Répartir le trafic avec des poids',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Routage basé sur latence',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Failover',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Routage géographique',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-235') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='networking' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-235',v_cert_id,v_theme_id,'À quoi sert la politique Latency ?','hard','SINGLE_CHOICE','Latency dirige les utilisateurs vers la région avec la plus faible latence.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Redirige vers la région avec la meilleure latence',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Répartition pondérée',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Failover',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Géolocalisation',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-236') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='networking' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-236',v_cert_id,v_theme_id,'À quoi sert la politique Failover ?','hard','SINGLE_CHOICE','Failover redirige vers un secondary en cas de défaillance du primary.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Bascule active-passive',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Répartition équitable',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Latence',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Géolocalisation',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-237') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='networking' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-237',v_cert_id,v_theme_id,'À quoi sert la politique Geolocation ?','hard','SINGLE_CHOICE','Geolocation dirige selon le pays/continent de l''utilisateur.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Redirige selon la localisation de l''utilisateur',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Latence',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Poids',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Failover',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-238') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='networking' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-238',v_cert_id,v_theme_id,'Qu''est-ce que Geoproximity routing ?','hard','SINGLE_CHOICE','Geoproximity permet de décaler le trafic vers certaines régions via un bias.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Routage basé sur la proximité géographique (bias)',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Latence',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Géolocalisation',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Poids',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-239') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='networking' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-239',v_cert_id,v_theme_id,'À quoi servent les Health Checks dans Route53 ?','hard','SINGLE_CHOICE','Les health checks surveillent la disponibilité des endpoints pour les failover.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Surveiller les endpoints et déclencher les failover',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Surveiller la latence',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Surveiller le DNS',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Surveiller le SSL',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-240') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='networking' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-240',v_cert_id,v_theme_id,'Qu''est-ce que Route53 Resolver ?','hard','SINGLE_CHOICE','Resolver permet la résolution DNS entre VPC et réseaux on-premise.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Résolution DNS conditionnelle entre VPC et on-premise',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Service DNS public',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Service DNS privé',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Health check',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-241') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='networking' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-241',v_cert_id,v_theme_id,'Qu''est-ce que CloudFront ?','easy','SINGLE_CHOICE','CloudFront est le CDN d''AWS.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','CDN (Content Delivery Network)',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Service de calcul',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Base de données',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Stockage',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-242') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='networking' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-242',v_cert_id,v_theme_id,'Où sont situés les edge locations ?','medium','SINGLE_CHOICE','Les edge locations sont répartis mondialement.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Partout dans le monde',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Seulement aux USA',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Seulement en Europe',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Seulement en Asie',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-243') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='networking' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-243',v_cert_id,v_theme_id,'Qu''est-ce qu''un CloudFront Origin ?','hard','SINGLE_CHOICE','L''origine est l''endpoint qui fournit le contenu à CloudFront.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Source des contenus (S3, ALB, EC2, etc.)',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Edge location',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Cache',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Distribution',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-244') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='networking' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-244',v_cert_id,v_theme_id,'Qu''est-ce que CloudFront Signed URL / Signed Cookies ?','hard','SINGLE_CHOICE','Signed URL/Cookies permettent de sécuriser l''accès au contenu.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Accès restreint à du contenu privé',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Cache',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Compression',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Logging',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-245') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='networking' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-245',v_cert_id,v_theme_id,'Qu''est-ce que CloudFront Field-Level Encryption ?','hard','SINGLE_CHOICE','Field-Level Encryption protège les données sensibles (ex: mots de passe).','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Chiffrement de champs spécifiques dans les formulaires',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Chiffrement global',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Chiffrement en transit',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Chiffrement au repos',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-246') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='networking' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-246',v_cert_id,v_theme_id,'Qu''est-ce que CloudFront Lambda@Edge ?','hard','SINGLE_CHOICE','Lambda@Edge personnalise le contenu au plus proche de l''utilisateur.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Lambda exécuté aux edge locations',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Lambda standard',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Lambda régional',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Lambda global',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-247') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='networking' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-247',v_cert_id,v_theme_id,'Quels sont les déclencheurs Lambda@Edge ?','hard','SINGLE_CHOICE','Quatre types de déclencheurs à différentes étapes.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','viewer-request, origin-request, origin-response, viewer-response',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','request seulement',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','response seulement',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','origin seulement',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-248') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='networking' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-248',v_cert_id,v_theme_id,'Qu''est-ce qu''AWS Global Accelerator ?','hard','SINGLE_CHOICE','Global Accelerator utilise le réseau AWS pour améliorer les performances.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Accélère le trafic via le réseau AWS global',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','CDN',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','DNS',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Load balancer',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-249') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='networking' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-249',v_cert_id,v_theme_id,'Différence entre Global Accelerator et CloudFront ?','hard','SINGLE_CHOICE','CloudFront est un CDN avec cache, Global Accelerator optimise le chemin réseau.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','CloudFront cache du contenu, Global Accelerator accélère le trafic TCP/UDP',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Identiques',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','CloudFront pour les applications, Global Accelerator pour le cache',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Global Accelerator pour les API, CloudFront pour les sites',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-250') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='networking' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-250',v_cert_id,v_theme_id,'Quels types de load balancers existent dans AWS ?','easy','SINGLE_CHOICE','Quatre types de load balancers.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Application Load Balancer (ALB), Network Load Balancer (NLB), Gateway Load Balancer (GWLB), Classic Load Balancer (CLB)',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','ALB seulement',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','NLB seulement',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','CLB seulement',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-251') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='networking' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-251',v_cert_id,v_theme_id,'À quel niveau fonctionne ALB ?','medium','SINGLE_CHOICE','ALB est un load balancer de couche 7 (HTTP/HTTPS).','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Couche 7 (application)',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Couche 4 (transport)',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Couche 3 (réseau)',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Couche 2 (liaison)',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-252') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='networking' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-252',v_cert_id,v_theme_id,'Quelles fonctionnalités propose ALB ?','hard','SINGLE_CHOICE','ALB supporte le routage avancé basé sur host, path, query, headers.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Host-based routing, Path-based routing, Query string routing, Header routing',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Seulement host-based',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Seulement path-based',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Aucune',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-253') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='networking' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-253',v_cert_id,v_theme_id,'À quel niveau fonctionne NLB ?','medium','SINGLE_CHOICE','NLB est un load balancer de couche 4 (TCP/UDP/TLS).','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Couche 4 (transport)',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Couche 7 (application)',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Couche 3',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Couche 2',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-254') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='networking' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-254',v_cert_id,v_theme_id,'Avantage de NLB sur ALB ?','hard','SINGLE_CHOICE','NLB offre des performances très élevées et une IP statique.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Ultra haute performance (millions de requêtes), IP statique, TLS passthrough',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Moins cher',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Plus simple',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Plus de fonctionnalités',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-255') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='networking' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-255',v_cert_id,v_theme_id,'À quoi sert Gateway Load Balancer ?','hard','SINGLE_CHOICE','GWLB distribue le trafic vers des appliances de sécurité.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Déployer des appliances réseau (firewalls, IPS/IDS) en mode transparent',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Load balancing HTTP',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Load balancing TCP',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Load balancing UDP',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-256') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='networking' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-256',v_cert_id,v_theme_id,'Qu''est-ce que les sticky sessions (session affinity) ?','hard','SINGLE_CHOICE','Les sticky sessions maintiennent l''affinité de session.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Dirige les requêtes d''un même utilisateur vers la même instance',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Répartition équitable',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Cache',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Compression',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-257') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='networking' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-257',v_cert_id,v_theme_id,'Qu''est-ce que le cross-zone load balancing ?','hard','SINGLE_CHOICE','Cross-zone permet une distribution équitable entre toutes les instances, quelle que soit l''AZ.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Répartit le trafic également entre toutes les instances, toutes AZ',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Répartition par AZ',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Répartition par instance',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Répartition par région',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-258') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='networking' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-258',v_cert_id,v_theme_id,'À quoi servent les VPC Endpoints ?','hard','SINGLE_CHOICE','Les VPC Endpoints permettent d''accéder aux services AWS via le réseau privé.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Connecter privément aux services AWS sans Internet',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Connecter à Internet',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Connecter à on-premise',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Connecter à d''autres VPC',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-259') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='networking' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-259',v_cert_id,v_theme_id,'Quels sont les types de VPC Endpoints ?','hard','SINGLE_CHOICE','Gateway endpoints pour S3/DynamoDB, Interface pour les autres.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Gateway Endpoints (S3, DynamoDB) et Interface Endpoints (autres services)',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Interface seulement',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Gateway seulement',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','PrivateLink seulement',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-260') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='networking' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-260',v_cert_id,v_theme_id,'Qu''est-ce qu''AWS PrivateLink ?','hard','SINGLE_CHOICE','PrivateLink permet d''exposer des services via des interface endpoints.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Expose des services dans un VPC de manière privée',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','VPN',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Direct Connect',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Peering',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-261') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='networking' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-261',v_cert_id,v_theme_id,'À quoi servent les VPC Flow Logs ?','hard','SINGLE_CHOICE','Flow Logs enregistrent les informations de trafic (source, destination, ports, etc.).','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Capturer les métadonnées du trafic IP',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Logs d''application',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Logs DNS',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Logs système',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-262') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='networking' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-262',v_cert_id,v_theme_id,'Où peuvent être envoyés les VPC Flow Logs ?','hard','SINGLE_CHOICE','Les destinations supportées sont CloudWatch Logs, S3, Firehose.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','CloudWatch Logs, S3, Kinesis Data Firehose',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','S3 seulement',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','CloudWatch seulement',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Kinesis seulement',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-263') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='networking' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-263',v_cert_id,v_theme_id,'Différence entre Network ACL et Security Group ?','hard','SINGLE_CHOICE','NACL est stateless (évalue les règles de flux entrant et sortant séparément).','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','NACL stateless (règles aller/retour séparées), SG stateful',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','NACL stateful, SG stateless',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Identiques',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','NACL au niveau instance, SG au niveau subnet',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-264') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='networking' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-264',v_cert_id,v_theme_id,'Quelle est la règle par défaut d''une NACL ?','hard','SINGLE_CHOICE','Par défaut, une NACL personnalisée bloque tout, mais la NACL par défaut autorise tout.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Tout trafic entrant/sortant est autorisé',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Tout trafic est bloqué',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Tout trafic entrant bloqué, sortant autorisé',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Tout trafic entrant autorisé, sortant bloqué',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-265') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='networking' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-265',v_cert_id,v_theme_id,'Quelle est la règle par défaut d''un Security Group ?','hard','SINGLE_CHOICE','Security Group par défaut bloque inbound, autorise outbound.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Trafic entrant bloqué, trafic sortant autorisé',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Tout autorisé',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Tout bloqué',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Trafic entrant autorisé, sortant bloqué',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-266') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='networking' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-266',v_cert_id,v_theme_id,'À quoi sert Egress-Only Internet Gateway ?','hard','SINGLE_CHOICE','Egress-Only IGW est pour IPv6 seulement, permet sortie vers Internet.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Permet aux instances IPv6 d''accéder à Internet (sortant uniquement)',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Permet l''accès entrant',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Permet l''accès bidirectionnel',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Permet l''accès privé',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-267') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='networking' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-267',v_cert_id,v_theme_id,'Qu''est-ce que le VPC sharing ?','hard','SINGLE_CHOICE','VPC sharing permet à plusieurs comptes AWS d''utiliser le même VPC.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Partage d''un VPC entre plusieurs comptes',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Partage d''un subnet',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Partage d''une AZ',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Partage d''une région',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-268') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='networking' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-268',v_cert_id,v_theme_id,'Qu''est-ce qu''AWS Network Firewall ?','hard','SINGLE_CHOICE','Network Firewall est un service de firewall managé pour VPC.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Firewall managé pour VPC',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Security Group',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','NACL',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','WAF',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-269') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='networking' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-269',v_cert_id,v_theme_id,'À quoi sert AWS WAF ?','hard','SINGLE_CHOICE','WAF filtre les requêtes HTTP/HTTPS.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Protège les applications web contre les attaques (SQL injection, XSS)',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Firewall réseau',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','VPN',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Direct Connect',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-270') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='networking' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-270',v_cert_id,v_theme_id,'Qu''est-ce qu''AWS Shield ?','hard','SINGLE_CHOICE','Shield protège contre les DDoS (Standard gratuit, Advanced payant).','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Protection contre les attaques DDoS',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','WAF',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Firewall',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','VPN',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-271') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='networking' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-271',v_cert_id,v_theme_id,'Quels sont les avantages de Shield Advanced ?','hard','SINGLE_CHOICE','Shield Advanced offre des protections supplémentaires et un support spécialisé.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Protection avancée, accès à l''équipe DDoS Response Team (DRT), couverture des coûts',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Protection basique',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Gratuit',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Uniquement pour ELB',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-272') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='networking' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-272',v_cert_id,v_theme_id,'Qu''est-ce qu''un Transit VPC ?','hard','SINGLE_CHOICE','Le Transit VPC est une architecture pré-TGW pour connecter plusieurs VPC.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Architecture avec VPN entre VPC et on-premise via un VPC central',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','VPC partagé',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','VPC peering',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Transit Gateway',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-273') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='networking' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-273',v_cert_id,v_theme_id,'Qu''est-ce que VPN CloudHub ?','hard','SINGLE_CHOICE','CloudHub permet de connecter plusieurs branches via VPN.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Connecte plusieurs sites on-premise via VPN vers un même VPC',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Hub de transit',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Peering',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Direct Connect',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-274') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='networking' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-274',v_cert_id,v_theme_id,'Qu''est-ce que Accelerated Site-to-Site VPN ?','hard','SINGLE_CHOICE','Accelerated VPN utilise Global Accelerator pour optimiser le chemin.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Utilise Global Accelerator pour améliorer les performances VPN',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','VPN plus rapide',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','VPN plus sécurisé',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','VPN plus simple',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-275') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='networking' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-275',v_cert_id,v_theme_id,'VPC supporte-t-il IPv6 ?','hard','SINGLE_CHOICE','Les VPC supportent IPv4, IPv6, ou dual-stack.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Oui, dual-stack possible',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Uniquement IPv4',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Uniquement IPv6',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-276') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='networking' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-276',v_cert_id,v_theme_id,'Comment exposer un service dans un VPC via PrivateLink ?','hard','SINGLE_CHOICE','PrivateLink permet d''exposer des services via NLB et VPC Endpoint Service.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Créer un VPC Endpoint Service (Network Load Balancer + PrivateLink)',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Créer un VPC Peering',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Créer un Transit Gateway',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Créer un VPN',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-277') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='networking' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-277',v_cert_id,v_theme_id,'À quoi sert Reachability Analyzer ?','hard','SINGLE_CHOICE','Reachability Analyzer vérifie si deux ressources peuvent communiquer.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Tester la connectivité réseau entre ressources',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Monitorer les performances',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Logs de trafic',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Analyser les routes',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-278') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='networking' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-278',v_cert_id,v_theme_id,'Qu''est-ce qu''AWS Network Manager ?','hard','SINGLE_CHOICE','Network Manager offre une vue d''ensemble des réseaux.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Gestion centralisée des réseaux AWS et on-premise',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','VPC',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Transit Gateway',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Direct Connect',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-279') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='networking' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-279',v_cert_id,v_theme_id,'Qu''est-ce qu''AWS Cloud WAN ?','hard','SINGLE_CHOICE','Cloud WAN simplifie la gestion des réseaux entre sites et régions.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Service de réseau étendu (WAN) managé',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','VPC',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Transit Gateway',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Direct Connect',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-280') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='networking' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-280',v_cert_id,v_theme_id,'Comment isoler des environnements (dev, prod) ?','hard','SINGLE_CHOICE','Utiliser des VPC distincts ou des subnets avec contrôles d''accès.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','VPC séparés ou subnets avec NACL',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Même VPC',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Même subnet',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Même AZ',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-281') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='networking' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-281',v_cert_id,v_theme_id,'Comment améliorer la sécurité réseau ?','hard','SINGLE_CHOICE','Plusieurs couches de sécurité réseau.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Security Groups, NACL, VPC Flow Logs, WAF, Shield',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Uniquement Security Groups',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Uniquement NACL',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Uniquement WAF',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-282') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='networking' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-282',v_cert_id,v_theme_id,'Comment améliorer les performances réseau ?','hard','SINGLE_CHOICE','Utiliser des options d''optimisation réseau.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Placement groups, enhanced networking, ENA, EFA',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Plus d''instances',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Plus de mémoire',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Plus de CPU',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-283') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='networking' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-283',v_cert_id,v_theme_id,'Qu''est-ce que Enhanced Networking ?','hard','SINGLE_CHOICE','Enhanced Networking (SR-IOV) améliore la performance réseau.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Utilise SR-IOV pour de meilleures performances',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Plus de bande passante',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Moins de latence',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A et C',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-284') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='networking' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-284',v_cert_id,v_theme_id,'Différence entre ENA et EFA ?','hard','SINGLE_CHOICE','EFA offre une latence ultra-faible pour les applications HPC.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','EFA pour HPC (bypass OS), ENA pour usage général',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Identiques',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','ENA plus rapide',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','EFA plus simple',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-285') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='networking' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-285',v_cert_id,v_theme_id,'Quand utiliser un Network Load Balancer ?','hard','SINGLE_CHOICE','NLB est adapté aux workloads TCP/UDP haute performance.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Haute performance, IP statique, TCP/UDP, TLS passthrough',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Applications web',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Microservices',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','API REST',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-286') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='networking' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-286',v_cert_id,v_theme_id,'Quand utiliser un Application Load Balancer ?','hard','SINGLE_CHOICE','ALB est optimisé pour les applications web.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Applications HTTP/HTTPS, routage avancé, WebSocket',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','TCP',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','UDP',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','TLS passthrough',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-287') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='networking' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-287',v_cert_id,v_theme_id,'Quand utiliser CloudFront plutôt que Global Accelerator ?','hard','SINGLE_CHOICE','CloudFront pour le cache et la distribution de contenu.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Contenu statique, cache, edge computing (Lambda@Edge)',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Applications dynamiques',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','TCP/UDP',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','IP statique',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-288') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='networking' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-288',v_cert_id,v_theme_id,'Quand utiliser Global Accelerator plutôt que CloudFront ?','hard','SINGLE_CHOICE','Global Accelerator pour améliorer les performances d''applications non-cachables.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Applications dynamiques, TCP/UDP, performances réseau',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Contenu statique',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Cache',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Edge computing',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-289') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='networking' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-289',v_cert_id,v_theme_id,'Comment diagnostiquer des problèmes de connectivité ?','hard','SINGLE_CHOICE','Plusieurs outils pour analyser la connectivité.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','VPC Flow Logs, Reachability Analyzer, Network Manager',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','CloudWatch',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','CloudTrail',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','S3',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-290') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='networking' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-290',v_cert_id,v_theme_id,'Que faire si une instance n''a pas d''accès Internet ?','hard','SINGLE_CHOICE','Vérifier la configuration réseau (IGW, route, SG, NACL).','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Vérifier IGW, route table, security group, NACL',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Redémarrer l''instance',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Changer d''AZ',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Augmenter la mémoire',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-291') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security___iam' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-291',v_cert_id,v_theme_id,'Que signifie IAM ?','easy','SINGLE_CHOICE','IAM est le service de gestion des identités et des accès.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Identity and Access Management',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Integrated Access Management',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Identity and Authentication Management',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Internet Access Management',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-292') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security___iam' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-292',v_cert_id,v_theme_id,'Quels sont les composants principaux d''IAM ?','easy','SINGLE_CHOICE','IAM comprend utilisateurs, groupes, rôles et politiques.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Utilisateurs, Groupes, Rôles, Politiques',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Utilisateurs seulement',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Groupes seulement',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Rôles seulement',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-293') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security___iam' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-293',v_cert_id,v_theme_id,'Qu''est-ce qu''une politique IAM ?','easy','SINGLE_CHOICE','Les politiques IAM sont des documents JSON qui définissent les autorisations.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Document JSON définissant les permissions',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Utilisateur',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Groupe',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Rôle',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-294') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security___iam' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-294',v_cert_id,v_theme_id,'Quelle est la meilleure pratique pour les permissions ?','medium','SINGLE_CHOICE','Le principe du moindre privilège accorde uniquement les permissions nécessaires.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Principe du moindre privilège',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Donner toutes les permissions',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Donner des permissions admin',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Aucune permission',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-295') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security___iam' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-295',v_cert_id,v_theme_id,'À quoi servent les rôles IAM ?','medium','SINGLE_CHOICE','Les rôles IAM sont assumés par des services AWS (EC2, Lambda, etc.).','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Donner des permissions à des services AWS',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Authentifier des utilisateurs',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Créer des groupes',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Gérer les mots de passe',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-296') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security___iam' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-296',v_cert_id,v_theme_id,'Peut-on assumer un rôle IAM depuis un compte différent ?','hard','SINGLE_CHOICE','Les rôles IAM peuvent être assumés cross-compte avec une politique de confiance.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Oui',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Uniquement avec organisations',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Uniquement avec identity center',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-297') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security___iam' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-297',v_cert_id,v_theme_id,'Quels sont les types de politiques IAM ?','hard','SINGLE_CHOICE','Plusieurs types de politiques IAM.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Identity-based, Resource-based, Permissions boundaries, Service control policies (SCP)',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Identity-based seulement',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Resource-based seulement',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Permissions boundaries seulement',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-298') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security___iam' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-298',v_cert_id,v_theme_id,'Qu''est-ce qu''une politique resource-based ?','hard','SINGLE_CHOICE','Les politiques resource-based sont attachées directement aux ressources AWS.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Politique attachée à une ressource (bucket S3, queue SQS)',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Politique attachée à un utilisateur',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Politique attachée à un groupe',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Politique attachée à un rôle',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-299') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security___iam' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-299',v_cert_id,v_theme_id,'Qu''est-ce qu''une condition IAM ?','hard','SINGLE_CHOICE','Les conditions restreignent les permissions (IP, MFA, date, etc.).','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Restriction supplémentaire dans une politique',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Action autorisée',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Ressource ciblée',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Principal',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-300') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security___iam' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-300',v_cert_id,v_theme_id,'Quelle condition restreint l''accès par adresse IP ?','hard','SINGLE_CHOICE','aws:SourceIp restreint l''accès à une plage d''adresses IP.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','aws:SourceIp',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','aws:RequestedRegion',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','aws:MultiFactorAuthPresent',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','aws:PrincipalArn',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-301') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security___iam' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-301',v_cert_id,v_theme_id,'Quelle condition exige l''authentification MFA ?','hard','SINGLE_CHOICE','aws:MultiFactorAuthPresent vérifie que MFA a été utilisé.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','aws:MultiFactorAuthPresent',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','aws:SourceIp',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','aws:RequestedRegion',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','aws:PrincipalArn',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-302') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security___iam' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-302',v_cert_id,v_theme_id,'À quoi sert IAM Access Analyzer ?','hard','SINGLE_CHOICE','Access Analyzer identifie les ressources partagées publiquement ou cross-compte.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Analyser les politiques pour détecter les accès non intentionnels',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Créer des politiques',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Gérer les utilisateurs',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Auditer les logs',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-303') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security___iam' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-303',v_cert_id,v_theme_id,'À quoi sert IAM Access Advisor ?','hard','SINGLE_CHOICE','Access Advisor aide à affiner les politiques en montrant les permissions réellement utilisées.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Montre les services et actions utilisés par un utilisateur/rôle',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Analyse les politiques',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Gère les mots de passe',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Audite les connexions',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-304') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security___iam' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-304',v_cert_id,v_theme_id,'Peut-on configurer une politique de mot de passe IAM ?','hard','SINGLE_CHOICE','On peut configurer la complexité, l''expiration, l''historique des mots de passe.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Oui',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Uniquement pour les comptes root',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Uniquement pour les utilisateurs fédérés',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-305') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security___iam' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-305',v_cert_id,v_theme_id,'Quels types de MFA sont supportés par AWS ?','hard','SINGLE_CHOICE','AWS supporte plusieurs types de MFA.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Virtual MFA, Hardware MFA, FIDO2, SMS',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Virtual MFA seulement',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Hardware MFA seulement',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','SMS seulement',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-306') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security___iam' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-306',v_cert_id,v_theme_id,'Qu''est-ce qu''AWS Organizations ?','hard','SINGLE_CHOICE','Organizations permet de gérer plusieurs comptes AWS de manière centralisée.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Gestion centralisée de plusieurs comptes AWS',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Service de sécurité',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Base de données',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','CDN',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-307') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security___iam' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-307',v_cert_id,v_theme_id,'À quoi servent les SCP ?','hard','SINGLE_CHOICE','Les SCP définissent les permissions maximales pour les comptes de l''organisation.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Restreindre les permissions au niveau de l''organisation',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Donner des permissions',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Auditer les comptes',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Gérer les mots de passe',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-308') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security___iam' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-308',v_cert_id,v_theme_id,'Qu''est-ce qu''AWS Control Tower ?','hard','SINGLE_CHOICE','Control Tower simplifie la configuration et la gouvernance de plusieurs comptes.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Gouvernance automatisée pour multi-comptes',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Service de sécurité',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Base de données',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','CDN',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-309') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security___iam' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-309',v_cert_id,v_theme_id,'Qu''est-ce qu''AWS IAM Identity Center ?','hard','SINGLE_CHOICE','Identity Center (ex-AWS SSO) centralise l''authentification pour plusieurs comptes AWS et applications.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Authentification unique (SSO) pour plusieurs comptes et applications',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Service d''identité',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Base de données',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','CDN',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-310') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security___iam' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-310',v_cert_id,v_theme_id,'Qu''est-ce qu''AWS KMS ?','hard','SINGLE_CHOICE','KMS (Key Management Service) gère les clés de chiffrement.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Service de gestion de clés de chiffrement',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Base de données',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','CDN',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Compute',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-311') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security___iam' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-311',v_cert_id,v_theme_id,'Quels types de clés KMS existent ?','hard','SINGLE_CHOICE','Trois types de clés KMS.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Clés AWS gérées, clés clientes (Customer Managed Keys), clés CloudHSM',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Clés AWS seulement',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Clés clientes seulement',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Clés CloudHSM seulement',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-312') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security___iam' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-312',v_cert_id,v_theme_id,'Qu''est-ce que le key rotation dans KMS ?','hard','SINGLE_CHOICE','La rotation automatique des clés KMS se fait chaque année (clés clientes).','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Remplacement automatique des clés chaque année',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Suppression des clés',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Copie des clés',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Export des clés',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-313') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security___iam' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-313',v_cert_id,v_theme_id,'Qu''est-ce qu''AWS CloudHSM ?','hard','SINGLE_CHOICE','CloudHSM fournit un HSM dédié (conformité FIPS 140-2 niveau 3).','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Hardware Security Module (HSM) dédié',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Service KMS',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Base de données',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','CDN',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-314') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security___iam' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-314',v_cert_id,v_theme_id,'Différence principale entre CloudHSM et KMS ?','hard','SINGLE_CHOICE','CloudHSM est un HSM dédié, KMS est un service partagé.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','CloudHSM = matériel dédié (single-tenant), KMS = multi-tenant',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Identiques',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','KMS plus sécurisé',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','CloudHSM moins cher',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-315') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security___iam' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-315',v_cert_id,v_theme_id,'À quoi sert AWS Secrets Manager ?','hard','SINGLE_CHOICE','Secrets Manager stocke et gère les secrets avec rotation automatique.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Gestion des secrets (mots de passe, clés API)',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Base de données',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','CDN',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Compute',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-316') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security___iam' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-316',v_cert_id,v_theme_id,'Différence entre Parameter Store et Secrets Manager ?','hard','SINGLE_CHOICE','Parameter Store offre des fonctionnalités de base (gratuit), Secrets Manager gère la rotation automatique.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Parameter Store gratuit, Secrets Manager payant avec rotation intégrée',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Identiques',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Parameter Store plus cher',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Secrets Manager gratuit',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-317') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security___iam' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-317',v_cert_id,v_theme_id,'Qu''est-ce qu''AWS Certificate Manager ?','hard','SINGLE_CHOICE','ACM fournit et gère des certificats SSL/TLS pour les services AWS.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Gestion de certificats SSL/TLS',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Base de données',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','CDN',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Compute',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-318') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security___iam' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-318',v_cert_id,v_theme_id,'Où peut-on utiliser les certificats ACM ?','hard','SINGLE_CHOICE','Les certificats ACM sont utilisables avec plusieurs services AWS.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','CloudFront, ALB, NLB, API Gateway',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','EC2 seulement',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','S3 seulement',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','RDS seulement',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-319') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security___iam' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-319',v_cert_id,v_theme_id,'À quoi sert AWS WAF ?','hard','SINGLE_CHOICE','WAF filtre les requêtes HTTP/HTTPS.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Protège les applications web contre les attaques',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Firewall réseau',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','VPN',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Direct Connect',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-320') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security___iam' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-320',v_cert_id,v_theme_id,'Quelles sont les règles WAF prédéfinies ?','hard','SINGLE_CHOICE','AWS propose des managed rule groups pour les attaques courantes.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Managed rule groups (SQL injection, XSS, IP reputation, etc.)',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Aucune',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Uniquement SQL injection',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Uniquement XSS',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-321') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security___iam' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-321',v_cert_id,v_theme_id,'AWS Shield Standard est-il gratuit ?','hard','SINGLE_CHOICE','Shield Standard est inclus gratuitement pour tous les clients AWS.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Oui',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Uniquement pour EC2',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Uniquement pour CloudFront',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-322') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security___iam' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-322',v_cert_id,v_theme_id,'Quel est le coût mensuel de Shield Advanced ?','hard','SINGLE_CHOICE','Shield Advanced coûte 3 000 $ par mois + frais d''utilisation.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','3 000 $ par mois',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','1 000 $',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','5 000 $',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','10 000 $',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-323') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security___iam' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-323',v_cert_id,v_theme_id,'Qu''est-ce qu''AWS Firewall Manager ?','hard','SINGLE_CHOICE','Firewall Manager applique des règles de sécurité à travers l''organisation.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Gestion centralisée des règles de sécurité (WAF, Shield, SG) sur plusieurs comptes',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Firewall réseau',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','VPN',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Direct Connect',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-324') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security___iam' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-324',v_cert_id,v_theme_id,'À quel niveau fonctionne AWS Network Firewall ?','hard','SINGLE_CHOICE','Network Firewall protège au niveau réseau (VPC).','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Couche 3/4 (réseau)',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Couche 7 (application)',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Couche 2',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Toutes les couches',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-325') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security___iam' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-325',v_cert_id,v_theme_id,'Quelles fonctionnalités offre Network Firewall ?','hard','SINGLE_CHOICE','Network Firewall combine plusieurs fonctionnalités avancées.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Filtrage étatique, inspection TLS, intrusion prevention',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Seulement filtrage',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Seulement inspection',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Seulement IPS',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-326') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security___iam' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-326',v_cert_id,v_theme_id,'Qu''est-ce qu''Amazon GuardDuty ?','hard','SINGLE_CHOICE','GuardDuty analyse les logs (CloudTrail, VPC Flow Logs, DNS) pour détecter des comportements malveillants.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Détection de menaces (threat detection)',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Firewall',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','WAF',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','VPN',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-327') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security___iam' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-327',v_cert_id,v_theme_id,'GuardDuty est-il un service payant ?','hard','SINGLE_CHOICE','GuardDuty offre 30 jours d''essai gratuit, puis est payant.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Oui (30 jours d''essai)',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Non, gratuit',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Uniquement pour les comptes enterprise',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Uniquement pour Organizations',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-328') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security___iam' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-328',v_cert_id,v_theme_id,'À quoi sert AWS Security Hub ?','hard','SINGLE_CHOICE','Security Hub agrège les findings de GuardDuty, Inspector, Macie, etc.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Centralisation des alertes de sécurité',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Firewall',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','WAF',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','VPN',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-329') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security___iam' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-329',v_cert_id,v_theme_id,'Qu''est-ce qu''Amazon Inspector ?','hard','SINGLE_CHOICE','Inspector scanne les instances EC2 et les conteneurs pour des vulnérabilités.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Analyse de vulnérabilités sur EC2 et conteneurs',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Détection de menaces',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Firewall',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','WAF',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-330') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security___iam' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-330',v_cert_id,v_theme_id,'À quoi sert Amazon Macie ?','hard','SINGLE_CHOICE','Macie utilise le machine learning pour identifier les données sensibles (PII, etc.).','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Détection de données sensibles dans S3',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Analyse de vulnérabilités',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Firewall',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','WAF',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-331') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security___iam' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-331',v_cert_id,v_theme_id,'Qu''est-ce qu''AWS Config ?','hard','SINGLE_CHOICE','AWS Config enregistre les changements de configuration et évalue la conformité.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Évalue la conformité des ressources aux règles',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Logs',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Monitoring',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Backup',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-332') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security___iam' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-332',v_cert_id,v_theme_id,'Peut-on créer des règles personnalisées AWS Config ?','hard','SINGLE_CHOICE','On peut créer des règles personnalisées via Lambda.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Oui',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Uniquement des règles managées',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Uniquement avec Lambda',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-333') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security___iam' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-333',v_cert_id,v_theme_id,'Qu''est-ce qu''AWS CloudTrail ?','hard','SINGLE_CHOICE','CloudTrail enregistre tous les appels API AWS.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Journalisation des appels API',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Monitoring',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Logging d''applications',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Audit de sécurité',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-334') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security___iam' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-334',v_cert_id,v_theme_id,'Où sont stockés les logs CloudTrail ?','hard','SINGLE_CHOICE','Les logs CloudTrail sont envoyés vers S3 et/ou CloudWatch Logs.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','S3 (par défaut), CloudWatch Logs',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','CloudWatch seulement',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','DynamoDB',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','RDS',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-335') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security___iam' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-335',v_cert_id,v_theme_id,'Quelle est la rétention par défaut des événements CloudTrail ?','hard','SINGLE_CHOICE','CloudTrail conserve les événements management pendant 90 jours.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','90 jours (management events)',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','7 jours',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','30 jours',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','1 an',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-336') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security___iam' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-336',v_cert_id,v_theme_id,'À quoi sert CloudTrail Insights ?','hard','SINGLE_CHOICE','Insights identifie les pics d''activité API inhabituels.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Détecte des comportements anormaux d''appels API',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Logs',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Monitoring',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Audit',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-337') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security___iam' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-337',v_cert_id,v_theme_id,'Qu''est-ce qu''AWS Trusted Advisor ?','hard','SINGLE_CHOICE','Trusted Advisor fournit des recommandations pour optimiser votre environnement AWS.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Conseils sur les bonnes pratiques (sécurité, performance, coûts)',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Firewall',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','WAF',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','VPN',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-338') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security___iam' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-338',v_cert_id,v_theme_id,'À quoi sert AWS Artifact ?','hard','SINGLE_CHOICE','Artifact fournit des rapports de conformité et des accords (NDA, BAA).','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Accès aux rapports de conformité (SOC, PCI, ISO)',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Stockage de secrets',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Base de données',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','CDN',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-339') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security___iam' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-339',v_cert_id,v_theme_id,'Qu''est-ce qu''AWS Audit Manager ?','hard','SINGLE_CHOICE','Audit Manager aide à préparer des audits en collectant des preuves automatiquement.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Automatisation des audits',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Firewall',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','WAF',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','VPN',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-340') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security___iam' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-340',v_cert_id,v_theme_id,'Que recommande AWS pour la sécurité des comptes root ?','hard','SINGLE_CHOICE','Les bonnes pratiques incluent MFA et ne jamais utiliser les clés root.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','MFA, ne pas utiliser de clés d''accès, ne pas partager',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Utiliser des clés d''accès',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Partager avec l''équipe',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Désactiver MFA',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-341') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security___iam' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-341',v_cert_id,v_theme_id,'Comment sécuriser les clés d''accès IAM ?','hard','SINGLE_CHOICE','Les clés d''accès doivent être tournées et protégées.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Rotation régulière, ne pas les coder en dur, utiliser Secrets Manager',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Les partager',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Les coder dans l''application',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Ne jamais les changer',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-342') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security___iam' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-342',v_cert_id,v_theme_id,'Doit-on chiffrer les données au repos ?','hard','SINGLE_CHOICE','Le chiffrement au repos est recommandé pour toutes les données.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Oui',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Seulement les données sensibles',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Uniquement pour S3',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-343') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security___iam' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-343',v_cert_id,v_theme_id,'Doit-on chiffrer les données en transit ?','hard','SINGLE_CHOICE','Le chiffrement en transit (TLS) est recommandé pour toutes les communications.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Oui',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Seulement pour Internet',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Seulement pour les API',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-344') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security___iam' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-344',v_cert_id,v_theme_id,'Quelle est la bonne pratique pour les Security Groups ?','hard','SINGLE_CHOICE','Les Security Groups doivent être restrictifs (moindre privilège).','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Règles les plus restrictives, par IP ou SG',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Ouvrir toutes les ports',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Ouvrir 0.0.0.0/0',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Pas de règles',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-345') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security___iam' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-345',v_cert_id,v_theme_id,'Doit-on utiliser des VPC Flow Logs ?','hard','SINGLE_CHOICE','Les Flow Logs aident à diagnostiquer et auditer le trafic réseau.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Oui, pour l''audit',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Optionnel',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Uniquement pour les VPC publics',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-346') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security___iam' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-346',v_cert_id,v_theme_id,'Dans le modèle de responsabilité partagée, qui est responsable de la sécurité DU cloud ?','hard','SINGLE_CHOICE','AWS est responsable de la sécurité DU cloud (matériel, réseau, hyperviseur).','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','AWS',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Le client',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Les deux',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Ni l''un ni l''autre',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-347') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security___iam' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-347',v_cert_id,v_theme_id,'Dans le modèle de responsabilité partagée, qui est responsable de la sécurité DANS le cloud ?','hard','SINGLE_CHOICE','Le client est responsable de la sécurité DANS le cloud (données, OS, applications).','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Le client',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','AWS',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Les deux',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Ni l''un ni l''autre',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-348') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security___iam' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-348',v_cert_id,v_theme_id,'Quels services AWS sont certifiés PCI DSS ?','hard','SINGLE_CHOICE','De nombreux services AWS sont certifiés PCI DSS.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Beaucoup de services (EC2, S3, RDS, Lambda, etc.)',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Aucun',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Seulement S3',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Seulement RDS',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-349') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security___iam' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-349',v_cert_id,v_theme_id,'Quels services AWS sont éligibles HIPAA ?','hard','SINGLE_CHOICE','AWS propose un Business Associate Agreement (BAA) pour les services éligibles HIPAA.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Plusieurs services avec BAA',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Aucun',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Seulement S3',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Seulement RDS',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-350') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security___iam' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-350',v_cert_id,v_theme_id,'AWS est-il conforme GDPR ?','hard','SINGLE_CHOICE','AWS est conforme GDPR avec des engagements contractuels.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Oui',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Partiellement',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Uniquement en Europe',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-351') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security___iam' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-351',v_cert_id,v_theme_id,'Quel service aide à la réponse aux incidents de sécurité ?','hard','SINGLE_CHOICE','Plusieurs services aident à détecter et répondre aux incidents.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','GuardDuty, Security Hub, Detective, CloudTrail',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','EC2',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','S3',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','RDS',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-352') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security___iam' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-352',v_cert_id,v_theme_id,'À quoi sert Amazon Detective ?','hard','SINGLE_CHOICE','Detective aide à investiguer les findings de GuardDuty et Security Hub.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Analyse de findings pour trouver la cause racine',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Détection de menaces',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Firewall',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','WAF',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-353') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security___iam' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-353',v_cert_id,v_theme_id,'Qu''est-ce qu''AWS Security Lake ?','hard','SINGLE_CHOICE','Security Lake collecte et normalise les logs de sécurité de plusieurs sources.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Data lake centralisé pour les logs de sécurité',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Base de données',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','CDN',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Compute',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-354') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security___iam' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-354',v_cert_id,v_theme_id,'Quels types de preuves collecte Audit Manager ?','hard','SINGLE_CHOICE','Audit Manager collecte des preuves à partir de plusieurs sources.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','CloudTrail logs, Config snapshots, Security Hub findings',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Seulement CloudTrail',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Seulement Config',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Seulement Security Hub',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-355') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security___iam' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-355',v_cert_id,v_theme_id,'Que peut générer IAM Access Analyzer ?','hard','SINGLE_CHOICE','Access Analyzer peut générer des politiques à partir des accès observés.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Politiques IAM basées sur les logs CloudTrail',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Rapports',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Alertes',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Clés',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-356') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security___iam' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-356',v_cert_id,v_theme_id,'À quoi sert IAM Policy Simulator ?','hard','SINGLE_CHOICE','Policy Simulator permet de valider l''effet d''une politique.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Tester les politiques avant de les appliquer',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Créer des politiques',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Supprimer des politiques',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Auditer des politiques',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-357') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security___iam' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-357',v_cert_id,v_theme_id,'Qu''est-ce que IAM Roles Anywhere ?','hard','SINGLE_CHOICE','Roles Anywhere étend les rôles IAM à des workloads on-premise.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Permet d''utiliser des rôles IAM sur des serveurs on-premise',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Rôles pour Lambda',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Rôles pour EC2',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Rôles pour S3',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-358') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security___iam' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-358',v_cert_id,v_theme_id,'Qu''est-ce qu''AWS Verified Access ?','hard','SINGLE_CHOICE','Verified Access permet un accès sécurisé aux applications internes sans VPN.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Accès aux applications sans VPN (zero trust)',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Firewall',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','WAF',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','VPN',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-359') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security___iam' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-359',v_cert_id,v_theme_id,'Comment sécuriser un bucket S3 ?','hard','SINGLE_CHOICE','Plusieurs mesures de sécurité pour S3.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Bloquer les accès publics, chiffrement, bucket policies, MFA Delete',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Rendre public',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Pas de chiffrement',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Désactiver les logs',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-360') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security___iam' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-360',v_cert_id,v_theme_id,'Comment sécuriser RDS ?','hard','SINGLE_CHOICE','Plusieurs couches de sécurité pour RDS.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Chiffrement au repos, en transit, VPC privé, Security Groups, IAM auth',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Public IP',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Pas de chiffrement',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Accès public',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-361') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='high_availability___scalability' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-361',v_cert_id,v_theme_id,'Qu''est-ce que la haute disponibilité (HA) ?','easy','SINGLE_CHOICE','La HA garantit la continuité de service en cas de défaillance.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Capacité à rester opérationnel malgré des pannes',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Capacité à gérer plus d''utilisateurs',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Capacité à réduire les coûts',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Capacité à accélérer les performances',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-362') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='high_availability___scalability' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-362',v_cert_id,v_theme_id,'Qu''est-ce que la scalabilité horizontale ?','easy','SINGLE_CHOICE','La scalabilité horizontale ajoute des instances supplémentaires.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Ajouter plus d''instances',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Augmenter la puissance des instances',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Ajouter du stockage',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Augmenter la mémoire',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-363') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='high_availability___scalability' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-363',v_cert_id,v_theme_id,'Qu''est-ce que la scalabilité verticale ?','easy','SINGLE_CHOICE','La scalabilité verticale augmente la taille des instances (CPU, RAM).','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Augmenter la puissance des instances',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Ajouter plus d''instances',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Ajouter des zones',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Ajouter des régions',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-364') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='high_availability___scalability' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-364',v_cert_id,v_theme_id,'Quels sont les trois composants d''un Auto Scaling Group ?','medium','SINGLE_CHOICE','Les composants sont : template de lancement, politiques de scaling, taille min/max/désirée.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Launch template, Scaling policies, Size (min/max/desired)',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Launch template, VPC, Subnet',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Launch template, Security Group, IAM',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Launch template, AMI, Instance type',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-365') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='high_availability___scalability' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-365',v_cert_id,v_theme_id,'Qu''est-ce qu''une politique de scaling dynamique ?','hard','SINGLE_CHOICE','Le scaling dynamique utilise des métriques CloudWatch (CPU, réseau, etc.).','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Ajuste le nombre d''instances en fonction des métriques',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Planification fixe',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Scaling manuel',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Scaling prédictif',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-366') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='high_availability___scalability' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-366',v_cert_id,v_theme_id,'Qu''est-ce que le scaling prédictif ?','hard','SINGLE_CHOICE','Predictive scaling utilise ML pour anticiper les pics.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Utilise le machine learning pour prévoir la charge',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Scaling basé sur métriques',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Scaling manuel',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Scaling planifié',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-367') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='high_availability___scalability' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-367',v_cert_id,v_theme_id,'Qu''est-ce qu''un scheduled scaling ?','hard','SINGLE_CHOICE','Scheduled scaling planifie des changements à des moments prévus.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Scaling à heures fixes',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Scaling basé sur métriques',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Scaling manuel',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Scaling prédictif',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-368') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='high_availability___scalability' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-368',v_cert_id,v_theme_id,'Qu''est-ce que l''équilibrage de zone dans Auto Scaling ?','hard','SINGLE_CHOICE','Auto Scaling peut distribuer les instances uniformément entre les AZ.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Répartit les instances équitablement entre les AZ',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Met toutes les instances dans une AZ',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Équilibre la charge CPU',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Équilibre la mémoire',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-369') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='high_availability___scalability' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-369',v_cert_id,v_theme_id,'Quels sont les types de load balancers AWS ?','medium','SINGLE_CHOICE','Application Load Balancer, Network Load Balancer, Gateway Load Balancer, Classic Load Balancer.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','ALB, NLB, GWLB, CLB',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','ALB seulement',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','NLB seulement',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','CLB seulement',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-370') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='high_availability___scalability' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-370',v_cert_id,v_theme_id,'À quel niveau fonctionne ALB ?','hard','SINGLE_CHOICE','ALB est un load balancer de couche 7 (HTTP/HTTPS).','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Couche 7 (application)',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Couche 4 (transport)',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Couche 3',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Couche 2',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-371') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='high_availability___scalability' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-371',v_cert_id,v_theme_id,'À quel niveau fonctionne NLB ?','hard','SINGLE_CHOICE','NLB est un load balancer de couche 4 (TCP/UDP/TLS).','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Couche 4 (transport)',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Couche 7 (application)',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Couche 3',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Couche 2',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-372') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='high_availability___scalability' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-372',v_cert_id,v_theme_id,'Qu''est-ce que le cross-zone load balancing ?','hard','SINGLE_CHOICE','Cross-zone permet une distribution équitable entre toutes les instances, quelle que soit l''AZ.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Répartit le trafic également entre toutes les instances, toutes AZ',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Répartition par AZ',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Répartition par instance',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Répartition par région',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-373') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='high_availability___scalability' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-373',v_cert_id,v_theme_id,'Qu''est-ce que les sticky sessions (session affinity) ?','hard','SINGLE_CHOICE','Les sticky sessions maintiennent l''affinité de session.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Dirige les requêtes d''un même utilisateur vers la même instance',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Répartition équitable',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Cache',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Compression',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-374') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='high_availability___scalability' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-374',v_cert_id,v_theme_id,'Pourquoi utiliser plusieurs Availability Zones (AZ) ?','medium','SINGLE_CHOICE','Multi-AZ garantit la continuité de service en cas de panne d''une AZ.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Haute disponibilité et tolérance aux pannes',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Réduction des coûts',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Meilleures performances',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Conformité légale',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-375') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='high_availability___scalability' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-375',v_cert_id,v_theme_id,'Quelle est la latence typique entre deux AZ ?','hard','SINGLE_CHOICE','La latence entre AZ d''une même région est très faible (ms).','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Quelques millisecondes',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Quelques secondes',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Quelques minutes',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Quelques heures',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-376') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='high_availability___scalability' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-376',v_cert_id,v_theme_id,'Pourquoi utiliser plusieurs régions ?','hard','SINGLE_CHOICE','Multi-region améliore la résilience et la proximité avec les utilisateurs.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Disaster recovery, latence, conformité',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Réduction des coûts',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Simplicité',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Performances réseau',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-377') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='high_availability___scalability' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-377',v_cert_id,v_theme_id,'Comment RDS Multi-AZ assure la haute disponibilité ?','hard','SINGLE_CHOICE','Multi-AZ réplique synchrone vers une standby pour failover automatique.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Réplication synchrone vers une instance standby dans une autre AZ',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Réplication asynchrone',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Snapshots',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Backup',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-378') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='high_availability___scalability' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-378',v_cert_id,v_theme_id,'Les Read Replicas RDS améliorent-ils la haute disponibilité ?','hard','SINGLE_CHOICE','Les Read Replicas déchargent les lectures, mais le failover n''est pas automatique.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Non, ils améliorent la scalabilité des lectures',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Oui, HA',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Oui, pour les écritures',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Non, uniquement les performances',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-379') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='high_availability___scalability' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-379',v_cert_id,v_theme_id,'Aurora réplique-t-il les données automatiquement ?','hard','SINGLE_CHOICE','Aurora réplique les données sur 3 AZ (6 copies).','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Oui, sur 3 AZ (6 copies)',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Uniquement sur 2 AZ',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Uniquement sur 1 AZ',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-380') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='high_availability___scalability' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-380',v_cert_id,v_theme_id,'Aurora supporte-t-il les réplicas cross-region ?','hard','SINGLE_CHOICE','Aurora Global Database permet des réplicas dans d''autres régions.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Oui',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Uniquement avec Global Database',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Uniquement avec DMS',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-381') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='high_availability___scalability' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-381',v_cert_id,v_theme_id,'DynamoDB est-il hautement disponible par défaut ?','hard','SINGLE_CHOICE','DynamoDB réplique automatiquement les données sur 3 AZ.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Oui',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Uniquement avec DAX',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Uniquement avec Global Tables',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-382') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='high_availability___scalability' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-382',v_cert_id,v_theme_id,'Que permettent les DynamoDB Global Tables ?','hard','SINGLE_CHOICE','Global Tables répliquent les données dans plusieurs régions, lecture/écriture partout.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Tables multi-région multi-actif',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Backup',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Cache',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Streaming',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-383') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='high_availability___scalability' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-383',v_cert_id,v_theme_id,'S3 Standard réplique-t-il les données ?','hard','SINGLE_CHOICE','S3 Standard réplique les données sur au moins 3 AZ.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Oui, sur 3 AZ',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Oui, sur 2 AZ',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Oui, sur 1 AZ',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-384') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='high_availability___scalability' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-384',v_cert_id,v_theme_id,'S3 CRR réplique-t-il les objets existants par défaut ?','hard','SINGLE_CHOICE','CRR réplique uniquement les nouveaux objets, pas les existants.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Non',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Oui',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Optionnel',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Uniquement avec Versioning',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-385') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='high_availability___scalability' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-385',v_cert_id,v_theme_id,'EFS est-il répliqué sur plusieurs AZ ?','hard','SINGLE_CHOICE','EFS Standard réplique les données sur plusieurs AZ.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Oui',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Uniquement avec EFS One Zone',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Uniquement avec EFS Standard',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-386') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='high_availability___scalability' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-386',v_cert_id,v_theme_id,'EFS One Zone est-il recommandé pour les données critiques ?','hard','SINGLE_CHOICE','EFS One Zone ne résiste pas à une panne d''AZ.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Non',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Oui',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Oui avec backup',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Uniquement pour les données temporaires',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-387') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='high_availability___scalability' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-387',v_cert_id,v_theme_id,'ElastiCache Redis supporte-t-il Multi-AZ ?','hard','SINGLE_CHOICE','Redis avec réplication supporte Multi-AZ pour failover automatique.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Oui',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Uniquement avec cluster',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Uniquement avec réplication',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-388') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='high_availability___scalability' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-388',v_cert_id,v_theme_id,'ElastiCache Memcached supporte-t-il Multi-AZ ?','hard','SINGLE_CHOICE','Memcached ne supporte pas la persistance ni le Multi-AZ.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Non',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Oui',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Uniquement avec cluster',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Uniquement avec réplication',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-389') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='high_availability___scalability' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-389',v_cert_id,v_theme_id,'Route53 est-il hautement disponible ?','hard','SINGLE_CHOICE','Route53 est un service global hautement disponible.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Oui',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Partiellement',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Uniquement pour les enregistrements A',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-390') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='high_availability___scalability' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-390',v_cert_id,v_theme_id,'Comment configurer un failover actif-passif avec Route53 ?','hard','SINGLE_CHOICE','Failover routing bascule vers un secondary en cas de défaillance du primary.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Politique de routage Failover avec health check',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Weighted routing',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Latency routing',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Geolocation routing',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-391') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='high_availability___scalability' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-391',v_cert_id,v_theme_id,'CloudFront est-il hautement disponible ?','hard','SINGLE_CHOICE','CloudFront est un CDN mondial hautement disponible.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Oui',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Partiellement',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Uniquement avec origin failover',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-392') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='high_availability___scalability' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-392',v_cert_id,v_theme_id,'Qu''est-ce que CloudFront Origin Failover ?','hard','SINGLE_CHOICE','Origin failover redirige le trafic vers une origine de secours.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Bascule vers une origine secondaire en cas d''échec',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Cache',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Compression',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Logging',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-393') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='high_availability___scalability' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-393',v_cert_id,v_theme_id,'Global Accelerator est-il hautement disponible ?','hard','SINGLE_CHOICE','Global Accelerator utilise le réseau AWS mondial pour une HA naturelle.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Oui',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Partiellement',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Uniquement avec ALB',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-394') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='high_availability___scalability' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-394',v_cert_id,v_theme_id,'Qu''est-ce que le RTO (Recovery Time Objective) ?','hard','SINGLE_CHOICE','RTO est le délai maximal pour restaurer un service après une panne.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Temps maximum acceptable d''indisponibilité',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Quantité de données perdues acceptable',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Temps de sauvegarde',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Temps de restauration',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-395') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='high_availability___scalability' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-395',v_cert_id,v_theme_id,'Qu''est-ce que le RPO (Recovery Point Objective) ?','hard','SINGLE_CHOICE','RPO définit la perte de données maximale acceptable (en temps).','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Quantité maximale de données perdues acceptable',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Temps d''indisponibilité',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Temps de sauvegarde',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Temps de restauration',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-396') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='high_availability___scalability' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-396',v_cert_id,v_theme_id,'Quelle stratégie DR a le RTO/RPO le plus faible ?','hard','SINGLE_CHOICE','Active-active a le meilleur RTO/RPO (presque zéro).','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Multi-site active-active',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Pilot light',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Backup and restore',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Warm standby',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-397') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='high_availability___scalability' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-397',v_cert_id,v_theme_id,'Qu''est-ce que la stratégie Pilot Light ?','hard','SINGLE_CHOICE','Pilot light conserve les services critiques en veille pour bascule rapide.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Infrastructure minimale en veille dans une autre région',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Backup and restore',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Active-active',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Warm standby',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-398') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='high_availability___scalability' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-398',v_cert_id,v_theme_id,'Qu''est-ce que Warm Standby ?','hard','SINGLE_CHOICE','Warm standby a une capacité de production réduite prête à monter en charge.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Environnement réduit en veille dans une autre région',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Backup and restore',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Active-active',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Pilot light',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-399') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='high_availability___scalability' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-399',v_cert_id,v_theme_id,'Quelle est la stratégie DR la plus économique ?','hard','SINGLE_CHOICE','Backup and restore a le coût le plus bas mais le RTO le plus élevé.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Backup and restore',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Active-active',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Pilot light',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Warm standby',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-400') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='high_availability___scalability' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-400',v_cert_id,v_theme_id,'Qu''est-ce que l''EC2 Instance Recovery ?','hard','SINGLE_CHOICE','Instance Recovery redémarre l''instance sur un nouveau matériel en cas de défaillance.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Redémarrage automatique sur un nouveau matériel',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Backup',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Snapshot',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Migration vers une autre région',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-401') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='high_availability___scalability' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-401',v_cert_id,v_theme_id,'EC2 Auto Recovery peut-il être configuré via CloudWatch ?','hard','SINGLE_CHOICE','On peut configurer une alarme CloudWatch pour déclencher la récupération.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Oui',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Uniquement avec ASG',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Uniquement avec ELB',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-402') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='high_availability___scalability' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-402',v_cert_id,v_theme_id,'À quoi servent les lifecycle hooks dans ASG ?','hard','SINGLE_CHOICE','Les lifecycle hooks permettent de personnaliser le démarrage/arrêt.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Exécuter des actions avant que l''instance ne soit en service ou terminée',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Scaling',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Load balancing',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Health checks',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-403') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='high_availability___scalability' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-403',v_cert_id,v_theme_id,'Quels types de health checks peut utiliser un ASG ?','hard','SINGLE_CHOICE','ASG peut utiliser les checks EC2 et ceux du load balancer.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','EC2 status checks et ELB health checks',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Uniquement EC2',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Uniquement ELB',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Uniquement CloudWatch',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-404') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='high_availability___scalability' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-404',v_cert_id,v_theme_id,'Quelle instance est terminée en premier par défaut ?','hard','SINGLE_CHOICE','Par défaut, ASG termine d''abord les instances avec la configuration la plus ancienne.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Instance avec la plus ancienne configuration de lancement',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Instance la plus ancienne',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Instance la plus récente',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Instance la moins chère',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-405') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='high_availability___scalability' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-405',v_cert_id,v_theme_id,'Que se passe-t-il si une instance échoue aux health checks ELB ?','hard','SINGLE_CHOICE','ELB retire l''instance du pool de distribution.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','L''ELB arrête d''envoyer du trafic',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','L''ELB la redémarre',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','L''ELB la supprime',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','L''ELB ignore',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-406') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='high_availability___scalability' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-406',v_cert_id,v_theme_id,'Quel est le timeout inactivité par défaut pour ALB ?','hard','SINGLE_CHOICE','Le timeout par défaut d''ALB est 60 secondes.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','60 secondes',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','30 secondes',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','120 secondes',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','300 secondes',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-407') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='high_availability___scalability' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-407',v_cert_id,v_theme_id,'À quoi sert Provisioned Concurrency dans Lambda ?','hard','SINGLE_CHOICE','Provisioned concurrency maintient des instances chaudes pour réduire la latence.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Garde des instances Lambda pré-initialisées',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Limite le nombre d''exécutions',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Augmente le timeout',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Réduit la mémoire',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-408') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='high_availability___scalability' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-408',v_cert_id,v_theme_id,'À quoi sert Reserved Concurrency dans Lambda ?','hard','SINGLE_CHOICE','Reserved concurrency limite le nombre d''instances simultanées.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Limite le nombre d''exécutions concurrentes',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Réserve de la capacité',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Augmente la mémoire',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Réduit les coûts',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-409') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='high_availability___scalability' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-409',v_cert_id,v_theme_id,'SQS FIFO garantit-il l''ordre des messages ?','hard','SINGLE_CHOICE','SQS FIFO (First-In-First-Out) garantit l''ordre des messages.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Oui',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Optionnel',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Uniquement avec groupes de messages',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-410') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='high_availability___scalability' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-410',v_cert_id,v_theme_id,'À quoi sert une Dead Letter Queue (DLQ) dans SQS ?','hard','SINGLE_CHOICE','DLQ collecte les messages qui n''ont pas pu être traités.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Recevoir les messages non traités après plusieurs tentatives',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Stockage de secours',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Cache',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Logging',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-411') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='high_availability___scalability' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-411',v_cert_id,v_theme_id,'Qu''est-ce que le visibility timeout dans SQS ?','hard','SINGLE_CHOICE','Le visibility timeout empêche d''autres consommateurs de traiter le même message.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Pendant combien de temps un message est invisible après lecture',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Durée de vie du message',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Délai de livraison',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Timeout de la queue',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-412') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='high_availability___scalability' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-412',v_cert_id,v_theme_id,'Qu''est-ce que le long polling dans SQS ?','hard','SINGLE_CHOICE','Long polling réduit les appels vides et la latence.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Attend jusqu''à 20 secondes pour des messages',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Polling court',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Polling asynchrone',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Polling batch',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-413') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='high_availability___scalability' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-413',v_cert_id,v_theme_id,'SNS est-il hautement disponible ?','hard','SINGLE_CHOICE','SNS est un service managé hautement disponible.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Oui',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Partiellement',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Uniquement avec FIFO',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-414') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='high_availability___scalability' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-414',v_cert_id,v_theme_id,'Kinesis Data Streams réplique-t-il les données ?','hard','SINGLE_CHOICE','Kinesis réplique les données sur 3 AZ pour une haute disponibilité.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Oui, sur 3 AZ',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Oui, sur 2 AZ',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Oui, sur 1 AZ',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-415') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='high_availability___scalability' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-415',v_cert_id,v_theme_id,'Combien de temps les données sont-elles conservées par défaut ?','hard','SINGLE_CHOICE','La rétention par défaut est 24 heures (configurable jusqu''à 365 jours).','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','24 heures',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','7 jours',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','48 heures',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','30 jours',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-416') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='high_availability___scalability' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-416',v_cert_id,v_theme_id,'Les snapshots EBS sont-ils stockés de manière redondante ?','hard','SINGLE_CHOICE','Les snapshots EBS sont stockés dans S3, donc répliqués.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Oui',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Optionnel',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Uniquement dans la même AZ',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-417') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='high_availability___scalability' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-417',v_cert_id,v_theme_id,'Peut-on copier un snapshot EBS vers une autre région ?','hard','SINGLE_CHOICE','Les snapshots peuvent être copiés entre régions pour DR.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Oui',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Uniquement avec AWS Backup',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Uniquement avec DMS',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-418') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='high_availability___scalability' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-418',v_cert_id,v_theme_id,'AWS Backup permet-il des sauvegardes cross-region ?','hard','SINGLE_CHOICE','AWS Backup peut copier automatiquement les sauvegardes vers une autre région.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Oui',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Uniquement pour RDS',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Uniquement pour EC2',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-419') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='high_availability___scalability' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-419',v_cert_id,v_theme_id,'DMS peut-il maintenir une réplication continue pour DR ?','hard','SINGLE_CHOICE','DMS peut effectuer une réplication continue pour la DR.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Oui',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Uniquement pour la migration initiale',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Uniquement pour les bases Oracle',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-420') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='high_availability___scalability' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-420',v_cert_id,v_theme_id,'Quelle est la meilleure pratique pour la HA d''une application web ?','hard','SINGLE_CHOICE','Combiner Multi-AZ, Auto Scaling et Load Balancer pour une HA optimale.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Multi-AZ, ASG, ELB',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Single AZ',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Single instance',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Pas de load balancer',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-421') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='monitoring___logging' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-421',v_cert_id,v_theme_id,'Qu''est-ce qu''Amazon CloudWatch ?','easy','SINGLE_CHOICE','CloudWatch collecte métriques, logs et alarmes.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Service de monitoring et observabilité',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Base de données',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Stockage',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Compute',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-422') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='monitoring___logging' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-422',v_cert_id,v_theme_id,'Quelle est la résolution standard des métriques CloudWatch ?','easy','SINGLE_CHOICE','Les métriques standard ont une granularité d''1 minute.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','1 minute',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','5 minutes',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','10 secondes',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','1 seconde',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-423') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='monitoring___logging' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-423',v_cert_id,v_theme_id,'Qu''est-ce que les métriques haute résolution (high-res) ?','hard','SINGLE_CHOICE','Les métriques haute résolution peuvent avoir une granularité d''1 seconde.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Métriques avec granularité jusqu''à 1 seconde',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Métriques avec granularité 5 minutes',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Métriques avec granularité 1 minute',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Métriques avec granularité 1 heure',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-424') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='monitoring___logging' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-424',v_cert_id,v_theme_id,'Combien de temps les métriques sont-elles conservées par défaut ?','hard','SINGLE_CHOICE','Les métriques CloudWatch sont conservées 15 mois.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','15 mois',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','1 mois',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','3 mois',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','6 mois',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-425') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='monitoring___logging' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-425',v_cert_id,v_theme_id,'À quoi servent les alarmes CloudWatch ?','medium','SINGLE_CHOICE','Les alarmes surveillent les métriques et déclenchent des actions (SNS, ASG, etc.).','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Déclencher des actions basées sur des métriques',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Logging',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Dashboard',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Stockage',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-426') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='monitoring___logging' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-426',v_cert_id,v_theme_id,'Quels sont les états possibles d''une alarme ?','hard','SINGLE_CHOICE','Les alarmes peuvent être OK, ALARM ou INSUFFICIENT_DATA.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','OK, ALARM, INSUFFICIENT_DATA',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','OK, ERROR, WARNING',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','GREEN, RED, YELLOW',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','ACTIVE, INACTIVE',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-427') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='monitoring___logging' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-427',v_cert_id,v_theme_id,'Où sont stockés les CloudWatch Logs ?','medium','SINGLE_CHOICE','CloudWatch Logs a son propre stockage.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','CloudWatch Logs (stockage propre)',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','S3',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','DynamoDB',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','RDS',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-428') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='monitoring___logging' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-428',v_cert_id,v_theme_id,'Combien de temps les logs sont-ils conservés par défaut ?','hard','SINGLE_CHOICE','Par défaut, les logs n''expirent jamais.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Jamais expiré',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','30 jours',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','7 jours',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','1 an',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-429') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='monitoring___logging' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-429',v_cert_id,v_theme_id,'À quoi sert CloudWatch Logs Insights ?','hard','SINGLE_CHOICE','Logs Insights permet d''interroger les logs avec un langage dédié.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Requêter et analyser les logs',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Stocker les logs',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Archiver les logs',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Supprimer les logs',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-430') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='monitoring___logging' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-430',v_cert_id,v_theme_id,'À quoi sert Contributor Insights ?','hard','SINGLE_CHOICE','Contributor Insights analyse les logs pour trouver les principaux contributeurs.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Identifier les contributeurs (top IP, URLs, etc.)',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Logs',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Métriques',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Alarmes',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-431') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='monitoring___logging' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-431',v_cert_id,v_theme_id,'Qu''est-ce que CloudWatch Synthetics (Canaries) ?','hard','SINGLE_CHOICE','Les canaries simulent des actions utilisateur pour vérifier la disponibilité.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Tests de disponibilité (API, UI) automatisés',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Monitoring de logs',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Métriques personnalisées',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Dashboard',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-432') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='monitoring___logging' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-432',v_cert_id,v_theme_id,'Qu''est-ce que CloudWatch ServiceLens ?','hard','SINGLE_CHOICE','ServiceLens combine CloudWatch et X-Ray pour la visibilité des applications.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Intégration de traces, métriques et logs',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Logs',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Métriques',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Alarmes',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-433') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='monitoring___logging' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-433',v_cert_id,v_theme_id,'À quoi sert AWS X-Ray ?','hard','SINGLE_CHOICE','X-Ray trace les requêtes à travers les services distribués.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Tracing distribué',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Métriques',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Logs',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Alarmes',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-434') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='monitoring___logging' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-434',v_cert_id,v_theme_id,'Quelles informations X-Ray fournit-il ?','hard','SINGLE_CHOICE','X-Ray montre le chemin complet d''une requête avec les temps.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Latence, segments, sous-segments, traces',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Seulement la latence',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Seulement les erreurs',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Seulement les logs',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-435') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='monitoring___logging' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-435',v_cert_id,v_theme_id,'CloudTrail enregistre-t-il les événements de données (S3, DynamoDB) ?','hard','SINGLE_CHOICE','Les événements de données sont optionnels (payants).','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Oui, optionnel',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Oui, par défaut',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Uniquement pour S3',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-436') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='monitoring___logging' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-436',v_cert_id,v_theme_id,'CloudTrail peut-il envoyer des logs vers CloudWatch Logs ?','hard','SINGLE_CHOICE','CloudTrail peut envoyer les logs vers S3 et/ou CloudWatch Logs.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Oui',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Uniquement vers S3',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Uniquement vers Kinesis',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-437') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='monitoring___logging' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-437',v_cert_id,v_theme_id,'Que détecte CloudTrail Insights ?','hard','SINGLE_CHOICE','Insights identifie les pics d''activité API inhabituels.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Comportements anormaux d''appels API',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Erreurs HTTP',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Logs d''application',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Métriques de performance',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-438') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='monitoring___logging' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-438',v_cert_id,v_theme_id,'AWS Config enregistre-t-il l''historique des configurations ?','hard','SINGLE_CHOICE','AWS Config conserve l''historique des changements de configuration.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Oui',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Uniquement pour EC2',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Uniquement pour S3',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-439') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='monitoring___logging' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-439',v_cert_id,v_theme_id,'Combien de temps AWS Config conserve-t-il l''historique ?','hard','SINGLE_CHOICE','AWS Config conserve l''historique jusqu''à 7 ans (configurable).','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','7 ans',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','30 jours',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','1 an',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Indéfini',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-440') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='monitoring___logging' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-440',v_cert_id,v_theme_id,'Peut-on créer des règles Config personnalisées ?','hard','SINGLE_CHOICE','Les règles personnalisées s''écrivent avec AWS Lambda.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Oui, via Lambda',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Uniquement des règles managées',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Uniquement avec CloudFormation',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-441') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='monitoring___logging' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-441',v_cert_id,v_theme_id,'Que captent les VPC Flow Logs ?','hard','SINGLE_CHOICE','Flow Logs enregistrent les en-têtes (source, destination, ports, etc.), pas le contenu.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Métadonnées du trafic IP',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Contenu des paquets',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Payload des requêtes',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Données utilisateur',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-442') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='monitoring___logging' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-442',v_cert_id,v_theme_id,'Peut-on activer Flow Logs au niveau du subnet ?','hard','SINGLE_CHOICE','Flow Logs peuvent être activés au niveau VPC, subnet, ou ENI.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Oui',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Uniquement au niveau VPC',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Uniquement au niveau ENI',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-443') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='monitoring___logging' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-443',v_cert_id,v_theme_id,'AWS Health Dashboard fournit-il des informations personnalisées ?','hard','SINGLE_CHOICE','Le Personal Health Dashboard montre les événements affectant vos ressources.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Oui (Personal Health Dashboard)',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Uniquement des informations publiques',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Uniquement pour les comptes Enterprise',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-444') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='monitoring___logging' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-444',v_cert_id,v_theme_id,'Peut-on interroger AWS Health via API ?','hard','SINGLE_CHOICE','AWS Health a une API pour récupérer les événements.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Oui',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Uniquement pour les comptes support',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Uniquement pour les organisations',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-445') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='monitoring___logging' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-445',v_cert_id,v_theme_id,'Le CloudWatch Agent peut-il collecter des métriques système sur EC2 ?','hard','SINGLE_CHOICE','L''agent CloudWatch collecte les métriques système et les logs.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Oui',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Uniquement avec SSM',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Uniquement avec Lambda',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-446') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='monitoring___logging' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-446',v_cert_id,v_theme_id,'CloudWatch Agent peut-il collecter des logs d''applications ?','hard','SINGLE_CHOICE','L''agent peut collecter des logs d''applications personnalisées.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Oui',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Uniquement des logs système',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Uniquement des logs Windows',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-447') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='monitoring___logging' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-447',v_cert_id,v_theme_id,'À quoi sert le format de métrique embarqué (EMF) ?','hard','SINGLE_CHOICE','EMF extrait des métriques à partir de logs structurés.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Générer des métriques depuis des logs',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Stocker des logs',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Compresser des logs',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Archiver des logs',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-448') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='monitoring___logging' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-448',v_cert_id,v_theme_id,'Qu''est-ce qu''Amazon Managed Service for Prometheus (AMP) ?','hard','SINGLE_CHOICE','AMP est un service Prometheus entièrement managé.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Service Prometheus managé',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Base de données',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Stockage',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','CDN',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-449') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='monitoring___logging' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-449',v_cert_id,v_theme_id,'Qu''est-ce qu''Amazon Managed Grafana (AMG) ?','hard','SINGLE_CHOICE','AMG est un service Grafana entièrement managé.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Service Grafana managé',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Base de données',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Stockage',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','CDN',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-450') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='monitoring___logging' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-450',v_cert_id,v_theme_id,'Quelles métriques sont critiques pour EC2 ?','hard','SINGLE_CHOICE','Plusieurs métriques sont importantes, certaines nécessitent l''agent.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','CPUUtilization, NetworkIn/Out, DiskRead/Write',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Memory (nécessite agent)',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Status checks',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-451') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='monitoring___logging' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-451',v_cert_id,v_theme_id,'Comment surveiller les logs d''application ?','hard','SINGLE_CHOICE','CloudWatch Logs est la solution recommandée.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','CloudWatch Logs, CloudWatch Logs Insights, X-Ray',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','S3',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','DynamoDB',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','RDS',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-452') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='monitoring___logging' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-452',v_cert_id,v_theme_id,'Comment surveiller les coûts ?','hard','SINGLE_CHOICE','Cost Explorer et Budgets sont dédiés à la gestion des coûts.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','AWS Cost Explorer, Budgets, Trusted Advisor',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','CloudWatch',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','CloudTrail',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Config',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-453') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='monitoring___logging' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-453',v_cert_id,v_theme_id,'EventBridge peut-il répondre aux événements CloudWatch Alarms ?','hard','SINGLE_CHOICE','EventBridge peut déclencher des actions basées sur les alarmes.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Oui',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Uniquement aux événements AWS',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Uniquement aux événements personnalisés',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-454') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='monitoring___logging' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-454',v_cert_id,v_theme_id,'EventBridge supporte-t-il les schémas d''événements ?','hard','SINGLE_CHOICE','EventBridge Schema Registry découvre et versionne les schémas.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Oui (Schema Registry)',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Uniquement pour les événements AWS',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Uniquement pour les événements personnalisés',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-455') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='monitoring___logging' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-455',v_cert_id,v_theme_id,'Les dashboards CloudWatch sont-ils partageables ?','hard','SINGLE_CHOICE','Les dashboards peuvent être partagés via des comptes ou publics.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Oui',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Uniquement avec un compte pro',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Uniquement avec AWS Organizations',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-456') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='monitoring___logging' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-456',v_cert_id,v_theme_id,'Peut-on exporter un dashboard CloudWatch en JSON ?','hard','SINGLE_CHOICE','Les dashboards peuvent être exportés en JSON pour sauvegarde.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Oui',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Uniquement en PNG',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Uniquement en PDF',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-457') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='monitoring___logging' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-457',v_cert_id,v_theme_id,'Qu''est-ce qu''AWS Distro for OpenTelemetry (ADOT) ?','hard','SINGLE_CHOICE','ADOT est la distribution AWS d''OpenTelemetry.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Distribution certifiée d''OpenTelemetry',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Service de tracing',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Métriques',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Logs',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-458') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='monitoring___logging' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-458',v_cert_id,v_theme_id,'À quoi sert CloudWatch Application Signals ?','hard','SINGLE_CHOICE','Application Signals fournit une visibilité sans code sur les applications.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Monitoring des applications sans instrumentation',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Logs',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Métriques',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Tracing',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-459') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='monitoring___logging' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-459',v_cert_id,v_theme_id,'Qu''est-ce que CloudWatch Internet Monitor ?','hard','SINGLE_CHOICE','Internet Monitor détecte les problèmes de connectivité réseau entre les utilisateurs et AWS.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Surveille la connectivité Internet vers vos applications',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Logs',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Métriques',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Tracing',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-460') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='monitoring___logging' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-460',v_cert_id,v_theme_id,'Quelle est la bonne pratique pour centraliser les logs multi-comptes ?','hard','SINGLE_CHOICE','Centraliser les logs facilite l''analyse et la conformité.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Centralisation vers un compte de logging avec CloudWatch cross-account',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Logs séparés par compte',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','S3 dans chaque compte',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','CloudTrail uniquement',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-461') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='pricing___support' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-461',v_cert_id,v_theme_id,'Quels sont les modèles de tarification AWS ?','easy','SINGLE_CHOICE','AWS propose plusieurs modèles pour optimiser les coûts.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Pay-as-you-go, Reserved, Spot, Savings Plans',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Uniquement pay-as-you-go',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Uniquement Reserved',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Uniquement Spot',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-462') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='pricing___support' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-462',v_cert_id,v_theme_id,'Quel est le modèle de paiement On-Demand ?','easy','SINGLE_CHOICE','On-Demand ne nécessite aucun engagement et facture à l''usage.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Payer à l''heure ou à la seconde',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Paiement anticipé',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Engagement 1 an',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Engagement 3 ans',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-463') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='pricing___support' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-463',v_cert_id,v_theme_id,'Quelles sont les options de paiement pour Reserved Instances ?','medium','SINGLE_CHOICE','Trois options de paiement pour les RI.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','All Upfront, Partial Upfront, No Upfront',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Mensuel, Trimestriel, Annuel',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','À la demande uniquement',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Pay as you go',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-464') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='pricing___support' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-464',v_cert_id,v_theme_id,'Quel est le plus grand rabais pour les RI ?','hard','SINGLE_CHOICE','All Upfront 3 ans offre le plus grand rabais (jusqu''à 75%).','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','All Upfront 3 ans',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','No Upfront 1 an',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Partial Upfront 3 ans',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','All Upfront 1 an',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-465') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='pricing___support' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-465',v_cert_id,v_theme_id,'Quel est l''inconvénient des instances Spot ?','medium','SINGLE_CHOICE','Les instances Spot peuvent être reprises par AWS avec un préavis.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Peuvent être interrompues avec préavis de 2 minutes',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Plus chères',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Pas de Linux',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Pas de Windows',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-466') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='pricing___support' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-466',v_cert_id,v_theme_id,'Quel est le rabais typique des instances Spot ?','hard','SINGLE_CHOICE','Les instances Spot peuvent offrir jusqu''à 90% de réduction.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Jusqu''à 90%',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Jusqu''à 50%',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Jusqu''à 30%',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Jusqu''à 10%',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-467') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='pricing___support' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-467',v_cert_id,v_theme_id,'Quel service AWS permet de gérer des pools d''instances Spot ?','hard','SINGLE_CHOICE','Plusieurs options pour gérer les instances Spot.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Spot Fleet',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','ASG avec mixed instances',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','EC2 Fleet',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-468') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='pricing___support' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-468',v_cert_id,v_theme_id,'Savings Plans s''applique-t-il à Lambda ?','hard','SINGLE_CHOICE','Savings Plans couvre EC2, Fargate et Lambda.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Oui',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Uniquement à EC2',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Uniquement à Fargate',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-469') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='pricing___support' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-469',v_cert_id,v_theme_id,'Quels sont les types de Savings Plans ?','hard','SINGLE_CHOICE','Trois types de Savings Plans.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Compute Savings Plans, EC2 Instance Savings Plans, SageMaker Savings Plans',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','EC2 seulement',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Lambda seulement',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Fargate seulement',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-470') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='pricing___support' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-470',v_cert_id,v_theme_id,'Quels services sont inclus dans le Free Tier ?','easy','SINGLE_CHOICE','Le Free Tier offre des limites sur plusieurs services.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','EC2 (750h), S3 (5GB), Lambda (1M requests), etc.',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Tous les services',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Aucun',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Seulement EC2',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-471') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='pricing___support' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-471',v_cert_id,v_theme_id,'Combien de temps dure le Free Tier ?','hard','SINGLE_CHOICE','Le Free Tier dure 12 mois pour les nouveaux comptes AWS.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','12 mois',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','6 mois',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','24 mois',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Toujours',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-472') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='pricing___support' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-472',v_cert_id,v_theme_id,'À quoi sert AWS Pricing Calculator ?','hard','SINGLE_CHOICE','Le calculateur aide à estimer les coûts des services.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Estimer les coûts avant de déployer',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Facturer les clients',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Gérer les budgets',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Suivre les dépenses',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-473') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='pricing___support' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-473',v_cert_id,v_theme_id,'À quoi sert AWS Cost Explorer ?','hard','SINGLE_CHOICE','Cost Explorer permet d''analyser les tendances des coûts.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Analyser les coûts passés et prévoir les futurs',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Facturer',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Budgéter',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Payer',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-474') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='pricing___support' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-474',v_cert_id,v_theme_id,'Les budgets AWS peuvent-ils déclencher des alarmes ?','hard','SINGLE_CHOICE','Les budgets peuvent envoyer des alertes SNS.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Oui',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Uniquement des notifications',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Uniquement des actions',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-475') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='pricing___support' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-475',v_cert_id,v_theme_id,'À quoi sert Cost Anomaly Detection ?','hard','SINGLE_CHOICE','Cost Anomaly Detection utilise ML pour identifier les anomalies.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Détecter les pics de dépenses inhabituels',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Prévoir les coûts',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Budgéter',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Optimiser',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-476') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='pricing___support' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-476',v_cert_id,v_theme_id,'Quels sont les plans de support AWS ?','easy','SINGLE_CHOICE','AWS propose quatre plans de support.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Basic, Developer, Business, Enterprise',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Basic seulement',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Premium seulement',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Standard, Premium',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-477') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='pricing___support' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-477',v_cert_id,v_theme_id,'Le plan Basic est-il gratuit ?','hard','SINGLE_CHOICE','Le plan Basic est inclus gratuitement.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Oui',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Uniquement pour les comptes de moins d''un an',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Uniquement pour les comptes éducatifs',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-478') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='pricing___support' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-478',v_cert_id,v_theme_id,'Quel plan supporte le Technical Account Manager (TAM) ?','hard','SINGLE_CHOICE','Le plan Enterprise inclut un TAM dédié.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Enterprise',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Business',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Developer',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Basic',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-479') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='pricing___support' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-479',v_cert_id,v_theme_id,'Quel plan offre un temps de réponse de 15 minutes pour les cas de production ?','hard','SINGLE_CHOICE','Enterprise offre une réponse critique en 15 minutes.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Enterprise',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Business',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Developer',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Basic',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-480') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='pricing___support' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-480',v_cert_id,v_theme_id,'Organizations permet-il une facturation consolidée ?','hard','SINGLE_CHOICE','Organizations consolide la facturation des comptes membres.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Oui',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Uniquement avec Control Tower',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Uniquement avec AWS Config',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-481') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='pricing___support' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-481',v_cert_id,v_theme_id,'Organizations permet-il des réductions sur les RI partagées ?','hard','SINGLE_CHOICE','Les RI et Savings Plans sont partagés entre les comptes de l''organisation.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Oui',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Uniquement pour les Savings Plans',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Uniquement pour les comptes master',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-482') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='pricing___support' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-482',v_cert_id,v_theme_id,'Comment réduire les coûts S3 ?','hard','SINGLE_CHOICE','Les lifecycle policies et le choix de classe de stockage réduisent les coûts.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Lifecycle policies, classes de stockage, compression',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Plus de réplication',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Plus de versions',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Chiffrement',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-483') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='pricing___support' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-483',v_cert_id,v_theme_id,'Comment réduire les coûts EC2 ?','hard','SINGLE_CHOICE','Utiliser des modèles de tarification économiques et ajuster la capacité.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','RI, Savings Plans, Spot, auto-scaling',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Plus d''instances',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Plus de mémoire',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Plus de CPU',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-484') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='pricing___support' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-484',v_cert_id,v_theme_id,'Qu''est-ce que le tagging pour les coûts ?','hard','SINGLE_CHOICE','Le tagging aide à analyser les coûts par projet, équipe, environnement.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Assigner des métadonnées pour attribuer les coûts',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Étiqueter les ressources',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Grouper les ressources',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-485') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='pricing___support' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-485',v_cert_id,v_theme_id,'À quoi sert Trusted Advisor pour les coûts ?','hard','SINGLE_CHOICE','Trusted Advisor recommande de supprimer les ressources inutilisées.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Identifier les ressources sous-utilisées',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Augmenter les coûts',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Facturer',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Budgéter',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-486') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='pricing___support' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-486',v_cert_id,v_theme_id,'Compute Optimizer aide-t-il à réduire les coûts ?','hard','SINGLE_CHOICE','Compute Optimizer recommande des types d''instance plus adaptés.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Oui',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Uniquement pour EC2',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Uniquement pour Lambda',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-487') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='pricing___support' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-487',v_cert_id,v_theme_id,'Storage Lens aide-t-il à optimiser les coûts S3 ?','hard','SINGLE_CHOICE','Storage Lens fournit des recommandations d''optimisation des coûts.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Oui',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Uniquement pour les métriques',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Uniquement pour la sécurité',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-488') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='pricing___support' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-488',v_cert_id,v_theme_id,'Comment réduire les coûts RDS ?','hard','SINGLE_CHOICE','RI, instances t3, et arrêt des environnements non productifs.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','RI, instances burstable, arrêt des dev',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Plus de réplicas',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Multi-AZ',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Backup',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-489') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='pricing___support' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-489',v_cert_id,v_theme_id,'Comment réduire les coûts Lambda ?','hard','SINGLE_CHOICE','Réduire la mémoire et le temps d''exécution baisse les coûts.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Ajuster la mémoire (CPU proportionnel)',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Provisioned concurrency',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Durée d''exécution',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A et C',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-490') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='pricing___support' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-490',v_cert_id,v_theme_id,'Le transfert de données entre services dans la même AZ est-il facturé ?','hard','SINGLE_CHOICE','Le trafic entre services dans la même AZ via IP privée est gratuit.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Non',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Oui',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Uniquement pour les grands volumes',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Uniquement pour les régions',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-491') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='pricing___support' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-491',v_cert_id,v_theme_id,'Le transfert de données sortant d''Internet est-il facturé ?','hard','SINGLE_CHOICE','Le trafic sortant vers Internet est facturé.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Oui',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Seulement au-delà d''un seuil',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Uniquement pour EC2',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-492') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='pricing___support' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-492',v_cert_id,v_theme_id,'Peut-on obtenir les prix AWS via API ?','hard','SINGLE_CHOICE','L''API AWS Price List permet d''obtenir les tarifs par programme.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Oui',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Uniquement via le console',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Uniquement via le calculateur',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-493') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='pricing___support' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-493',v_cert_id,v_theme_id,'À quoi sert AWS Billing Conductor ?','hard','SINGLE_CHOICE','Billing Conductor permet de regrouper et facturer des comptes internes.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Créer des factures personnalisées pour les clients internes',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Facturer AWS',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Budgéter',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Optimiser',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-494') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='pricing___support' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-494',v_cert_id,v_theme_id,'AWS Marketplace permet-il d''acheter des logiciels tiers ?','hard','SINGLE_CHOICE','Marketplace propose des AMI, SaaS, conteneurs, etc.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Oui',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Uniquement des AMI',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Uniquement des SaaS',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-495') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='pricing___support' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-495',v_cert_id,v_theme_id,'Quel est l''avantage des Savings Plans sur les RI ?','hard','SINGLE_CHOICE','Savings Plans sont plus flexibles que les RI.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Plus de flexibilité (famille d''instances, région, services)',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Plus de réduction',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Engagement plus court',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Aucun',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-496') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='pricing___support' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-496',v_cert_id,v_theme_id,'La facturation consolidée est-elle disponible sans Organizations ?','hard','SINGLE_CHOICE','La facturation consolidée nécessite AWS Organizations.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Non',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Oui',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Uniquement avec Control Tower',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Uniquement avec AWS Config',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-497') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='pricing___support' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-497',v_cert_id,v_theme_id,'Les crédits AWS peuvent-ils être appliqués à tous les services ?','hard','SINGLE_CHOICE','Certains services (ex: Marketplace) peuvent être exclus.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Oui',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Non, certains services exclus',TRUE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Uniquement EC2',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Uniquement S3',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-498') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='pricing___support' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-498',v_cert_id,v_theme_id,'À quoi sert AWS Activate ?','hard','SINGLE_CHOICE','AWS Activate offre des crédits et du support aux startups.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Crédits et support pour startups',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Facturation',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Budgéter',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Optimisation',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-499') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='pricing___support' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-499',v_cert_id,v_theme_id,'Quelle est la meilleure pratique pour suivre les coûts ?','hard','SINGLE_CHOICE','Combiner plusieurs outils pour une visibilité complète.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Tagging, budgets, alertes, Cost Explorer',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Ignorer les coûts',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Uniquement les factures',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Uniquement les RI',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-500') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='pricing___support' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AWS-SAA-500',v_cert_id,v_theme_id,'Comment éviter les surprises de facturation ?','hard','SINGLE_CHOICE','Configurer des budgets et des alarmes pour surveiller les coûts.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Budgets, alertes, analyse régulière',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Ne pas utiliser AWS',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Utiliser uniquement le Free Tier',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','RI seulement',FALSE,3);
    END IF;
END $$;
