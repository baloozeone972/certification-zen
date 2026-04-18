-- =============================================================================
-- V6k__seed_questions_pool_k.sql
-- CertifApp — Import pool questions (532 questions, az900, terraform certifications)
-- Idempotent : INSERT ... ON CONFLICT DO NOTHING
-- =============================================================================

-- ── AZ900 (272 questions) ──────
DO $$
DECLARE
    v_cert_id TEXT := 'az900';
    v_theme_id UUID; v_q_id UUID; v_opt_id UUID;
BEGIN
    IF NOT EXISTS (SELECT 1 FROM certifications WHERE id = v_cert_id) THEN
        RAISE NOTICE 'Certification % absente', v_cert_id; RETURN;
    END IF;
    INSERT INTO certification_themes (id, certification_id, code, label, question_count, display_order)
    VALUES (uuid_generate_v4(), v_cert_id, 'concepts_cloud', 'Concepts cloud', 0, 0)
    ON CONFLICT (certification_id, code) DO NOTHING;
    INSERT INTO certification_themes (id, certification_id, code, label, question_count, display_order)
    VALUES (uuid_generate_v4(), v_cert_id, 'azure_core', 'Azure Core', 0, 0)
    ON CONFLICT (certification_id, code) DO NOTHING;
    INSERT INTO certification_themes (id, certification_id, code, label, question_count, display_order)
    VALUES (uuid_generate_v4(), v_cert_id, 'azure_core_services', 'Azure Core Services', 0, 0)
    ON CONFLICT (certification_id, code) DO NOTHING;
    INSERT INTO certification_themes (id, certification_id, code, label, question_count, display_order)
    VALUES (uuid_generate_v4(), v_cert_id, 'security___compliance', 'Security & Compliance', 0, 0)
    ON CONFLICT (certification_id, code) DO NOTHING;
    INSERT INTO certification_themes (id, certification_id, code, label, question_count, display_order)
    VALUES (uuid_generate_v4(), v_cert_id, 'pricing___support', 'Pricing & Support', 0, 0)
    ON CONFLICT (certification_id, code) DO NOTHING;
    INSERT INTO certification_themes (id, certification_id, code, label, question_count, display_order)
    VALUES (uuid_generate_v4(), v_cert_id, 'azure_management_tools', 'Azure Management Tools', 0, 0)
    ON CONFLICT (certification_id, code) DO NOTHING;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ900-CC-001') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='concepts_cloud' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ900-CC-001',v_cert_id,v_theme_id,'Qu''est-ce que le cloud computing selon la définition de Microsoft ?','easy','SINGLE_CHOICE','Selon Microsoft, le cloud computing consiste à fournir des services informatiques via Internet. L''option B décrit un datacenter traditionnel sur site. L''option C décrit la virtualisation, une technologie sous‑jacente mais pas la définition du cloud. L''option D est une application cliente, non le cloud lui‑même.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','La fourniture de services informatiques (serveurs, stockage, bases de données, réseau, logiciels, analytique, intelligence) via Internet (« le cloud ») pour offrir une innovation plus rapide, des ressources flexibles et des économies d''échelle.',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Un ensemble de serveurs physiques localisés dans un datacenter unique et géré par une entreprise.',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Une technologie de virtualisation qui permet d''exécuter plusieurs systèmes d''exploitation sur une même machine physique.',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Un logiciel installé localement sur un ordinateur personnel pour gérer des fichiers en ligne.',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ900-CC-002') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='concepts_cloud' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ900-CC-002',v_cert_id,v_theme_id,'Dans le modèle IaaS (Infrastructure as a Service), quel composant est géré par le client ?','easy','SINGLE_CHOICE','En IaaS, le fournisseur cloud gère l''infrastructure physique (serveurs, réseau, stockage) et l''hyperviseur. Le client est responsable du système d''exploitation, des middlewares, des applications et des données.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Le système d''exploitation et les applications',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','L''hyperviseur et le matériel physique',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Le réseau physique et le stockage sous‑jacent',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','L''infrastructure du datacenter (alimentation, refroidissement)',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ900-CC-003') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='concepts_cloud' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ900-CC-003',v_cert_id,v_theme_id,'Sélectionnez TOUS les modèles de déploiement cloud reconnus.','easy','SINGLE_CHOICE','Les trois principaux modèles sont public, privé et hybride. Le cloud communautaire existe mais n''est pas un modèle standard universellement cité dans le cadre de l''AZ‑900. Le cloud exclusif n''est pas un terme officiel.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Cloud public',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Cloud privé',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Cloud hybride',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Cloud communautaire',FALSE,3);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'E','Cloud exclusif',FALSE,4);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ900-CC-004') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='concepts_cloud' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ900-CC-004',v_cert_id,v_theme_id,'Quels sont les avantages du cloud computing selon le modèle de consommation ? Sélectionnez TOUTES les affirmations correctes.','medium','SINGLE_CHOICE','Les avantages incluent la haute disponibilité, la scalabilité, l''élasticité et la tolérance de panne. L''option E est incorrecte : le cloud privilégie un modèle de dépenses opérationnelles (OpEx) plutôt que CapEx.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Haute disponibilité',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Scalabilité (verticale et horizontale)',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Élasticité',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Tolérance de panne et reprise après sinistre',FALSE,3);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'E','Modèle de dépenses d''investissement (CapEx) uniquement',FALSE,4);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ900-CC-005') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='concepts_cloud' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ900-CC-005',v_cert_id,v_theme_id,'Quelle est la principale différence entre scalabilité et élasticité dans le cloud ?','medium','SINGLE_CHOICE','La scalabilité permet d''augmenter les ressources (souvent manuellement ou selon un planning). L''élasticité ajoute une dimension automatique et dynamique pour répondre aux variations de charge instantanées.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','La scalabilité est la capacité à augmenter les ressources de manière planifiée, tandis que l''élasticité est la capacité à ajuster automatiquement les ressources en fonction de la charge en temps réel.',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','La scalabilité concerne le stockage, l''élasticité concerne le réseau.',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','La scalabilité est manuelle, l''élasticité est uniquement verticale.',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Il n''y a pas de différence ; les deux termes sont synonymes.',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ900-CC-006') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='concepts_cloud' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ900-CC-006',v_cert_id,v_theme_id,'Quelles sont les DEUX stratégies Azure qui contribuent à la haute disponibilité d''une application ?','hard','SINGLE_CHOICE','Les Availability Sets protègent contre les pannes matérielles et les mises à jour planifiées. Les Availability Zones protègent contre les pannes d''un datacenter entier. Le GRS (C) concerne la reprise d''activité (DR), pas la haute disponibilité au sens strict. Un seul VM (D) n''offre aucune redondance. Le groupe de ressources (E) n''a pas d''impact sur la disponibilité.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Déployer les ressources dans un groupe à haute disponibilité (Availability Set)',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Utiliser des zones de disponibilité (Availability Zones)',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Activer le stockage géo‑redondant (GRS) pour les sauvegardes',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Configurer une seule machine virtuelle avec un disque SSD Premium',FALSE,3);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'E','Utiliser un groupe de ressources unique pour toutes les ressources',FALSE,4);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ900-CC-007') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='concepts_cloud' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ900-CC-007',v_cert_id,v_theme_id,'Dans le modèle de responsabilité partagée, qui est responsable de la sécurité physique des datacenters Azure ?','hard','SINGLE_CHOICE','La sécurité physique (accès aux bâtiments, alimentation, refroidissement) relève toujours de la responsabilité du fournisseur cloud. Le client est responsable de la sécurité dans le cloud (données, identités, applications).','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Microsoft (le fournisseur cloud)',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Le client',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Un auditeur tiers',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Responsabilité conjointe',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ900-CC-008') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='concepts_cloud' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ900-CC-008',v_cert_id,v_theme_id,'Comment le cloud computing transforme‑t‑il généralement les dépenses informatiques ?','easy','SINGLE_CHOICE','Le cloud remplace les investissements initiaux lourds (CapEx) par un paiement à l''usage (OpEx).','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Il fait passer les dépenses d''un modèle CapEx (dépenses d''investissement) à un modèle OpEx (dépenses d''exploitation).',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Il augmente les dépenses CapEx car il faut acheter plus de matériel.',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Il supprime complètement toutes les dépenses OpEx.',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Il n''a aucun impact sur la structure des coûts.',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ900-CC-009') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='concepts_cloud' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ900-CC-009',v_cert_id,v_theme_id,'Quelles caractéristiques décrivent le cloud hybride ? Sélectionnez TOUTES les affirmations exactes.','medium','SINGLE_CHOICE','Le cloud hybride intègre au moins un cloud public et une infrastructure privée (A). Il permet de répondre à des besoins de conformité ou de latence (B). Une connectivité réseau est indispensable (C). Il n''est pas forcément moins cher (D), et diffère du cloud communautaire (E).','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Il combine un cloud public et un cloud privé ou une infrastructure sur site.',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Il permet de conserver des données sensibles sur site tout en profitant de l''élasticité du cloud public.',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Il nécessite une connexion entre les environnements (ex: VPN, ExpressRoute).',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Il est toujours moins cher qu''un cloud public pur.',FALSE,3);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'E','Il est identique au cloud communautaire.',FALSE,4);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ900-CC-010') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='concepts_cloud' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ900-CC-010',v_cert_id,v_theme_id,'Quel terme décrit le fait de ne payer que les ressources cloud effectivement utilisées, sans engagement à long terme ?','easy','SINGLE_CHOICE','Le modèle de consommation cloud standard est le paiement à l''usage. Les réservations (B) offrent des réductions contre un engagement.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Paiement à l''usage (Pay‑as‑you‑go)',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Réservation d''instance',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Licence perpétuelle',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Abonnement annuel obligatoire',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ900-CC-011') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='concepts_cloud' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ900-CC-011',v_cert_id,v_theme_id,'Parmi les services suivants, lesquels sont des exemples de SaaS (Software as a Service) ? Sélectionnez TOUTES les bonnes réponses.','medium','SINGLE_CHOICE','Microsoft 365 et Dynamics 365 sont des applications SaaS prêtes à l''emploi. Salesforce est également un SaaS. Azure Virtual Machines est IaaS, Azure SQL Database est PaaS.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Microsoft 365 (Office 365)',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Dynamics 365',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Azure Virtual Machines',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Azure SQL Database',FALSE,3);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'E','Salesforce',FALSE,4);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ900-CC-012') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='concepts_cloud' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ900-CC-012',v_cert_id,v_theme_id,'Dans un modèle PaaS, de quoi le client n''a‑t‑il PAS à se soucier ?','hard','SINGLE_CHOICE','En PaaS, le fournisseur gère le système d''exploitation, les serveurs, le stockage, le réseau. Le client garde la responsabilité de l''application et de ses données.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Du système d''exploitation et de l''infrastructure sous‑jacente',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Du code de l''application',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','De la configuration de l''application',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Des données stockées',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ900-CC-013') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='concepts_cloud' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ900-CC-013',v_cert_id,v_theme_id,'Qu''est‑ce qu''une région Azure ?','easy','SINGLE_CHOICE','Une région Azure contient un ou plusieurs datacenters proches géographiquement. Les PoP (B) sont pour le réseau CDN. Les zones de disponibilité (C) sont des entités physiquement séparées au sein d''une région.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Un ensemble de datacenters déployés dans un périmètre géographique défini, connectés par un réseau à faible latence.',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Un point de présence (PoP) pour la diffusion de contenu (CDN).',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Une zone de disponibilité au sein d''un datacenter.',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Un groupe de ressources logiques.',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ900-CC-014') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='concepts_cloud' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ900-CC-014',v_cert_id,v_theme_id,'Pourquoi Azure utilise‑t‑il des régions jumelées (paired regions) ? Sélectionnez TOUTES les raisons valides.','medium','SINGLE_CHOICE','Les régions jumelées sont séparées d''au moins 300 miles pour assurer la continuité d''activité. Elles servent à la réplication asynchrone (A), à la priorisation des mises à jour (B) et à la reprise après sinistre (E). La latence entre régions jumelées n''est pas réduite (elles sont éloignées) et la résidence des données (D) est garantie au sein d''une même géographie, pas nécessairement par le jumelage.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Pour permettre la réplication asynchrone des données pour la reprise d''activité.',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Pour garantir qu''au moins une région du couple reste disponible pendant les maintenances planifiées.',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Pour réduire la latence réseau entre les continents.',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Pour respecter les exigences de résidence des données.',FALSE,3);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'E','Pour fournir une redondance en cas de sinistre régional majeur.',FALSE,4);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ900-CC-015') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='concepts_cloud' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ900-CC-015',v_cert_id,v_theme_id,'Quelle affirmation concernant les zones de disponibilité est exacte ?','hard','SINGLE_CHOICE','Une zone de disponibilité est un ou plusieurs datacenters indépendants au sein d''une région (A). Toutes les régions ne proposent pas de zones de disponibilité (B, C faux). Les régions jumelées sont distinctes (D).','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Une zone de disponibilité est un emplacement physique unique avec ses propres alimentation, réseau et refroidissement.',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Chaque région Azure possède au moins trois zones de disponibilité.',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Les zones de disponibilité sont disponibles dans toutes les régions Azure.',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Une zone de disponibilité est synonyme de région jumelée.',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ900-CC-016') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='concepts_cloud' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ900-CC-016',v_cert_id,v_theme_id,'Qu''est‑ce qu''un groupe de ressources Azure ?','easy','SINGLE_CHOICE','Un groupe de ressources est un conteneur logique utilisé pour gérer et organiser les ressources Azure (VM, comptes de stockage, bases de données, etc.).','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Un conteneur logique qui regroupe des ressources Azure partageant le même cycle de vie.',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Un ensemble de machines virtuelles identiques pour la mise à l''échelle.',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Une collection d''utilisateurs et de leurs permissions.',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Un groupe de sécurité pour le filtrage réseau.',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ900-CC-017') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='concepts_cloud' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ900-CC-017',v_cert_id,v_theme_id,'Quel rôle joue un abonnement Azure ? Sélectionnez TOUTES les affirmations correctes.','medium','SINGLE_CHOICE','Un abonnement est une unité de facturation (A), il a des quotas (B), il contient des groupes de ressources (C) et est lié à un compte de facturation (D). Plusieurs abonnements peuvent partager le même locataire Azure AD (E faux).','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Il sert de limite de facturation pour les ressources Azure.',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Il définit les limites de quota pour certains services (ex: nombre de VM).',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Il contient un ou plusieurs groupes de ressources.',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Il peut être associé à un compte de facturation unique.',FALSE,3);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'E','Il est obligatoirement lié à un locataire Azure AD différent pour chaque abonnement.',FALSE,4);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ900-CC-018') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='concepts_cloud' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ900-CC-018',v_cert_id,v_theme_id,'Quelle est la hiérarchie correcte des étendues de gestion dans Azure (du plus haut niveau au plus bas) ?','hard','SINGLE_CHOICE','La hiérarchie est : Management Group (facultatif) → Subscription → Resource Group → Resource.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Groupe d''administration → Abonnement → Groupe de ressources → Ressource',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Abonnement → Groupe d''administration → Groupe de ressources → Ressource',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Groupe de ressources → Abonnement → Groupe d''administration → Ressource',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Ressource → Groupe de ressources → Abonnement → Groupe d''administration',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ900-CC-019') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='concepts_cloud' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ900-CC-019',v_cert_id,v_theme_id,'Quelle est la fonction principale d''Azure Resource Manager (ARM) ?','medium','SINGLE_CHOICE','ARM est la couche de gestion qui traite les demandes provenant du portail, de PowerShell, de la CLI ou des SDK.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','C''est le service de déploiement et de gestion pour Azure, qui permet de créer, mettre à jour et supprimer des ressources de manière cohérente.',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','C''est un outil de surveillance des performances des machines virtuelles.',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','C''est le portail web pour accéder aux services Azure.',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','C''est le système d''authentification unique d''Azure.',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ900-CC-020') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='concepts_cloud' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ900-CC-020',v_cert_id,v_theme_id,'Quels facteurs influencent généralement le coût d''une machine virtuelle Azure ? Sélectionnez TOUTES les réponses exactes.','hard','SINGLE_CHOICE','Tous ces éléments impactent le coût d''une VM Azure. Le type de licence du système d''exploitation (E) est particulièrement notable car Windows inclut une licence.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','La taille de la VM (vCPU, RAM)',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','La région de déploiement',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Le type de disque utilisé (HDD, SSD, Premium SSD)',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','La bande passante réseau sortante',FALSE,3);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'E','Le système d''exploitation invité (Windows est généralement plus cher que Linux)',FALSE,4);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ900-CC-021') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='concepts_cloud' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ900-CC-021',v_cert_id,v_theme_id,'Quel outil Azure permet d''estimer le coût mensuel des services que vous envisagez d''utiliser ?','easy','SINGLE_CHOICE','La calculatrice de prix (A) estime les coûts futurs. La calculatrice TCO (B) compare les coûts sur site vs cloud. Azure Cost Management (C) analyse les dépenses réelles. Azure Advisor (D) donne des recommandations d''optimisation.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Calculatrice de prix Azure',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Calculatrice de coût total de possession (TCO)',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Azure Cost Management',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Azure Advisor',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ900-CC-022') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='concepts_cloud' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ900-CC-022',v_cert_id,v_theme_id,'À quoi sert la calculatrice de coût total de possession (TCO) d''Azure ?','medium','SINGLE_CHOICE','La TCO calculator aide à estimer les économies potentielles en migrant vers Azure en comparant les coûts totaux (électricité, matériel, licences, main d''œuvre).','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Comparer les coûts d''une infrastructure sur site avec ceux d''une solution équivalente sur Azure.',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Calculer le prix exact d''une machine virtuelle sur 3 ans.',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Générer un devis pour un engagement de consommation (MACC).',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Estimer les économies réalisées grâce aux instances réservées.',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ900-CC-023') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='concepts_cloud' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ900-CC-023',v_cert_id,v_theme_id,'Quelles actions peut‑on réaliser avec Azure Cost Management ? Sélectionnez TOUTES les affirmations correctes.','hard','SINGLE_CHOICE','Cost Management permet l''analyse (A), les budgets (B), l''export (C) et les recommandations (E). La modification automatique (D) n''est pas une fonctionnalité native de Cost Management (cela relève de l''autoscaling ou d''Azure Automation).','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Analyser les dépenses par service, par abonnement ou par balise (tag).',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Configurer des budgets et des alertes de dépassement.',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Exporter les données de coût vers un compte de stockage pour analyse personnalisée.',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Modifier automatiquement la taille des VM pour réduire les coûts.',FALSE,3);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'E','Voir les recommandations d''optimisation des coûts (ex: ressources inutilisées).',FALSE,4);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ900-CC-024') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='concepts_cloud' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ900-CC-024',v_cert_id,v_theme_id,'Quels sont les usages recommandés des balises (tags) dans Azure ? Sélectionnez TOUTES les propositions valides.','medium','SINGLE_CHOICE','Les balises servent à la catégorisation (A), au suivi des coûts (C) et à l''identification de l''environnement (E). Les permissions RBAC (B) se gèrent via les rôles, pas les balises. L''automatisation (D) peut s''appuyer sur des balises mais ce n''est pas une fonction native de la balise elle‑même.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Catégoriser les ressources par département ou projet.',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Attribuer des permissions RBAC directement via la balise.',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Suivre les coûts par centre de coût.',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Automatiser l''arrêt des ressources le week‑end.',FALSE,3);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'E','Identifier l''environnement (production, développement, test).',FALSE,4);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ900-CC-025') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='concepts_cloud' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ900-CC-025',v_cert_id,v_theme_id,'Que garantit un contrat de niveau de service (SLA) Microsoft Azure ?','medium','SINGLE_CHOICE','Le SLA définit le pourcentage de disponibilité garanti. Il prévoit généralement un crédit de service en cas de non‑respect, mais pas un remboursement intégral (C).','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','La disponibilité minimale d''un service (ex: 99,9 % de temps de fonctionnement).',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','La sécurité absolue des données contre toute cyberattaque.',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Un remboursement intégral en cas de panne.',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Une performance constante du réseau sans latence.',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ900-CC-026') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='concepts_cloud' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ900-CC-026',v_cert_id,v_theme_id,'Si une application dépend de deux services Azure ayant chacun un SLA de 99,9 %, quel est le SLA composite théorique de l''application ?','hard','SINGLE_CHOICE','Le SLA composite se calcule en multipliant les disponibilités : 0,999 * 0,999 = 0,998001, soit environ 99,8 %. Le SLA global est inférieur au SLA individuel le plus bas.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','99,8 %',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','99,9 %',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','99,99 %',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','100 %',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ900-CC-027') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='concepts_cloud' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ900-CC-027',v_cert_id,v_theme_id,'Que comprend le compte gratuit Azure (Azure free account) ? Sélectionnez TOUTES les affirmations exactes.','easy','SINGLE_CHOICE','Le compte gratuit inclut un crédit initial (A), des services gratuits 12 mois (B) et des services toujours gratuits (C). Le support technique de base est gratuit, mais pas le support 24/7 (D). Une carte bancaire est requise pour vérification (E).','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Un crédit de 200 $ à dépenser dans les 30 premiers jours.',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','L''accès à certains services gratuits pendant 12 mois.',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Un accès permanent à plus de 55 services toujours gratuits.',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Un support technique 24h/24 et 7j/7 inclus.',FALSE,3);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'E','Aucune obligation de carte bancaire à l''inscription.',FALSE,4);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ900-CC-028') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='concepts_cloud' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ900-CC-028',v_cert_id,v_theme_id,'Qu''est‑ce que l''Azure Marketplace ?','easy','SINGLE_CHOICE','L''Azure Marketplace permet de déployer facilement des solutions pré‑configurées (ex: WordPress, appliances virtuelles, services managés tiers).','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Un magasin en ligne proposant des applications et services certifiés pour s''exécuter sur Azure (de Microsoft et de partenaires tiers).',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Le portail de gestion des abonnements Azure.',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Un outil de comparaison des prix entre fournisseurs cloud.',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Le forum communautaire officiel d''Azure.',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ900-CC-029') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='concepts_cloud' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ900-CC-029',v_cert_id,v_theme_id,'Quels plans de support Azure offrent un accès à un gestionnaire technique de compte (Technical Account Manager - TAM) ? Sélectionnez TOUTES les réponses correctes.','medium','SINGLE_CHOICE','Le support Professional Direct et le support Premier/Unified incluent un TAM ou un contact dédié. Les plans Standard et Développeur n''en ont pas.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Support Professionnel Direct',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Support Standard',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Support Développeur',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Support de base (gratuit)',FALSE,3);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'E','Support Premier / Unified',FALSE,4);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ900-CC-030') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='concepts_cloud' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ900-CC-030',v_cert_id,v_theme_id,'Dans quelle catégorie de recommandations Azure Advisor peut‑on trouver des conseils pour réduire les coûts ?','medium','SINGLE_CHOICE','Azure Advisor fournit des recommandations dans cinq catégories : Coût, Sécurité, Fiabilité, Performance opérationnelle et Excellence opérationnelle.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Coût',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Sécurité',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Fiabilité',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Performance',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ900-CC-031') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='concepts_cloud' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ900-CC-031',v_cert_id,v_theme_id,'Vous souhaitez déployer 200 machines virtuelles dans une région, mais vous recevez une erreur indiquant que le quota est dépassé. Quelle action devez‑vous entreprendre ?','hard','SINGLE_CHOICE','Les quotas sont des limites par abonnement et par région. On peut demander une augmentation de quota (gratuitement) via une demande de support.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Créer une demande d''augmentation de quota via le portail Azure.',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Supprimer l''abonnement et en créer un nouveau.',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Utiliser une autre région, car les quotas sont globaux.',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Passer à un compte de support payant pour débloquer automatiquement le quota.',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ900-CC-032') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='concepts_cloud' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ900-CC-032',v_cert_id,v_theme_id,'Quelles caractéristiques s''appliquent aux services Azure en préversion publique ? Sélectionnez TOUTES les réponses correctes.','medium','SINGLE_CHOICE','Les préversions publiques sont ouvertes à tous, sans SLA (A), peuvent évoluer (B) et sont souvent à prix réduit (C). Le support n''est pas garanti au niveau GA (D faux). Les préversions privées (E) nécessitent une inscription sur invitation, pas les préversions publiques.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Ils peuvent être utilisés en production sans accord spécifique, mais sans garantie de SLA.',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Ils peuvent faire l''objet de modifications importantes avant la disponibilité générale.',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Leur tarification est généralement réduite ou gratuite.',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Le support technique complet est inclus comme pour les services GA.',FALSE,3);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'E','Ils ne sont accessibles qu''aux clients ayant signé un NDA.',FALSE,4);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ900-CC-033') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='concepts_cloud' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ900-CC-033',v_cert_id,v_theme_id,'Que signifie la résidence des données dans le contexte d''Azure ?','hard','SINGLE_CHOICE','Microsoft s''engage à ne pas déplacer les données client hors de la géographie choisie sans consentement, sauf pour certains services de support ou exigences légales. La réplication mondiale (B) n''est pas automatique.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Les données client restent stockées dans la région géographique choisie, sauf autorisation explicite.',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Les données sont automatiquement répliquées dans le monde entier pour améliorer les performances.',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Les données sont chiffrées uniquement au repos dans la région d''origine.',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Les données ne peuvent pas être déplacées vers une autre région, même pour une reprise d''activité.',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ900-CC-034') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='concepts_cloud' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ900-CC-034',v_cert_id,v_theme_id,'Quel est le principal cas d''usage d''Azure Lighthouse ?','hard','SINGLE_CHOICE','Azure Lighthouse permet la gestion multi‑locataire (A) via une délégation sécurisée des abonnements (D). Il n''unifie pas les coûts de plusieurs locataires indépendants sans configuration (B faux). Ce n''est pas un outil de déploiement (C) ni de sécurité centralisée native (E) bien qu''il facilite la gestion de la sécurité.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Permettre à un fournisseur de services managés de gérer les abonnements de ses clients à grande échelle.',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Fournir une vue unifiée des coûts pour plusieurs locataires Azure AD.',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Automatiser le déploiement de modèles ARM entre régions.',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Activer la délégation d''accès sécurisée sans partage de comptes utilisateurs.',FALSE,3);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'E','Surveiller la sécurité de toutes les ressources Azure en un seul endroit.',FALSE,4);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ900-CC-035') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='concepts_cloud' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ900-CC-035',v_cert_id,v_theme_id,'Où peut‑on trouver la liste des certifications de conformité obtenues par Azure (ex: ISO 27001, SOC, HDS) ?','medium','SINGLE_CHOICE','Le Microsoft Trust Center répertorie toutes les offres de conformité, certifications et rapports d''audit. Le portail Azure contient le gestionnaire de conformité (Compliance Manager) mais la liste exhaustive est au Trust Center.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Centre de gestion de la confidentialité Microsoft (Microsoft Trust Center)',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Portail Azure dans la section « Conformité »',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Documentation officielle du service spécifique',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Azure Advisor',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ900-CC-036') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='concepts_cloud' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ900-CC-036',v_cert_id,v_theme_id,'Quels composants peut‑on inclure dans un blueprint Azure ? Sélectionnez TOUTES les réponses valides.','hard','SINGLE_CHOICE','Un blueprint peut contenir des artefacts de type RBAC (A), Policy (B), modèles ARM (C) et groupes de ressources (D). Les applications logiques (E) seraient déployées via un modèle ARM, pas comme artefact distinct.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Attributions de rôles RBAC',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Définitions Azure Policy',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Modèles ARM (Azure Resource Manager)',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Groupes de ressources',FALSE,3);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'E','Applications logiques pré‑configurées',FALSE,4);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ900-CC-037') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='concepts_cloud' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ900-CC-037',v_cert_id,v_theme_id,'Quelle est la fonction d''Azure Arc ?','hard','SINGLE_CHOICE','Azure Arc permet de projeter des serveurs physiques, des VM ou des clusters Kubernetes hors Azure dans Azure Resource Manager, et d''y appliquer des politiques, de la surveillance, etc.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Étendre la gestion et les services Azure à des infrastructures en dehors d''Azure (sur site, autres clouds).',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Créer des connexions réseau privées entre sites distants.',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Générer des graphiques de dépendances entre ressources.',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Fournir une interface en ligne de commande unifiée pour tous les clouds.',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ900-CC-038') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='concepts_cloud' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ900-CC-038',v_cert_id,v_theme_id,'Pourquoi le cloud est‑il particulièrement adapté aux startups ? Sélectionnez TOUS les avantages pertinents.','easy','SINGLE_CHOICE','Le modèle OpEx (A), l''élasticité (B) et l''accès à des services managés (C) sont des atouts majeurs. Les contrats de support (D) ne sont pas obligatoires. La dépendance (E) est un risque, pas un avantage.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Pas d''investissement initial lourd en matériel.',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Possibilité de faire évoluer les ressources rapidement avec la croissance.',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Accès à des technologies avancées (IA, Big Data) sans expertise interne poussée.',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Contrats de support obligatoires pour toutes les ressources.',FALSE,3);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'E','Dépendance à un fournisseur unique impossible à éviter.',FALSE,4);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ900-CC-039') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='concepts_cloud' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ900-CC-039',v_cert_id,v_theme_id,'Quel engagement Microsoft a‑t‑il pris concernant l''impact environnemental de ses datacenters Azure ?','medium','SINGLE_CHOICE','Microsoft vise la neutralité carbone depuis 2012, mais l''engagement actuel est d''être négatif en carbone d''ici 2030. L''utilisation d''énergies renouvelables est en croissance mais pas encore à 100% (objectif 2025).','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Être négatif en carbone d''ici 2030 et avoir éliminé toute la dette carbone historique d''ici 2050.',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Utiliser exclusivement des énergies renouvelables pour tous les datacenters depuis 2020.',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Compenser les émissions de carbone par des crédits carbone volontaires.',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Ne plus construire de nouveaux datacenters après 2025.',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ900-CC-040') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='concepts_cloud' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ900-CC-040',v_cert_id,v_theme_id,'Quelle stratégie de migration cloud consiste à redévelopper entièrement une application pour tirer parti des fonctionnalités natives du cloud ?','hard','SINGLE_CHOICE','La refactorisation implique de modifier l''application pour utiliser des services PaaS (ex: passer de VM à App Service). Le réhébergement (B) est le simple déplacement sans modification. Le replatforming (C) est une modification mineure (ex: utiliser un service managé de base de données). Le retirement (D) est l''arrêt de l''application.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Refactorisation (ou Re‑architecting)',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Réhébergement (Lift and Shift)',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Replatforming',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Retirement',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-01-001') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='azure_core' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ-01-001',v_cert_id,v_theme_id,'Quel service Azure est équivalent à AWS EC2 (machines virtuelles) ?','easy','SINGLE_CHOICE','Azure Virtual Machines est le service d''IaaS pour les VMs.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Azure Virtual Machines',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Azure Functions',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Azure App Service',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Azure Kubernetes',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-01-002') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='azure_core' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ-01-002',v_cert_id,v_theme_id,'Quel service Azure est serverless pour exécuter du code ?','easy','SINGLE_CHOICE','Azure Functions est le service serverless (Function as a Service).','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Azure Functions',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Azure VMs',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Azure App Service',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Azure Container Instances',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-900-021') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='azure_core_services' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ-900-021',v_cert_id,v_theme_id,'Quel service Azure permet de créer des machines virtuelles ?','easy','SINGLE_CHOICE','Azure Virtual Machines est le service IaaS pour les VMs.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Azure Virtual Machines',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Azure App Service',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Azure Functions',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Azure Container Instances',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-900-022') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='azure_core_services' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ-900-022',v_cert_id,v_theme_id,'Quel service Azure est un PaaS pour héberger des applications web ?','easy','SINGLE_CHOICE','Azure App Service héberge des applications web, API, mobile backends.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Azure App Service',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Azure Virtual Machines',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Azure Functions',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Azure Kubernetes Service',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-900-023') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='azure_core_services' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ-900-023',v_cert_id,v_theme_id,'Quel service Azure est serverless pour exécuter du code ?','easy','SINGLE_CHOICE','Azure Functions est le service serverless (Function as a Service).','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Azure Functions',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Azure App Service',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Azure Logic Apps',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Azure Batch',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-900-024') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='azure_core_services' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ-900-024',v_cert_id,v_theme_id,'Quel service Azure orchestre des conteneurs Docker ?','easy','SINGLE_CHOICE','AKS est le service Kubernetes managé d''Azure.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Azure Kubernetes Service (AKS)',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Azure Container Instances',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Azure Container Registry',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Azure Functions',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-900-025') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='azure_core_services' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ-900-025',v_cert_id,v_theme_id,'Quel service Azure exécute des conteneurs sans gestion de serveurs ?','easy','SINGLE_CHOICE','ACI (Azure Container Instances) est serverless pour les conteneurs.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Azure Container Instances',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Azure Kubernetes Service',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Azure App Service',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Azure Functions',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-900-026') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='azure_core_services' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ-900-026',v_cert_id,v_theme_id,'Quel service Azure stocke les images Docker ?','easy','SINGLE_CHOICE','ACR (Azure Container Registry) stocke les images conteneur.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Azure Container Registry',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Azure Storage',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Azure Container Instances',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Azure Kubernetes Service',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-900-027') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='azure_core_services' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ-900-027',v_cert_id,v_theme_id,'Quel service Azure permet de créer des batch jobs ?','easy','SINGLE_CHOICE','Azure Batch exécute des jobs de calcul parallèles à grande échelle.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Azure Batch',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Azure Functions',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Azure Logic Apps',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Azure Automation',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-900-028') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='azure_core_services' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ-900-028',v_cert_id,v_theme_id,'Quel service Azure est le stockage objet ?','easy','SINGLE_CHOICE','Blob Storage est le stockage objet pour les données non structurées.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Azure Blob Storage',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Azure Files',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Azure Queue Storage',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Azure Table Storage',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-900-029') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='azure_core_services' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ-900-029',v_cert_id,v_theme_id,'Quel service Azure est un partage de fichiers SMB ?','easy','SINGLE_CHOICE','Azure Files fournit des partages de fichiers SMB accessibles depuis le cloud ou on-premise.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Azure Files',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Azure Blob Storage',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Azure Disk Storage',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Azure NetApp Files',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-900-030') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='azure_core_services' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ-900-030',v_cert_id,v_theme_id,'Quel service Azure est une file d''attente de messages ?','easy','SINGLE_CHOICE','Queue Storage est une file d''attente simple pour les messages.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Azure Queue Storage',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Azure Service Bus',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Azure Event Hubs',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Azure Notification Hubs',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-900-031') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='azure_core_services' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ-900-031',v_cert_id,v_theme_id,'Quel service Azure est une base NoSQL clé-valeur ?','easy','SINGLE_CHOICE','Table Storage est une base NoSQL clé-valeur.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Azure Table Storage',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Azure Cosmos DB',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Azure SQL Database',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Azure Cache for Redis',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-900-032') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='azure_core_services' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ-900-032',v_cert_id,v_theme_id,'Quel service Azure est un disque managé pour VMs ?','easy','SINGLE_CHOICE','Disk Storage fournit des volumes de stockage bloc pour les VMs.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Azure Disk Storage',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Azure Blob Storage',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Azure Files',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Azure NetApp Files',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-900-033') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='azure_core_services' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ-900-033',v_cert_id,v_theme_id,'Quel service Azure est une base de données relationnelle managée ?','easy','SINGLE_CHOICE','Azure SQL Database est le service de base SQL managé.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Azure SQL Database',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Azure Cosmos DB',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Azure Database for MySQL',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Azure Database for PostgreSQL',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-900-034') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='azure_core_services' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ-900-034',v_cert_id,v_theme_id,'Quel service Azure est une base de données NoSQL globale ?','easy','SINGLE_CHOICE','Cosmos DB est une base NoSQL distribuée globalement.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Azure Cosmos DB',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Azure SQL Database',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Azure Table Storage',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Azure Database for MongoDB',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-900-035') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='azure_core_services' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ-900-035',v_cert_id,v_theme_id,'Azure Cosmos DB supporte-t-il plusieurs API ?','easy','SINGLE_CHOICE','Cosmos DB supporte plusieurs API pour la compatibilité.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Oui (SQL, MongoDB, Cassandra, Gremlin, Table)',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Uniquement SQL',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Uniquement MongoDB',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-900-036') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='azure_core_services' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ-900-036',v_cert_id,v_theme_id,'Quel service Azure est un cache in-memory ?','easy','SINGLE_CHOICE','Azure Cache for Redis est un cache in-memory managé.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Azure Cache for Redis',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Azure Cosmos DB',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Azure SQL Database',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Azure Table Storage',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-900-037') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='azure_core_services' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ-900-037',v_cert_id,v_theme_id,'Quel service Azure est un réseau virtuel privé ?','easy','SINGLE_CHOICE','VNet est le réseau virtuel isolé dans Azure.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Azure Virtual Network (VNet)',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Azure VPN Gateway',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Azure ExpressRoute',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Azure Load Balancer',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-900-038') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='azure_core_services' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ-900-038',v_cert_id,v_theme_id,'Quel service Azure connecte un réseau on-premise à Azure via VPN ?','easy','SINGLE_CHOICE','VPN Gateway connecte via IPSec/VPN.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Azure VPN Gateway',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Azure ExpressRoute',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Azure Virtual WAN',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Azure Load Balancer',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-900-039') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='azure_core_services' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ-900-039',v_cert_id,v_theme_id,'Quel service Azure connecte un réseau on-premise à Azure via connexion privée dédiée ?','easy','SINGLE_CHOICE','ExpressRoute est une connexion privée et dédiée.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Azure ExpressRoute',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Azure VPN Gateway',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Azure Virtual WAN',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Azure Private Link',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-900-040') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='azure_core_services' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ-900-040',v_cert_id,v_theme_id,'Quel service Azure est un CDN ?','easy','SINGLE_CHOICE','Azure CDN est le service de diffusion de contenu.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Azure CDN',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Azure Front Door',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Azure Traffic Manager',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Azure Application Gateway',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-900-041') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='azure_core_services' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ-900-041',v_cert_id,v_theme_id,'Quel service Azure est un load balancer de couche 7 ?','easy','SINGLE_CHOICE','Application Gateway est un load balancer de couche 7 (HTTP/HTTPS).','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Azure Application Gateway',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Azure Load Balancer',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Azure Traffic Manager',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Azure Front Door',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-900-042') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='azure_core_services' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ-900-042',v_cert_id,v_theme_id,'Quel service Azure est un load balancer de couche 4 ?','easy','SINGLE_CHOICE','Azure Load Balancer est un load balancer de couche 4 (TCP/UDP).','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Azure Load Balancer',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Azure Application Gateway',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Azure Traffic Manager',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Azure Front Door',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-900-043') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='azure_core_services' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ-900-043',v_cert_id,v_theme_id,'Quel service Azure dirige le trafic DNS vers le point de terminaison le plus proche ?','easy','SINGLE_CHOICE','Traffic Manager utilise le DNS pour le routage global.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Azure Traffic Manager',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Azure Front Door',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Azure Load Balancer',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Azure Application Gateway',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-900-044') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='azure_core_services' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ-900-044',v_cert_id,v_theme_id,'Quel service Azure protège les applications web (WAF) ?','easy','SINGLE_CHOICE','Application Gateway inclut un WAF.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Azure Application Gateway (avec WAF)',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Azure Firewall',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Azure DDoS Protection',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Azure Front Door',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-900-045') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='azure_core_services' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ-900-045',v_cert_id,v_theme_id,'Quel service Azure est le service d''annuaire et de gestion des identités ?','easy','SINGLE_CHOICE','Azure AD est le service d''annuaire pour les identités.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Azure Active Directory (Azure AD)',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Azure AD B2C',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Azure AD Domain Services',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Azure Identity Protection',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-900-046') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='azure_core_services' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ-900-046',v_cert_id,v_theme_id,'Quel service Azure permet l''authentification des clients (B2C) ?','easy','SINGLE_CHOICE','Azure AD B2C est pour l''authentification des clients (Consumer).','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Azure AD B2C',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Azure AD',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Azure AD Domain Services',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Azure AD Identity Protection',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-900-047') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='azure_core_services' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ-900-047',v_cert_id,v_theme_id,'Quel service Azure fournit des services de domaine managés ?','easy','SINGLE_CHOICE','Azure AD DS fournit des services de domaine comme LDAP, Kerberos.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Azure AD Domain Services',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Azure AD',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Azure AD B2C',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Azure AD Identity Protection',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-900-048') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='azure_core_services' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ-900-048',v_cert_id,v_theme_id,'Quel service Azure permet l''Infrastructure as Code (IaC) ?','easy','SINGLE_CHOICE','ARM templates sont des modèles JSON pour déployer l''infrastructure.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Azure Resource Manager (ARM) templates',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Azure CLI',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Azure PowerShell',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Azure Portal',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-900-049') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='azure_core_services' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ-900-049',v_cert_id,v_theme_id,'Quel service Azure est un outil de gestion de configuration ?','easy','SINGLE_CHOICE','Azure Automation permet l''automatisation des tâches et la gestion de configuration.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Azure Automation',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Azure Policy',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Azure Blueprints',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Azure Resource Graph',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-900-050') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='azure_core_services' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ-900-050',v_cert_id,v_theme_id,'Quel service Azure applique des règles de conformité aux ressources ?','easy','SINGLE_CHOICE','Azure Policy évalue et applique des règles de conformité.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Azure Policy',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Azure Blueprints',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Azure Automation',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Azure Resource Manager',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-900-051') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='azure_core_services' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ-900-051',v_cert_id,v_theme_id,'Quel service Azure définit un ensemble réutilisable de ressources ?','easy','SINGLE_CHOICE','Blueprints permettent de définir et déployer un ensemble de ressources conformes.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Azure Blueprints',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Azure Policy',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Azure Automation',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Azure Resource Manager',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-900-052') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='azure_core_services' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ-900-052',v_cert_id,v_theme_id,'Quel service Azure collecte les métriques et les logs ?','easy','SINGLE_CHOICE','Azure Monitor centralise les données de monitoring.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Azure Monitor',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Azure Log Analytics',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Azure Application Insights',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Azure Advisor',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-900-053') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='azure_core_services' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ-900-053',v_cert_id,v_theme_id,'Quel service Azure surveille les performances des applications ?','easy','SINGLE_CHOICE','Application Insights est pour l''APM (Application Performance Monitoring).','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Azure Application Insights',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Azure Monitor',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Azure Log Analytics',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Azure Advisor',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-900-054') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='azure_core_services' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ-900-054',v_cert_id,v_theme_id,'Quel service Azure interroge les données de logs ?','easy','SINGLE_CHOICE','Log Analytics permet d''interroger les logs avec le langage KQL.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Azure Log Analytics',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Azure Monitor',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Azure Application Insights',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Azure Advisor',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-900-055') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='azure_core_services' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ-900-055',v_cert_id,v_theme_id,'Quel service Azure est un bus de messages enterprise ?','easy','SINGLE_CHOICE','Service Bus est un broker de messages (queue, topic, relay).','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Azure Service Bus',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Azure Event Hubs',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Azure Queue Storage',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Azure Event Grid',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-900-056') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='azure_core_services' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ-900-056',v_cert_id,v_theme_id,'Quel service Azure ingère des événements massifs (IoT) ?','easy','SINGLE_CHOICE','Event Hubs est pour l''ingestion de millions d''événements par seconde.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Azure Event Hubs',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Azure Service Bus',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Azure Event Grid',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Azure IoT Hub',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-900-057') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='azure_core_services' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ-900-057',v_cert_id,v_theme_id,'Quel service Azure distribue des événements de manière réactive ?','easy','SINGLE_CHOICE','Event Grid distribue des événements à des abonnés.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Azure Event Grid',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Azure Event Hubs',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Azure Service Bus',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Azure Queue Storage',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-900-058') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='azure_core_services' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ-900-058',v_cert_id,v_theme_id,'Quel service Azure est un outil d''intégration low-code ?','easy','SINGLE_CHOICE','Logic Apps permet de créer des workflows d''intégration visuellement.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Azure Logic Apps',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Azure Functions',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Azure API Management',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Azure Service Bus',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-900-059') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='azure_core_services' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ-900-059',v_cert_id,v_theme_id,'Quel service Azure gère les API ?','easy','SINGLE_CHOICE','API Management publie, sécurise et analyse les API.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Azure API Management',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Azure Logic Apps',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Azure Functions',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Azure App Service',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-900-060') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='azure_core_services' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ-900-060',v_cert_id,v_theme_id,'Quel service Azure connecte et gère les appareils IoT ?','easy','SINGLE_CHOICE','IoT Hub est le service central pour la communication IoT.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Azure IoT Hub',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Azure Event Hubs',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Azure IoT Central',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Azure Sphere',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-900-061') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='azure_core_services' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ-900-061',v_cert_id,v_theme_id,'Quel service Azure est une plateforme IoT entièrement managée ?','easy','SINGLE_CHOICE','IoT Central est une plateforme SaaS pour les solutions IoT.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Azure IoT Central',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Azure IoT Hub',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Azure IoT Edge',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Azure Sphere',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-900-062') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='azure_core_services' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ-900-062',v_cert_id,v_theme_id,'Quel service Azure est une plateforme de machine learning ?','easy','SINGLE_CHOICE','Azure Machine Learning est pour l''entraînement et le déploiement de modèles ML.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Azure Machine Learning',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Azure Cognitive Services',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Azure Databricks',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Azure Bot Service',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-900-063') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='azure_core_services' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ-900-063',v_cert_id,v_theme_id,'Quel service Azure fournit des API pré-entraînées (vision, langage, etc.) ?','easy','SINGLE_CHOICE','Cognitive Services offre des API IA prêtes à l''emploi.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Azure Cognitive Services',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Azure Machine Learning',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Azure Bot Service',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Azure Databricks',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-900-064') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='azure_core_services' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ-900-064',v_cert_id,v_theme_id,'Quel service Azure permet de créer des chatbots ?','easy','SINGLE_CHOICE','Bot Service aide à développer et déployer des chatbots.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Azure Bot Service',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Azure Cognitive Services',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Azure Machine Learning',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Azure Logic Apps',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-900-065') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='azure_core_services' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ-900-065',v_cert_id,v_theme_id,'Quel service Azure est un data warehouse ?','easy','SINGLE_CHOICE','Synapse Analytics est un service d''analytique (data warehouse).','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Azure Synapse Analytics',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Azure Databricks',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Azure Data Lake Storage',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Azure Analysis Services',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-900-066') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='azure_core_services' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ-900-066',v_cert_id,v_theme_id,'Quel service Azure est un stockage pour big data ?','easy','SINGLE_CHOICE','Data Lake Storage est optimisé pour l''analytique big data.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Azure Data Lake Storage',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Azure Blob Storage',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Azure Files',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Azure Table Storage',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-900-067') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='azure_core_services' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ-900-067',v_cert_id,v_theme_id,'Quel service Azure est une plateforme d''analytique Spark ?','easy','SINGLE_CHOICE','Databricks est une plateforme Spark managée.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Azure Databricks',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Azure Synapse Analytics',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Azure HDInsight',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Azure Data Factory',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-900-068') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='azure_core_services' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ-900-068',v_cert_id,v_theme_id,'Quel service Azure est un service de pipelines CI/CD ?','easy','SINGLE_CHOICE','Azure DevOps est la suite complète (Pipelines, Repos, Boards, etc.).','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Azure DevOps',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Azure Pipelines',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Azure Repos',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Azure Artifacts',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-900-069') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='azure_core_services' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ-900-069',v_cert_id,v_theme_id,'Quel service Azure stocke le code source Git ?','easy','SINGLE_CHOICE','Azure Repos est un dépôt Git privé.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Azure Repos',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Azure Pipelines',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Azure Artifacts',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Azure Test Plans',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-900-070') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='azure_core_services' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ-900-070',v_cert_id,v_theme_id,'Quel service Azure aide à évaluer et migrer des workloads ?','easy','SINGLE_CHOICE','Azure Migrate évalue et migre les serveurs vers Azure.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Azure Migrate',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Azure Site Recovery',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Azure Database Migration Service',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Azure Data Box',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-900-071') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='azure_core_services' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ-900-071',v_cert_id,v_theme_id,'Quel service Azure transfère des données physiques (appareil) ?','easy','SINGLE_CHOICE','Data Box est un appareil physique pour le transfert de grandes quantités de données.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Azure Data Box',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Azure Migrate',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Azure Site Recovery',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Azure Import/Export',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-900-072') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='azure_core_services' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ-900-072',v_cert_id,v_theme_id,'Quel service Azure assure la reprise après sinistre (DR) ?','easy','SINGLE_CHOICE','Site Recovery orchestre la réplication et le basculement.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Azure Site Recovery',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Azure Backup',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Azure Migrate',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Azure Disaster Recovery',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-900-073') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='azure_core_services' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ-900-073',v_cert_id,v_theme_id,'Quel service Azure sauvegarde les données ?','easy','SINGLE_CHOICE','Azure Backup est le service de sauvegarde managé.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Azure Backup',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Azure Site Recovery',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Azure Migrate',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Azure Storage',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-900-074') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='azure_core_services' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ-900-074',v_cert_id,v_theme_id,'Quel service Azure aide à gérer et optimiser les coûts ?','easy','SINGLE_CHOICE','Cost Management fournit des outils d''analyse et d''optimisation des coûts.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Azure Cost Management',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Azure Advisor',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Azure Budgets',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Azure Pricing Calculator',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-900-075') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='azure_core_services' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ-900-075',v_cert_id,v_theme_id,'Quel service Azure fournit des recommandations personnalisées ?','easy','SINGLE_CHOICE','Advisor donne des conseils sur la fiabilité, la sécurité, les performances et les coûts.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Azure Advisor',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Azure Monitor',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Azure Cost Management',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Azure Security Center',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-900-076') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='azure_core_services' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ-900-076',v_cert_id,v_theme_id,'Quel service Azure unifie la gestion de la sécurité ?','easy','SINGLE_CHOICE','Security Center fournit une vue unifiée de la sécurité.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Azure Security Center',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Azure Sentinel',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Azure Defender',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Azure Policy',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-900-077') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='azure_core_services' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ-900-077',v_cert_id,v_theme_id,'Quel service Azure est un SIEM (Security Information and Event Management) ?','easy','SINGLE_CHOICE','Azure Sentinel est un SIEM/SOAR cloud.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Azure Sentinel',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Azure Security Center',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Azure Log Analytics',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Azure Monitor',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-900-078') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='azure_core_services' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ-900-078',v_cert_id,v_theme_id,'Quel service Azure est un firewall managé ?','easy','SINGLE_CHOICE','Azure Firewall est un service de sécurité réseau managé.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Azure Firewall',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Azure Application Gateway (WAF)',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Azure DDoS Protection',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Azure Network Security Group',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-900-079') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='azure_core_services' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ-900-079',v_cert_id,v_theme_id,'Quel service Azure protège contre les attaques DDoS ?','easy','SINGLE_CHOICE','DDoS Protection offre une protection contre les attaques volumétriques.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Azure DDoS Protection',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Azure Firewall',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Azure Application Gateway (WAF)',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Azure Network Security Group',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-900-080') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='azure_core_services' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ-900-080',v_cert_id,v_theme_id,'Quel service Azure stocke les secrets et clés ?','easy','SINGLE_CHOICE','Key Vault gère les secrets, les clés de chiffrement et les certificats.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Azure Key Vault',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Azure Security Center',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Azure Information Protection',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Azure AD',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-900-081') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security___compliance' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ-900-081',v_cert_id,v_theme_id,'Qu''est-ce que Azure Active Directory (Azure AD) ?','easy','SINGLE_CHOICE','Azure AD est le service d''annuaire pour les identités et l''accès.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Service d''annuaire et de gestion des identités',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Service de base de données',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Service de stockage',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Service de calcul',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-900-082') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security___compliance' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ-900-082',v_cert_id,v_theme_id,'Azure AD est-il la même chose qu''Active Directory on-premise ?','easy','SINGLE_CHOICE','Azure AD est un service cloud, bien qu''il puisse se synchroniser avec AD on-premise.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Non, c''est un service cloud différent',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Oui',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Partiellement',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','C''est une copie',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-900-083') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security___compliance' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ-900-083',v_cert_id,v_theme_id,'Que signifie MFA (Multi-Factor Authentication) ?','easy','SINGLE_CHOICE','MFA exige deux ou plusieurs formes d''authentification.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Authentification multi-facteurs',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Authentification multi-fonctions',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Autorisation multi-facteurs',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Autorisation multi-fonctions',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-900-084') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security___compliance' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ-900-084',v_cert_id,v_theme_id,'Que signifie RBAC ?','easy','SINGLE_CHOICE','RBAC contrôle l''accès en fonction des rôles.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Role-Based Access Control',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Resource-Based Access Control',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Rule-Based Access Control',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Region-Based Access Control',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-900-085') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security___compliance' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ-900-085',v_cert_id,v_theme_id,'Quels sont les rôles RBAC intégrés ?','easy','SINGLE_CHOICE','Les rôles de base sont Owner, Contributor, Reader.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Owner, Contributor, Reader',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Admin, User, Guest',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Full, Write, Read',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Super, Standard, Limited',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-900-086') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security___compliance' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ-900-086',v_cert_id,v_theme_id,'À quoi sert Azure Policy ?','easy','SINGLE_CHOICE','Azure Policy évalue et applique des règles de conformité sur les ressources.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Appliquer des règles de conformité',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Gérer les identités',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Sécuriser les réseaux',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Surveiller les applications',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-900-087') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security___compliance' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ-900-087',v_cert_id,v_theme_id,'À quoi sert Azure Blueprints ?','easy','SINGLE_CHOICE','Blueprints permettent de déployer un environnement complet conforme aux normes.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Définir et déployer un ensemble de ressources conformes',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Créer des modèles de déploiement',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Documenter l''architecture',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Sauvegarder les ressources',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-900-088') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security___compliance' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ-900-088',v_cert_id,v_theme_id,'À quoi sert Azure Security Center ?','easy','SINGLE_CHOICE','Security Center fournit une visibilité et un contrôle sur la sécurité.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Gestion unifiée de la sécurité et des menaces',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Gestion des identités',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Gestion des coûts',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Gestion des performances',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-900-089') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security___compliance' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ-900-089',v_cert_id,v_theme_id,'À quoi sert Azure Sentinel ?','easy','SINGLE_CHOICE','Sentinel est un SIEM/SOAR cloud.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','SIEM (Security Information and Event Management)',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Firewall',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Anti-DDoS',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Gestion des identités',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-900-090') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security___compliance' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ-900-090',v_cert_id,v_theme_id,'À quoi sert Azure Key Vault ?','easy','SINGLE_CHOICE','Key Vault centralise la gestion des secrets.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Stocker des secrets, clés et certificats',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Stocker des mots de passe',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Stocker des données',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Stocker des logs',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-900-091') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security___compliance' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ-900-091',v_cert_id,v_theme_id,'À quoi sert Azure Information Protection (AIP) ?','easy','SINGLE_CHOICE','AIP aide à classifier et protéger les données sensibles.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Classifier et protéger les documents',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Chiffrer les bases de données',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Sécuriser les réseaux',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Surveiller les accès',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-900-092') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security___compliance' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ-900-092',v_cert_id,v_theme_id,'À quoi sert Azure AD PIM ?','easy','SINGLE_CHOICE','PIM permet d''activer les rôles privilégiés temporairement.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Gérer l''accès privilégié juste-à-temps',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Gérer les identités',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Gérer les rôles RBAC',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Gérer les mots de passe',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-900-093') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security___compliance' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ-900-093',v_cert_id,v_theme_id,'À quoi sert Azure AD Identity Protection ?','easy','SINGLE_CHOICE','Identity Protection détecte les comportements suspects et les risques.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Détecter les risques liés aux identités',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Protéger les identités',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Gérer les mots de passe',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Gérer les rôles',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-900-094') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security___compliance' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ-900-094',v_cert_id,v_theme_id,'Qu''est-ce qu''Azure Firewall ?','easy','SINGLE_CHOICE','Azure Firewall est un service de sécurité réseau managé.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Firewall managé avec haute disponibilité',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','NSG',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Application Gateway',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','WAF',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-900-095') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security___compliance' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ-900-095',v_cert_id,v_theme_id,'Qu''est-ce qu''un NSG ?','easy','SINGLE_CHOICE','NSG contient des règles de filtrage du trafic.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Filtrage du trafic réseau au niveau du sous-réseau ou de la carte réseau',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Firewall managé',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','WAF',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Load balancer',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-900-096') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security___compliance' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ-900-096',v_cert_id,v_theme_id,'Azure DDoS Protection est-il disponible en deux niveaux ?','easy','SINGLE_CHOICE','DDoS Protection Basic est inclus, Standard est payant avec plus de fonctionnalités.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Basic (gratuit) et Standard',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Seulement Standard',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Seulement Basic',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Premium',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-900-097') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security___compliance' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ-900-097',v_cert_id,v_theme_id,'Quel service Azure donne accès aux rapports de conformité ?','easy','SINGLE_CHOICE','Azure Compliance Documentation fournit les rapports de conformité.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Azure Compliance Documentation',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Azure Security Center',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Azure Policy',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Azure Blueprints',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-900-098') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security___compliance' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ-900-098',v_cert_id,v_theme_id,'Azure est-il certifié ISO 27001 ?','easy','SINGLE_CHOICE','Azure est certifié ISO 27001.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Oui',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Partiellement',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Uniquement pour certains services',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-900-099') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security___compliance' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ-900-099',v_cert_id,v_theme_id,'Azure est-il conforme GDPR ?','easy','SINGLE_CHOICE','Azure est conforme GDPR.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Oui',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Partiellement',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Uniquement en Europe',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-900-100') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security___compliance' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ-900-100',v_cert_id,v_theme_id,'Azure est-il certifié HIPAA ?','easy','SINGLE_CHOICE','Azure est certifié HIPAA (Business Associate Agreement).','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Oui',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Partiellement',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Uniquement aux USA',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-900-101') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security___compliance' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ-900-101',v_cert_id,v_theme_id,'Azure est-il certifié SOC 1, 2, 3 ?','easy','SINGLE_CHOICE','Azure a les certifications SOC 1, 2, 3.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Oui',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Seulement SOC 2',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Seulement SOC 1',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-900-102') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security___compliance' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ-900-102',v_cert_id,v_theme_id,'Azure Government est-il destiné aux agences gouvernementales américaines ?','easy','SINGLE_CHOICE','Azure Government répond aux exigences de sécurité des agences américaines.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Oui',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Uniquement aux agences fédérales',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Uniquement aux agences locales',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-900-103') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security___compliance' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ-900-103',v_cert_id,v_theme_id,'Azure China est-il opéré par 21Vianet ?','easy','SINGLE_CHOICE','Azure China est opéré par 21Vianet pour se conformer aux régulations chinoises.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Oui',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Par Microsoft',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Par un partenaire local',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-900-104') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security___compliance' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ-900-104',v_cert_id,v_theme_id,'Les données dans Azure Storage sont-elles chiffrées par défaut ?','easy','SINGLE_CHOICE','Azure Storage chiffre les données au repos par défaut (SSE).','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Oui',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Optionnel',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Uniquement pour certains types',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-900-105') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security___compliance' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ-900-105',v_cert_id,v_theme_id,'Azure supporte-t-il TLS pour les communications ?','easy','SINGLE_CHOICE','Azure utilise TLS pour le chiffrement en transit.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Oui',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Uniquement pour certaines régions',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Uniquement pour certains services',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-900-106') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security___compliance' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ-900-106',v_cert_id,v_theme_id,'À quoi sert Azure AD Connect ?','easy','SINGLE_CHOICE','Azure AD Connect synchronise les identités entre AD local et Azure AD.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Synchroniser Active Directory on-premise avec Azure AD',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Connecter des ressources Azure',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Configurer le VPN',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Gérer les identités',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-900-107') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security___compliance' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ-900-107',v_cert_id,v_theme_id,'Qu''est-ce que l''accès conditionnel dans Azure AD ?','easy','SINGLE_CHOICE','Conditional Access prend des décisions d''accès en fonction de conditions (emplacement, appareil, etc.).','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Règles basées sur le contexte pour l''accès',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Authentification multi-facteurs',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','RBAC',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','PIM',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-900-108') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security___compliance' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ-900-108',v_cert_id,v_theme_id,'Azure AD B2B permet-il d''inviter des utilisateurs externes ?','easy','SINGLE_CHOICE','Azure AD B2B permet de partager des applications avec des utilisateurs externes.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Oui',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Uniquement pour les partenaires',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Uniquement pour les fournisseurs',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-900-109') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security___compliance' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ-900-109',v_cert_id,v_theme_id,'Qu''est-ce que l''accès Just-in-Time (JIT) dans Security Center ?','easy','SINGLE_CHOICE','JIT restreint l''accès aux ports de gestion et les ouvre à la demande.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Ouvrir des ports uniquement quand nécessaire',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Authentification temporaire',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Rôles temporaires',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Mots de passe temporaires',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-900-110') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security___compliance' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ-900-110',v_cert_id,v_theme_id,'À quoi sert Azure Bastion ?','easy','SINGLE_CHOICE','Bastion fournit un accès RDP/SSH via le navigateur.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Accès RDP/SSH sécurisé aux VMs sans IP publique',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Firewall',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','VPN',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Load balancer',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-900-111') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security___compliance' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ-900-111',v_cert_id,v_theme_id,'Azure DDoS Protection Standard offre-t-il une protection contre les attaques DDoS ?','easy','SINGLE_CHOICE','DDoS Protection Standard protège les ressources VNet.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Oui',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Uniquement pour les VMs',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Uniquement pour les applications web',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-900-112') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security___compliance' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ-900-112',v_cert_id,v_theme_id,'Qu''est-ce qu''une initiative dans Azure Policy ?','easy','SINGLE_CHOICE','Une initiative regroupe plusieurs politiques pour atteindre un objectif de conformité.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Groupe de politiques pour un objectif commun',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Une seule politique',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Un blueprint',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Une ressource',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-900-113') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security___compliance' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ-900-113',v_cert_id,v_theme_id,'Quels sont les effets possibles d''Azure Policy ?','easy','SINGLE_CHOICE','Les effets incluent Deny, Audit, Append, DeployIfNotExists, etc.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Deny, Audit, Append, DeployIfNotExists, etc.',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Allow, Block, Log',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Enable, Disable, Warn',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Pass, Fail, Skip',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-900-114') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security___compliance' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ-900-114',v_cert_id,v_theme_id,'Quels sont les artefacts d''un blueprint ?','easy','SINGLE_CHOICE','Un blueprint peut contenir plusieurs types d''artefacts.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Role assignments, policy assignments, ARM templates, resource groups',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Seulement les templates',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Seulement les politiques',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Seulement les rôles',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-900-115') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security___compliance' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ-900-115',v_cert_id,v_theme_id,'Azure Security Center a-t-il des niveaux gratuits et payants ?','easy','SINGLE_CHOICE','Le niveau gratuit offre une évaluation de base, le niveau Standard (ou Defender) des protections avancées.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Oui (Free et Standard)',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Uniquement payant',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Uniquement gratuit',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-900-116') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security___compliance' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ-900-116',v_cert_id,v_theme_id,'Qu''est-ce qu''Azure Defender (anciennement Security Center Standard) ?','easy','SINGLE_CHOICE','Azure Defender offre des protections avancées pour divers services.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Protection avancée contre les menaces',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Firewall',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','WAF',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Anti-DDoS',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-900-117') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security___compliance' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ-900-117',v_cert_id,v_theme_id,'Azure Sentinel est-il payant ?','easy','SINGLE_CHOICE','Sentinel facture le volume de données ingérées et analysées.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Oui (basé sur le volume de données)',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Gratuit pour les premiers Go',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Inclus dans Security Center',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-900-118') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security___compliance' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ-900-118',v_cert_id,v_theme_id,'Key Vault supporte-t-il la suppression réversible (soft-delete) ?','easy','SINGLE_CHOICE','Key Vault a une fonction de suppression réversible pour récupérer les ressources supprimées.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Oui',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Uniquement pour les secrets',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Uniquement pour les clés',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-900-119') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security___compliance' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ-900-119',v_cert_id,v_theme_id,'AIP permet-il d''appliquer des labels de classification ?','easy','SINGLE_CHOICE','AIP permet de classer et protéger les documents avec des labels.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Oui',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Uniquement pour les emails',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Uniquement pour les documents Office',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-900-120') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security___compliance' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ-900-120',v_cert_id,v_theme_id,'Azure AD Domain Services fournit-il des services de domaine (LDAP, Kerberos) ?','easy','SINGLE_CHOICE','Azure AD DS offre des services de domaine managés.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Oui',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Uniquement avec synchronisation',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Uniquement pour les VMs Windows',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-900-121') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security___compliance' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ-900-121',v_cert_id,v_theme_id,'Azure AD B2C est-il destiné aux applications clientes ?','easy','SINGLE_CHOICE','B2C est pour l''authentification des clients (Consumer).','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Oui',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Uniquement pour les employés',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Uniquement pour les partenaires',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-900-122') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security___compliance' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ-900-122',v_cert_id,v_theme_id,'PIM nécessite-t-il une licence Azure AD Premium P2 ?','easy','SINGLE_CHOICE','PIM est disponible avec Azure AD Premium P2.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Oui',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Gratuit',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Inclus dans P1',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-900-123') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security___compliance' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ-900-123',v_cert_id,v_theme_id,'Identity Protection nécessite-t-il une licence Premium P2 ?','easy','SINGLE_CHOICE','Identity Protection est disponible avec Azure AD Premium P2.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Oui',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Gratuit',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Inclus dans P1',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-900-124') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security___compliance' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ-900-124',v_cert_id,v_theme_id,'Azure Firewall est-il plus complet qu''un NSG ?','easy','SINGLE_CHOICE','Azure Firewall offre des fonctionnalités avancées (FQDN, threat intelligence).','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Oui (FQDN, threat intelligence, etc.)',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Identiques',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','NSG plus complet',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-900-125') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security___compliance' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ-900-125',v_cert_id,v_theme_id,'Le WAF d''Azure peut-il être associé à Application Gateway ?','easy','SINGLE_CHOICE','Application Gateway peut intégrer un WAF.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Oui',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Uniquement à Front Door',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Uniquement à CDN',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-900-126') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security___compliance' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ-900-126',v_cert_id,v_theme_id,'Azure DDoS Protection Standard nécessite-t-il un abonnement ?','easy','SINGLE_CHOICE','DDoS Protection Standard est un service payant.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Oui',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Inclus dans le support',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Inclus dans Azure AD Premium',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-900-127') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security___compliance' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ-900-127',v_cert_id,v_theme_id,'Azure Policy peut-il évaluer la conformité des ressources existantes ?','easy','SINGLE_CHOICE','Azure Policy évalue les ressources existantes et nouvelles.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Oui',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Uniquement pour les nouvelles ressources',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Uniquement pour les ressources modifiées',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-900-128') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security___compliance' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ-900-128',v_cert_id,v_theme_id,'Les blueprints supportent-ils le versioning ?','easy','SINGLE_CHOICE','Les blueprints ont des versions pour suivre les modifications.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Oui',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Uniquement avec des étiquettes',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Uniquement avec des snapshots',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-900-129') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security___compliance' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ-900-129',v_cert_id,v_theme_id,'Security Center fournit-il un score de sécurité ?','easy','SINGLE_CHOICE','Le secure score évalue la posture de sécurité.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Oui',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Uniquement pour les VMs',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Uniquement pour les conteneurs',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-900-130') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security___compliance' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ-900-130',v_cert_id,v_theme_id,'Security Center donne-t-il des recommandations de sécurité ?','easy','SINGLE_CHOICE','Security Center propose des recommandations pour améliorer la sécurité.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Oui',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Uniquement pour les machines',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Uniquement pour les réseaux',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-900-131') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security___compliance' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ-900-131',v_cert_id,v_theme_id,'Sentinel peut-il se connecter à des sources de données tierces ?','easy','SINGLE_CHOICE','Sentinel a de nombreux connecteurs pour les sources tierces.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Oui (via connecteurs)',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Uniquement aux services Azure',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Uniquement à Office 365',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-900-132') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security___compliance' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ-900-132',v_cert_id,v_theme_id,'Key Vault peut-il envoyer des logs à Log Analytics ?','easy','SINGLE_CHOICE','Key Vault peut envoyer les logs de diagnostic à Log Analytics.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Oui',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Uniquement via Event Hub',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Uniquement via Storage',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-900-133') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security___compliance' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ-900-133',v_cert_id,v_theme_id,'Azure AD Connect Health surveille-t-il l''état de synchronisation ?','easy','SINGLE_CHOICE','Connect Health surveille la santé de la synchronisation.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Oui',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Uniquement pour AD FS',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Uniquement pour les domain controllers',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-900-134') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security___compliance' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ-900-134',v_cert_id,v_theme_id,'Azure AD Application Proxy permet-il d''accéder à des applications on-premise ?','easy','SINGLE_CHOICE','Application Proxy donne un accès sécurisé aux applications internes.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Oui',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Uniquement aux applications cloud',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Uniquement aux applications SaaS',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-900-135') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security___compliance' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ-900-135',v_cert_id,v_theme_id,'Azure AD permet-il la réinitialisation de mot de passe en libre-service ?','easy','SINGLE_CHOICE','La réinitialisation de mot de passe en libre-service est disponible avec certaines licences.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Oui',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Uniquement avec licence Premium',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Uniquement avec AD on-premise',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-900-136') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security___compliance' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ-900-136',v_cert_id,v_theme_id,'Azure AD supporte-t-il des groupes dynamiques basés sur des attributs ?','easy','SINGLE_CHOICE','Les groupes dynamiques sont disponibles avec Azure AD Premium P1.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Oui',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Uniquement avec P1',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Uniquement avec P2',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-900-137') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security___compliance' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ-900-137',v_cert_id,v_theme_id,'Azure AD permet-il de déléguer l''administration par unités administratives ?','easy','SINGLE_CHOICE','Les unités administratives permettent une délégation granulaire.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Oui',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Uniquement avec P1',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Uniquement avec P2',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-900-138') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security___compliance' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ-900-138',v_cert_id,v_theme_id,'Azure AD Access Reviews permet-il de vérifier les accès ?','easy','SINGLE_CHOICE','Access Reviews permet de vérifier et de révoquer les accès.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Oui',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Uniquement avec P1',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Uniquement avec P2',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-900-139') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security___compliance' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ-900-139',v_cert_id,v_theme_id,'Azure AD permet-il d''exiger l''acceptation des conditions d''utilisation ?','easy','SINGLE_CHOICE','Les conditions d''utilisation peuvent être présentées aux utilisateurs.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Oui',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Uniquement avec P1',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Uniquement avec P2',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-900-140') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='security___compliance' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ-900-140',v_cert_id,v_theme_id,'Azure AD Identity Governance inclut-il des fonctionnalités de gestion des accès ?','easy','SINGLE_CHOICE','Identity Governance offre des fonctionnalités avancées de gestion des accès.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Oui',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Uniquement avec P1',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Uniquement avec P2',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-900-141') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='pricing___support' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ-900-141',v_cert_id,v_theme_id,'Quels sont les modèles de tarification Azure ?','easy','SINGLE_CHOICE','Azure propose plusieurs modèles de tarification.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Pay-as-you-go, Reserved Instances, Spot, Savings Plan',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Uniquement pay-as-you-go',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Uniquement Reserved',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Uniquement Spot',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-900-142') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='pricing___support' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ-900-142',v_cert_id,v_theme_id,'Pay-as-you-go facture-t-il à l''heure ou à la seconde ?','easy','SINGLE_CHOICE','Les VMs sont facturées à la seconde (minimum 1 minute).','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','À la seconde (souvent à l''heure pour les VMs)',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','À la minute',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','À l''heure uniquement',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Au mois',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-900-143') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='pricing___support' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ-900-143',v_cert_id,v_theme_id,'Les Reserved Instances offrent-elles une réduction ?','easy','SINGLE_CHOICE','Les réservations offrent des réductions en échange d''un engagement d''1 ou 3 ans.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Oui (jusqu''à 72%)',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Uniquement pour les VMs',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Uniquement pour les bases de données',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-900-144') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='pricing___support' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ-900-144',v_cert_id,v_theme_id,'Qu''est-ce que l''Azure Hybrid Benefit ?','easy','SINGLE_CHOICE','L''Azure Hybrid Benefit permet d''utiliser vos licences on-premise sur Azure.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Réutilisation des licences Windows Server/SQL Server sur Azure',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Réduction pour les startups',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Offre gratuite',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Remise pour les engagements',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-900-145') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='pricing___support' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ-900-145',v_cert_id,v_theme_id,'Les instances Spot peuvent-elles être interrompues ?','easy','SINGLE_CHOICE','Les instances Spot peuvent être reprises avec un préavis de 30 secondes.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Oui',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Uniquement avec préavis',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Uniquement avec notification',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-900-146') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='pricing___support' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ-900-146',v_cert_id,v_theme_id,'Quels services sont inclus dans le compte gratuit Azure ?','easy','SINGLE_CHOICE','Le compte gratuit comprend un crédit de 200 $ pour 30 jours, 12 mois de services gratuits, et des services toujours gratuits.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','12 mois de services gratuits, toujours gratuits, crédit de 200$',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Uniquement les VMs',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Uniquement les bases de données',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Uniquement le stockage',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-900-147') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='pricing___support' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ-900-147',v_cert_id,v_theme_id,'À quoi sert la calculatrice de prix Azure ?','easy','SINGLE_CHOICE','La calculatrice permet d''estimer les coûts des services.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Estimer les coûts avant déploiement',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Facturer les clients',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Gérer les budgets',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Suivre les dépenses',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-900-148') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='pricing___support' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ-900-148',v_cert_id,v_theme_id,'À quoi sert le calculateur TCO ?','easy','SINGLE_CHOICE','Le calculateur TCO estime les économies réalisées en migrant vers Azure.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Comparer les coûts on-premise vs cloud',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Estimer les coûts',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Budgéter',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Optimiser',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-900-149') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='pricing___support' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ-900-149',v_cert_id,v_theme_id,'Azure Cost Management permet-il de suivre les coûts ?','easy','SINGLE_CHOICE','Cost Management fournit des outils d''analyse et de suivi des coûts.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Oui',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Uniquement pour les abonnements EA',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Uniquement pour les souscriptions',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-900-150') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='pricing___support' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ-900-150',v_cert_id,v_theme_id,'Les budgets Azure peuvent-ils envoyer des alertes ?','easy','SINGLE_CHOICE','Les budgets peuvent envoyer des alertes par e-mail ou déclencher des actions.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Oui',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Uniquement des notifications',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Uniquement des actions',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-900-151') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='pricing___support' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ-900-151',v_cert_id,v_theme_id,'Azure Advisor donne-t-il des conseils pour réduire les coûts ?','easy','SINGLE_CHOICE','Advisor fournit des recommandations d''optimisation des coûts.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Oui',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Uniquement pour la sécurité',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Uniquement pour les performances',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-900-152') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='pricing___support' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ-900-152',v_cert_id,v_theme_id,'Quels sont les plans de support Azure ?','easy','SINGLE_CHOICE','Azure propose Basic (gratuit), Developer, Standard, Professional Direct (et Premier pour les grands comptes).','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Basic, Developer, Standard, Professional Direct, Premier',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Basic seulement',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Standard seulement',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Professional Direct seulement',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-900-153') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='pricing___support' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ-900-153',v_cert_id,v_theme_id,'Le plan Basic est-il gratuit ?','easy','SINGLE_CHOICE','Le plan Basic est inclus gratuitement.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Oui',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Uniquement pour les comptes de moins d''un an',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Uniquement pour les étudiants',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-900-154') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='pricing___support' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ-900-154',v_cert_id,v_theme_id,'Quel plan offre un temps de réponse de moins d''une heure pour les cas critiques ?','easy','SINGLE_CHOICE','Le plan Professional Direct offre une réponse < 1 heure pour les cas critiques.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Professional Direct',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Standard',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Developer',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Basic',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-900-155') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='pricing___support' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ-900-155',v_cert_id,v_theme_id,'Quel plan inclut un Technical Account Manager (TAM) ?','easy','SINGLE_CHOICE','Le plan Premier (ou Enterprise) inclut un TAM dédié.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Premier',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Professional Direct',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Standard',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Developer',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-900-156') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='pricing___support' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ-900-156',v_cert_id,v_theme_id,'Qu''est-ce qu''un SLA Azure ?','easy','SINGLE_CHOICE','Le SLA est l''engagement de Microsoft sur la disponibilité du service.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Garantie de disponibilité d''un service',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Tarif',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Support',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Conformité',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-900-157') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='pricing___support' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ-900-157',v_cert_id,v_theme_id,'Que se passe-t-il si Microsoft ne respecte pas le SLA ?','easy','SINGLE_CHOICE','Microsoft accorde des crédits de service en cas de non-respect du SLA.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Crédits de service',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Remboursement total',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Support gratuit',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Aucune conséquence',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-900-158') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='pricing___support' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ-900-158',v_cert_id,v_theme_id,'Qu''est-ce qu''un SLA composite ?','easy','SINGLE_CHOICE','Le SLA composite est le produit des SLA des composants.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','SLA calculé pour une application composée de plusieurs services',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','SLA pour un seul service',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','SLA pour une région',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','SLA pour une zone',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-900-159') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='pricing___support' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ-900-159',v_cert_id,v_theme_id,'À quoi sert Azure Service Health ?','easy','SINGLE_CHOICE','Service Health donne des informations sur les incidents et maintenances.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Surveiller la santé des services Azure',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Surveiller les coûts',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Surveiller les performances',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Surveiller les logs',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-900-160') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='pricing___support' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ-900-160',v_cert_id,v_theme_id,'Azure Status affiche-t-il la disponibilité globale des services Azure ?','easy','SINGLE_CHOICE','Azure Status est une page publique montrant la santé des services par région.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Oui',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Uniquement pour une région',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Uniquement pour les services de calcul',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-900-161') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='pricing___support' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ-900-161',v_cert_id,v_theme_id,'Les ressources dans un groupe de ressources sont-elles facturées séparément ?','easy','SINGLE_CHOICE','La facturation est individuelle par ressource, quel que soit le groupe.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Oui (facturation par ressource)',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Uniquement pour les VMs',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Uniquement pour le stockage',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-900-162') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='pricing___support' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ-900-162',v_cert_id,v_theme_id,'Les tags aident-ils à la gestion des coûts ?','easy','SINGLE_CHOICE','Les tags permettent de regrouper les coûts par projet, équipe, environnement.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Oui (regrouper les coûts par tag)',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Uniquement pour les VMs',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Uniquement pour le stockage',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-900-163') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='pricing___support' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ-900-163',v_cert_id,v_theme_id,'Qu''est-ce qu''Azure Enterprise Agreement (EA) ?','easy','SINGLE_CHOICE','EA est un contrat de licence pour les grandes entreprises avec des engagements de dépenses.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Contrat pour les grandes organisations avec engagements',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Compte gratuit',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Offre pour les startups',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Licence open source',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-900-164') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='pricing___support' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ-900-164',v_cert_id,v_theme_id,'Qu''est-ce que l''engagement de consommation Azure (Azure Consumption Commitment) ?','easy','SINGLE_CHOICE','L''engagement de consommation (MACC) offre des réductions en échange d''un engagement de dépenses.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Engagement de dépenses annuel avec réduction',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Paiement à l''usage',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Crédit gratuit',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Remise automatique',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-900-165') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='pricing___support' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ-900-165',v_cert_id,v_theme_id,'Quel est le préavis pour l''éviction d''une instance Spot ?','easy','SINGLE_CHOICE','Azure donne un préavis de 30 secondes avant l''éviction.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','30 secondes',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','2 minutes',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','5 minutes',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','10 minutes',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-900-166') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='pricing___support' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ-900-166',v_cert_id,v_theme_id,'Le Savings Plan Azure offre-t-il une flexibilité sur les familles de VMs ?','easy','SINGLE_CHOICE','Le Savings Plan est plus flexible que les RI.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Oui',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Uniquement pour une famille',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Uniquement pour une région',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-900-167') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='pricing___support' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ-900-167',v_cert_id,v_theme_id,'Les Reserved Instances peuvent-elles être échangées ou annulées ?','easy','SINGLE_CHOICE','Les RI peuvent être échangées ou remboursées avec des frais.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Échange possible, annulation avec frais',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Annulation gratuite',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Échange impossible',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-900-168') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='pricing___support' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ-900-168',v_cert_id,v_theme_id,'Azure Hybrid Benefit s''applique-t-il aux VMs Linux ?','easy','SINGLE_CHOICE','Il existe des offres Hybrid Benefit pour Red Hat et SUSE.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Non',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Oui (Red Hat, SUSE)',TRUE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Uniquement pour Ubuntu',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Uniquement pour Debian',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-900-169') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='pricing___support' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ-900-169',v_cert_id,v_theme_id,'Le prix des instances Spot est-il variable ?','easy','SINGLE_CHOICE','Les prix Spot varient en fonction de l''offre et de la demande.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Oui',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Fixe',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Dépend de la région',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-900-170') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='pricing___support' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ-900-170',v_cert_id,v_theme_id,'Azure Cost Management permet-il de définir des budgets ?','easy','SINGLE_CHOICE','Cost Management permet de créer des budgets et des alertes.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Oui',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Uniquement pour les abonnements',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Uniquement pour les groupes de ressources',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-900-171') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='pricing___support' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ-900-171',v_cert_id,v_theme_id,'Advisor peut-il recommander de redimensionner des VMs sous-utilisées ?','easy','SINGLE_CHOICE','Advisor identifie les VMs sous-utilisées et recommande un redimensionnement.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Oui',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Uniquement pour les VMs Windows',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Uniquement pour les VMs Linux',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-900-172') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='pricing___support' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ-900-172',v_cert_id,v_theme_id,'Quel plan supporte l''accès à toutes les API de support ?','easy','SINGLE_CHOICE','Les plans Developer, Standard, Professional Direct et Premier ont accès aux API de support.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Tous sauf Basic',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Seulement Professional Direct',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Seulement Standard',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Seulement Premier',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-900-173') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='pricing___support' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ-900-173',v_cert_id,v_theme_id,'Les crédits SLA sont-ils automatiques ou demandés ?','easy','SINGLE_CHOICE','Il faut demander les crédits en soumettant une réclamation.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Demande via une réclamation',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Automatiques',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Uniquement pour les comptes Enterprise',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Uniquement pour les comptes CSP',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-900-174') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='pricing___support' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ-900-174',v_cert_id,v_theme_id,'Service Health peut-il envoyer des alertes par e-mail ?','easy','SINGLE_CHOICE','Service Health peut envoyer des alertes par e-mail, SMS, webhook.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Oui',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Uniquement par SMS',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Uniquement par webhook',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-900-175') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='pricing___support' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ-900-175',v_cert_id,v_theme_id,'Service Health peut-il être personnalisé pour suivre des services spécifiques ?','easy','SINGLE_CHOICE','Vous pouvez configurer Service Health pour surveiller des services, régions, et abonnements spécifiques.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Oui',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Uniquement pour les VMs',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Uniquement pour les bases de données',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-900-176') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='pricing___support' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ-900-176',v_cert_id,v_theme_id,'Azure Status conserve-t-il un historique des incidents ?','easy','SINGLE_CHOICE','Azure Status affiche un historique des incidents.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Oui',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Seulement pour les 30 derniers jours',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Seulement pour les 90 derniers jours',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-900-177') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='pricing___support' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ-900-177',v_cert_id,v_theme_id,'Azure for Students offre-t-il un crédit gratuit ?','easy','SINGLE_CHOICE','Azure for Students offre 100 $ de crédit.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Oui (100$)',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Uniquement des VMs gratuites',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Uniquement du stockage gratuit',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-900-178') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='pricing___support' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ-900-178',v_cert_id,v_theme_id,'Azure Sponsorship offre-t-il des crédits pour les startups ?','easy','SINGLE_CHOICE','Azure Sponsorship offre des crédits (souvent via des programmes partenaires).','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Oui',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Uniquement pour les entreprises',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Uniquement pour les gouvernements',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-900-179') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='pricing___support' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ-900-179',v_cert_id,v_theme_id,'Les services Azure ont-ils différents niveaux de tarification (ex: Basic, Standard, Premium) ?','easy','SINGLE_CHOICE','La plupart des services ont plusieurs niveaux (ex: Storage, App Service, SQL Database).','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Oui',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Uniquement pour les VMs',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Uniquement pour le stockage',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-900-180') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='pricing___support' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ-900-180',v_cert_id,v_theme_id,'Les instances Spot sont-elles adaptées aux workloads tolérants aux interruptions ?','easy','SINGLE_CHOICE','Les instances Spot sont idéales pour les workloads non critiques, batch, ou tolérants aux interruptions.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Oui',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Uniquement pour les batch jobs',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Uniquement pour les dev/test',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-900-181') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='pricing___support' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ-900-181',v_cert_id,v_theme_id,'Azure Hybrid Benefit permet-il d''utiliser des licences Windows Server avec Software Assurance ?','easy','SINGLE_CHOICE','L''Azure Hybrid Benefit s''applique aux licences Windows Server avec Software Assurance.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Oui',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Uniquement pour les VMs',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Uniquement pour les conteneurs',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-900-182') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='pricing___support' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ-900-182',v_cert_id,v_theme_id,'Azure Hybrid Benefit s''applique-t-il à SQL Server ?','easy','SINGLE_CHOICE','L''Azure Hybrid Benefit s''applique à SQL Server sur Azure (VM, Managed Instance).','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Oui',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Uniquement pour Azure SQL Managed Instance',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Uniquement pour SQL on VMs',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-900-183') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='pricing___support' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ-900-183',v_cert_id,v_theme_id,'Azure offre-t-il des tarifs réduits pour le développement/test ?','easy','SINGLE_CHOICE','Azure a des tarifs Dev/Test réduits pour les environnements non productifs.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Oui (Dev/Test pricing)',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Uniquement pour les MSDN subscribers',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Uniquement pour les startups',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-900-184') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='pricing___support' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ-900-184',v_cert_id,v_theme_id,'Les Reserved Instances peuvent-elles être appliquées à un abonnement spécifique ou partagées ?','easy','SINGLE_CHOICE','Les RI peuvent avoir une portée partagée (organisation) ou par abonnement.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Oui (single ou shared)',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Uniquement partagées',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Uniquement par abonnement',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-900-185') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='pricing___support' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ-900-185',v_cert_id,v_theme_id,'Les Reserved Instances sont-elles disponibles pour 1 an ou 3 ans ?','easy','SINGLE_CHOICE','Les RI sont disponibles pour des engagements de 1 ou 3 ans.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','1 an ou 3 ans',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Seulement 1 an',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Seulement 3 ans',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','6 mois',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-900-186') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='pricing___support' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ-900-186',v_cert_id,v_theme_id,'Les Savings Plans sont-ils disponibles pour 1 an ou 3 ans ?','easy','SINGLE_CHOICE','Les Savings Plans sont disponibles pour 1 ou 3 ans.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','1 an ou 3 ans',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Seulement 1 an',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Seulement 3 ans',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','6 mois',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-900-187') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='pricing___support' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ-900-187',v_cert_id,v_theme_id,'Quels services sont toujours gratuits avec un compte Azure ?','easy','SINGLE_CHOICE','Il y a des services toujours gratuits, comme Cosmos DB, Functions, etc.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Cosmos DB (5 Go), Functions (1M req), etc.',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Aucun',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Seulement les VMs B1S',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Seulement le stockage',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-900-188') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='pricing___support' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ-900-188',v_cert_id,v_theme_id,'Quels services sont gratuits pendant 12 mois ?','easy','SINGLE_CHOICE','Les services gratuits pendant 12 mois incluent une VM B1S, un stockage, une base SQL, etc.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','VM B1S, Storage, SQL Database, etc.',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Aucun',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Seulement les VMs',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Seulement le stockage',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-900-189') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='pricing___support' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ-900-189',v_cert_id,v_theme_id,'Le transfert de données entrant vers Azure est-il gratuit ?','easy','SINGLE_CHOICE','Le transfert de données entrant (upload) vers Azure est gratuit.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Oui',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Seulement pour les premiers Go',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Seulement pour certaines régions',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-900-190') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='pricing___support' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ-900-190',v_cert_id,v_theme_id,'Le transfert de données sortant d''Azure est-il facturé ?','easy','SINGLE_CHOICE','Le transfert sortant est facturé (sauf certaines exceptions comme les CDN).','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Oui',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Seulement au-delà d''un seuil',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Seulement pour certaines régions',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-900-191') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='pricing___support' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ-900-191',v_cert_id,v_theme_id,'La calculatrice de prix Azure prend-elle en compte les Savings Plans ?','easy','SINGLE_CHOICE','La calculatrice permet d''inclure les Savings Plans et les RI.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Oui',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Uniquement les RI',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Uniquement le pay-as-you-go',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-900-192') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='pricing___support' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ-900-192',v_cert_id,v_theme_id,'Le calculateur TCO demande-t-il une description de l''infrastructure on-premise ?','easy','SINGLE_CHOICE','Le calculateur TCO nécessite des informations sur les serveurs, stockage, réseau, etc.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Oui',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Seulement pour les serveurs',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Seulement pour le stockage',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-900-193') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='pricing___support' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ-900-193',v_cert_id,v_theme_id,'Cost Management a-t-il une API pour accéder aux données de facturation ?','easy','SINGLE_CHOICE','Cost Management fournit des API pour accéder aux données de consommation et de facturation.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Oui',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Uniquement pour les EA',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Uniquement pour les CSP',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-900-194') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='pricing___support' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ-900-194',v_cert_id,v_theme_id,'Advisor donne-t-il des recommandations pour supprimer les ressources non utilisées ?','easy','SINGLE_CHOICE','Advisor identifie les ressources inutilisées (VMs arrêtées, etc.).','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Oui',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Uniquement pour les VMs',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Uniquement pour les disques',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-900-195') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='pricing___support' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ-900-195',v_cert_id,v_theme_id,'Quel plan supporte une réponse initiale de 1 heure pour les cas critiques ?','easy','SINGLE_CHOICE','Professional Direct offre une réponse < 1 heure pour les cas de gravité A.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Standard',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Professional Direct',TRUE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Developer',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Basic',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-900-196') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='pricing___support' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ-900-196',v_cert_id,v_theme_id,'Les partenaires CSP ont-ils un support spécifique ?','easy','SINGLE_CHOICE','Microsoft propose des plans de support pour les partenaires CSP.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Oui (plan de support CSP)',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Uniquement pour les revendeurs',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Uniquement pour les ISV',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-900-197') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='pricing___support' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ-900-197',v_cert_id,v_theme_id,'Quel est le SLA pour une seule VM sans disques premium ?','easy','SINGLE_CHOICE','Le SLA pour une seule VM est de 99.9% (avec deux VM dans un groupe à disponibilité, 99.95%).','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','99.9%',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','99.95%',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','99.99%',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','100%',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-900-198') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='pricing___support' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ-900-198',v_cert_id,v_theme_id,'Quel est le SLA pour Azure App Service ?','easy','SINGLE_CHOICE','Le SLA pour App Service est de 99.95%.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','99.95%',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','99.9%',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','99.99%',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','99.5%',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-900-199') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='pricing___support' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ-900-199',v_cert_id,v_theme_id,'Service Health a-t-il une application mobile ?','easy','SINGLE_CHOICE','Service Health est disponible dans l''application mobile Azure.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Oui',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Uniquement pour iOS',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Uniquement pour Android',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-900-200') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='pricing___support' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ-900-200',v_cert_id,v_theme_id,'Azure Status propose-t-il un flux RSS ?','easy','SINGLE_CHOICE','Azure Status a des flux RSS pour suivre les incidents.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Oui',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Uniquement par email',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Uniquement par SMS',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-900-201') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='azure_management_tools' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ-900-201',v_cert_id,v_theme_id,'Qu''est-ce que le portail Azure ?','easy','SINGLE_CHOICE','Le portail Azure est une interface web graphique.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Interface web pour gérer les ressources Azure',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Interface en ligne de commande',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','API',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Application mobile',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-900-202') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='azure_management_tools' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ-900-202',v_cert_id,v_theme_id,'Qu''est-ce qu''Azure CLI ?','easy','SINGLE_CHOICE','Azure CLI est un outil en ligne de commande pour gérer Azure.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Interface en ligne de commande multiplateforme',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Portail web',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','API REST',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','PowerShell',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-900-203') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='azure_management_tools' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ-900-203',v_cert_id,v_theme_id,'Qu''est-ce qu''Azure PowerShell ?','easy','SINGLE_CHOICE','Azure PowerShell est un ensemble de cmdlets pour gérer Azure.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Modules PowerShell pour gérer Azure',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Interface web',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','CLI',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','API',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-900-204') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='azure_management_tools' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ-900-204',v_cert_id,v_theme_id,'Que sont les modèles ARM (Azure Resource Manager) ?','easy','SINGLE_CHOICE','Les modèles ARM sont des définitions IaC (Infrastructure as Code).','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Fichiers JSON pour déployer l''infrastructure',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Scripts PowerShell',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Commandes CLI',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Applications',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-900-205') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='azure_management_tools' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ-900-205',v_cert_id,v_theme_id,'Qu''est-ce que Bicep ?','easy','SINGLE_CHOICE','Bicep est un langage déclaratif qui compile en modèles ARM.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Langage DSL pour les modèles ARM (plus simple que JSON)',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','CLI',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','PowerShell',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Portail',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-900-206') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='azure_management_tools' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ-900-206',v_cert_id,v_theme_id,'Qu''est-ce qu''Azure Cloud Shell ?','easy','SINGLE_CHOICE','Cloud Shell est un shell intégré au portail Azure.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Shell accessible depuis le portail (bash/PowerShell)',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','CLI locale',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','PowerShell local',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Terminal distant',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-900-207') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='azure_management_tools' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ-900-207',v_cert_id,v_theme_id,'Quel est le rôle d''Azure Resource Manager ?','easy','SINGLE_CHOICE','ARM est la couche de gestion qui permet de déployer, gérer et surveiller les ressources.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Couche de gestion unifiée pour toutes les ressources',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Base de données',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Stockage',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Calcul',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-900-208') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='azure_management_tools' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ-900-208',v_cert_id,v_theme_id,'Qu''est-ce qu''un groupe de ressources ?','easy','SINGLE_CHOICE','Un groupe de ressources regroupe des ressources partageant un cycle de vie.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Conteneur logique pour les ressources Azure',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Type de ressource',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Région',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Abonnement',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-900-209') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='azure_management_tools' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ-900-209',v_cert_id,v_theme_id,'À quoi servent les tags Azure ?','easy','SINGLE_CHOICE','Les tags sont des paires clé-valeur pour organiser les ressources.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Métadonnées pour organiser les ressources',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Sécurité',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Performances',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Sauvegarde',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-900-210') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='azure_management_tools' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ-900-210',v_cert_id,v_theme_id,'Azure Policy peut-il empêcher la création de ressources non conformes ?','easy','SINGLE_CHOICE','Azure Policy peut bloquer la création de ressources non conformes avec l''effet Deny.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Oui (effet Deny)',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Uniquement en audit',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Uniquement après création',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-900-211') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='azure_management_tools' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ-900-211',v_cert_id,v_theme_id,'Azure Blueprints peut-il déployer un ensemble de ressources en une seule fois ?','easy','SINGLE_CHOICE','Les blueprints permettent de déployer un ensemble cohérent de ressources.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Oui',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Uniquement via ARM',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Uniquement via CLI',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-900-212') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='azure_management_tools' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ-900-212',v_cert_id,v_theme_id,'Azure Monitor collecte-t-il des métriques et des logs ?','easy','SINGLE_CHOICE','Azure Monitor collecte les métriques, les logs, et les traces.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Oui',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Seulement des métriques',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Seulement des logs',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-900-213') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='azure_management_tools' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ-900-213',v_cert_id,v_theme_id,'Azure Log Analytics est-il un service d''analyse de logs ?','easy','SINGLE_CHOICE','Log Analytics permet d''interroger les logs avec KQL.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Oui',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Seulement pour les VMs',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Seulement pour le réseau',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-900-214') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='azure_management_tools' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ-900-214',v_cert_id,v_theme_id,'Application Insights est-il destiné à la surveillance des applications ?','easy','SINGLE_CHOICE','Application Insights surveille les performances des applications.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Oui',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Seulement pour les applications web',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Seulement pour les API',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-900-215') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='azure_management_tools' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ-900-215',v_cert_id,v_theme_id,'Azure Monitor peut-il envoyer des alertes ?','easy','SINGLE_CHOICE','Azure Monitor peut déclencher des alertes sur les métriques et les logs.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Oui',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Uniquement via e-mail',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Uniquement via SMS',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-900-216') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='azure_management_tools' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ-900-216',v_cert_id,v_theme_id,'Azure Dashboards permettent-ils de créer des tableaux de bord personnalisés ?','easy','SINGLE_CHOICE','Les tableaux de bord Azure sont personnalisables avec des métriques et des graphiques.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Oui',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Uniquement dans le portail',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Uniquement dans Power BI',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-900-217') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='azure_management_tools' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ-900-217',v_cert_id,v_theme_id,'Azure Advisor fournit-il des recommandations personnalisées ?','easy','SINGLE_CHOICE','Advisor donne des recommandations sur les coûts, la sécurité, les performances, etc.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Oui',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Uniquement pour les coûts',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Uniquement pour la sécurité',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-900-218') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='azure_management_tools' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ-900-218',v_cert_id,v_theme_id,'Service Health surveille-t-il les incidents Azure ?','easy','SINGLE_CHOICE','Service Health donne des informations sur les incidents et les maintenances.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Oui',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Seulement pour les régions',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Seulement pour les services',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-900-219') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='azure_management_tools' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ-900-219',v_cert_id,v_theme_id,'Azure Resource Graph permet-il d''interroger les ressources à grande échelle ?','easy','SINGLE_CHOICE','Resource Graph permet des requêtes efficaces sur les ressources avec KQL.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Oui',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Uniquement via KQL',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Uniquement via SQL',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-900-220') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='azure_management_tools' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ-900-220',v_cert_id,v_theme_id,'Azure Automation permet-il d''automatiser les tâches ?','easy','SINGLE_CHOICE','Azure Automation offre des runbooks, la gestion des mises à jour, etc.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Oui',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Uniquement les runbooks',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Uniquement la gestion des mises à jour',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-900-221') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='azure_management_tools' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ-900-221',v_cert_id,v_theme_id,'Les runbooks Automation peuvent-ils être écrits en PowerShell ?','easy','SINGLE_CHOICE','Les runbooks peuvent être en PowerShell, Python, Graphique.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Oui',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Uniquement en Python',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Uniquement en JavaScript',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-900-222') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='azure_management_tools' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ-900-222',v_cert_id,v_theme_id,'Azure Automation peut-il gérer les mises à jour des VMs ?','easy','SINGLE_CHOICE','Update Management gère les mises à jour pour Windows et Linux.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Oui',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Uniquement pour Windows',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Uniquement pour Linux',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-900-223') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='azure_management_tools' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ-900-223',v_cert_id,v_theme_id,'State Configuration permet-il la gestion de configuration DSC ?','easy','SINGLE_CHOICE','State Configuration utilise DSC (Desired State Configuration) pour maintenir l''état des VMs.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Oui',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Uniquement pour les VMs',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Uniquement pour les conteneurs',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-900-224') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='azure_management_tools' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ-900-224',v_cert_id,v_theme_id,'Logic Apps est-il un outil d''intégration low-code ?','easy','SINGLE_CHOICE','Logic Apps permet de créer des workflows d''intégration sans code.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Oui',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Uniquement pour les développeurs',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Uniquement pour les administrateurs',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-900-225') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='azure_management_tools' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ-900-225',v_cert_id,v_theme_id,'API Management est-il un service de gestion d''API ?','easy','SINGLE_CHOICE','API Management publie, sécurise et analyse les API.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Oui',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Uniquement pour les API REST',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Uniquement pour les API SOAP',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-900-226') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='azure_management_tools' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ-900-226',v_cert_id,v_theme_id,'DevTest Labs permet-il de créer des environnements de développement/test ?','easy','SINGLE_CHOICE','DevTest Labs facilite la création et la gestion d''environnements de développement.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Oui',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Uniquement pour les VMs',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Uniquement pour les conteneurs',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-900-227') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='azure_management_tools' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ-900-227',v_cert_id,v_theme_id,'Azure Migrate est-il un outil d''évaluation et de migration ?','easy','SINGLE_CHOICE','Azure Migrate évalue et migre les serveurs, les bases, etc.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Oui',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Uniquement pour les serveurs',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Uniquement pour les bases de données',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-900-228') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='azure_management_tools' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ-900-228',v_cert_id,v_theme_id,'Azure Site Recovery est-il un service de reprise après sinistre (DR) ?','easy','SINGLE_CHOICE','Site Recovery orchestre la réplication et le basculement pour la DR.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Oui',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Uniquement pour les VMs',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Uniquement pour les bases',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-900-229') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='azure_management_tools' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ-900-229',v_cert_id,v_theme_id,'Azure Backup est-il un service de sauvegarde ?','easy','SINGLE_CHOICE','Azure Backup sauvegarde les VMs, les fichiers, les bases de données, etc.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Oui',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Uniquement pour les VMs',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Uniquement pour les fichiers',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-900-230') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='azure_management_tools' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ-900-230',v_cert_id,v_theme_id,'Cost Management permet-il de suivre les coûts ?','easy','SINGLE_CHOICE','Cost Management offre une vue complète des coûts.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Oui',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Uniquement pour les abonnements',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Uniquement pour les groupes de ressources',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-900-231') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='azure_management_tools' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ-900-231',v_cert_id,v_theme_id,'Advisor donne-t-il des recommandations d''optimisation des coûts ?','easy','SINGLE_CHOICE','Advisor a une catégorie ''Cost'' pour les recommandations d''optimisation des coûts.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Oui',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Uniquement pour les VMs',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Uniquement pour le stockage',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-900-232') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='azure_management_tools' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ-900-232',v_cert_id,v_theme_id,'Advisor donne-t-il des recommandations de sécurité ?','easy','SINGLE_CHOICE','Advisor a une catégorie ''Security''.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Oui',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Uniquement pour les VMs',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Uniquement pour les réseaux',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-900-233') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='azure_management_tools' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ-900-233',v_cert_id,v_theme_id,'Advisor donne-t-il des recommandations de performance ?','easy','SINGLE_CHOICE','Advisor a une catégorie ''Performance''.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Oui',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Uniquement pour les VMs',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Uniquement pour les bases de données',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-900-234') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='azure_management_tools' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ-900-234',v_cert_id,v_theme_id,'Advisor donne-t-il des recommandations de fiabilité ?','easy','SINGLE_CHOICE','Advisor a une catégorie ''Reliability''.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Oui',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Uniquement pour les VMs',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Uniquement pour les bases de données',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-900-235') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='azure_management_tools' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ-900-235',v_cert_id,v_theme_id,'Resource Graph Explorer est-il un outil pour exécuter des requêtes KQL ?','easy','SINGLE_CHOICE','Resource Graph Explorer est disponible dans le portail.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Oui',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Uniquement dans le portail',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Uniquement en CLI',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-900-236') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='azure_management_tools' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ-900-236',v_cert_id,v_theme_id,'Azure expose-t-il une API REST pour la gestion des ressources ?','easy','SINGLE_CHOICE','Azure Resource Manager fournit une API REST complète.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Oui',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Uniquement pour certaines ressources',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Uniquement pour le calcul',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-900-237') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='azure_management_tools' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ-900-237',v_cert_id,v_theme_id,'Azure propose-t-il des SDK pour différents langages (Python, .NET, Java, etc.) ?','easy','SINGLE_CHOICE','Azure fournit des SDK pour plusieurs langages.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Oui',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Uniquement pour .NET',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Uniquement pour Python',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-900-238') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='azure_management_tools' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ-900-238',v_cert_id,v_theme_id,'Terraform peut-il être utilisé pour gérer Azure ?','easy','SINGLE_CHOICE','Terraform a un provider Azure pour l''IaC.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Oui',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Uniquement via ARM',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Uniquement via CLI',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-900-239') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='azure_management_tools' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ-900-239',v_cert_id,v_theme_id,'Ansible peut-il être utilisé pour configurer Azure ?','easy','SINGLE_CHOICE','Ansible a des modules pour Azure.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Oui',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Uniquement pour les VMs',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Uniquement pour les réseaux',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-900-240') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='azure_management_tools' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ-900-240',v_cert_id,v_theme_id,'Chef peut-il être utilisé pour Azure ?','easy','SINGLE_CHOICE','Chef a des intégrations avec Azure.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Oui',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Uniquement pour les VMs',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Uniquement pour les conteneurs',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-900-241') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='azure_management_tools' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ-900-241',v_cert_id,v_theme_id,'Puppet peut-il être utilisé pour Azure ?','easy','SINGLE_CHOICE','Puppet a des modules pour Azure.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Oui',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Uniquement pour les VMs',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Uniquement pour les conteneurs',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-900-242') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='azure_management_tools' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ-900-242',v_cert_id,v_theme_id,'Azure Bastion est-il un outil de gestion de l''accès sécurisé ?','easy','SINGLE_CHOICE','Bastion permet l''accès RDP/SSH sans IP publique.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Oui',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Uniquement pour les VMs Windows',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Uniquement pour les VMs Linux',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-900-243') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='azure_management_tools' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ-900-243',v_cert_id,v_theme_id,'Azure Monitor Workbooks permettent-ils de créer des rapports interactifs ?','easy','SINGLE_CHOICE','Workbooks combinent des visualisations, du texte, et des requêtes.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Oui',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Uniquement pour les métriques',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Uniquement pour les logs',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-900-244') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='azure_management_tools' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ-900-244',v_cert_id,v_theme_id,'Metrics Explorer permet-il d''explorer les métriques ?','easy','SINGLE_CHOICE','Metrics Explorer est un outil pour visualiser les métriques.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Oui',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Uniquement pour les VMs',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Uniquement pour le stockage',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-900-245') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='azure_management_tools' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ-900-245',v_cert_id,v_theme_id,'Un espace de travail Log Analytics est-il nécessaire pour collecter des logs ?','easy','SINGLE_CHOICE','Les logs sont envoyés vers un espace de travail Log Analytics.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Oui',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Uniquement pour les VMs',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Uniquement pour les applications',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-900-246') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='azure_management_tools' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ-900-246',v_cert_id,v_theme_id,'Les paramètres de diagnostic permettent-ils d''envoyer des logs vers Log Analytics ?','easy','SINGLE_CHOICE','Les paramètres de diagnostic peuvent envoyer les logs vers plusieurs destinations.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Oui',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Uniquement vers Storage',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Uniquement vers Event Hub',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-900-247') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='azure_management_tools' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ-900-247',v_cert_id,v_theme_id,'Le journal d''activité Azure enregistre-t-il les opérations de gestion ?','easy','SINGLE_CHOICE','Le journal d''activité contient toutes les opérations de gestion sur les ressources.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Oui',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Uniquement pour les VMs',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Uniquement pour les réseaux',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-900-248') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='azure_management_tools' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ-900-248',v_cert_id,v_theme_id,'Les verrous de ressources empêchent-ils la suppression accidentelle ?','easy','SINGLE_CHOICE','Les verrous (CanNotDelete, ReadOnly) protègent les ressources.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Oui',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Uniquement pour les VMs',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Uniquement pour les groupes de ressources',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-900-249') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='azure_management_tools' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ-900-249',v_cert_id,v_theme_id,'Azure Policy peut-il signaler les ressources non conformes ?','easy','SINGLE_CHOICE','Azure Policy évalue la conformité et peut signaler les non-conformités.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Oui',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Uniquement en audit',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Uniquement en deny',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AZ-900-250') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='azure_management_tools' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'AZ-900-250',v_cert_id,v_theme_id,'Azure Blueprints peut-il être versionné ?','easy','SINGLE_CHOICE','Les blueprints supportent le versioning.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Oui',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Uniquement avec des étiquettes',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Uniquement avec des snapshots',FALSE,3);
    END IF;
END $$;
-- ── TERRAFORM (260 questions) ──────
DO $$
DECLARE
    v_cert_id TEXT := 'terraform';
    v_theme_id UUID; v_q_id UUID; v_opt_id UUID;
BEGIN
    IF NOT EXISTS (SELECT 1 FROM certifications WHERE id = v_cert_id) THEN
        RAISE NOTICE 'Certification % absente', v_cert_id; RETURN;
    END IF;
    INSERT INTO certification_themes (id, certification_id, code, label, question_count, display_order)
    VALUES (uuid_generate_v4(), v_cert_id, 'terraform_basics', 'Terraform Basics', 0, 0)
    ON CONFLICT (certification_id, code) DO NOTHING;
    INSERT INTO certification_themes (id, certification_id, code, label, question_count, display_order)
    VALUES (uuid_generate_v4(), v_cert_id, 'configuration_language', 'Configuration Language', 0, 0)
    ON CONFLICT (certification_id, code) DO NOTHING;
    INSERT INTO certification_themes (id, certification_id, code, label, question_count, display_order)
    VALUES (uuid_generate_v4(), v_cert_id, 'state_management', 'State Management', 0, 0)
    ON CONFLICT (certification_id, code) DO NOTHING;
    INSERT INTO certification_themes (id, certification_id, code, label, question_count, display_order)
    VALUES (uuid_generate_v4(), v_cert_id, 'providers___modules', 'Providers & Modules', 0, 0)
    ON CONFLICT (certification_id, code) DO NOTHING;
    INSERT INTO certification_themes (id, certification_id, code, label, question_count, display_order)
    VALUES (uuid_generate_v4(), v_cert_id, 'cli_commands', 'CLI Commands', 0, 0)
    ON CONFLICT (certification_id, code) DO NOTHING;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='TF-01-001') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='terraform_basics' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'TF-01-001',v_cert_id,v_theme_id,'Qu''est-ce que Terraform ?','easy','SINGLE_CHOICE','Terraform permet de provisionner et gérer l''infrastructure de manière déclarative.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Outil d''infrastructure as code (IaC)',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Orchestrateur de conteneurs',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Base de données',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Langage de programmation',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='TF-01-002') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='terraform_basics' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'TF-01-002',v_cert_id,v_theme_id,'Quelle commande initialise un répertoire de travail Terraform ?','easy','SINGLE_CHOICE','terraform init initialise le répertoire, télécharge les providers et modules.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','terraform init',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','terraform start',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','terraform setup',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','terraform begin',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='TF-01-003') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='terraform_basics' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'TF-01-003',v_cert_id,v_theme_id,'Quel fichier contient par défaut l''état (state) de Terraform ?','easy','SINGLE_CHOICE','terraform.tfstate est le fichier d''état par défaut qui stocke les ressources provisionnées.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','terraform.tfstate',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','state.tf',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','terraform.json',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','.terraform/state',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='TF-01-004') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='terraform_basics' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'TF-01-004',v_cert_id,v_theme_id,'Que fait la commande ''terraform plan'' ?','easy','SINGLE_CHOICE','terraform plan montre les actions que Terraform va effectuer, sans les appliquer.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Affiche les changements à appliquer sans les exécuter',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Applique les changements',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Détruit les ressources',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Formate les fichiers',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='TF-01-005') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='terraform_basics' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'TF-01-005',v_cert_id,v_theme_id,'Que fait la commande ''terraform apply'' ?','easy','SINGLE_CHOICE','terraform apply exécute les actions nécessaires pour créer/mettre à jour les ressources.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Applique les changements pour atteindre l''état désiré',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Affiche le plan',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Détruit les ressources',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Initialise le répertoire',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='TF-01-006') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='terraform_basics' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'TF-01-006',v_cert_id,v_theme_id,'Que fait la commande ''terraform destroy'' ?','easy','SINGLE_CHOICE','terraform destroy détruit l''infrastructure provisionnée.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Supprime toutes les ressources gérées par Terraform',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Supprime le fichier d''état',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Supprime les providers',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Supprime le répertoire .terraform',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='TF-01-007') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='terraform_basics' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'TF-01-007',v_cert_id,v_theme_id,'Quel est le langage de configuration de Terraform ?','easy','SINGLE_CHOICE','HCL est le langage déclaratif de Terraform (fichiers .tf).','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','HCL (HashiCorp Configuration Language)',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','JSON',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','YAML',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Python',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='TF-01-008') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='terraform_basics' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'TF-01-008',v_cert_id,v_theme_id,'Terraform peut-il gérer plusieurs providers (AWS, Azure, GCP) dans le même projet ?','easy','SINGLE_CHOICE','Terraform est multi-cloud et peut utiliser plusieurs providers simultanément.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Oui',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Uniquement avec des workspaces',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Uniquement avec des modules',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='TF-01-009') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='terraform_basics' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'TF-01-009',v_cert_id,v_theme_id,'Quelle est l''extension des fichiers de configuration Terraform ?','easy','SINGLE_CHOICE','Les fichiers peuvent être en HCL (.tf) ou en JSON (.tf.json).','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','.tf',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','.tf.json',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','.hcl',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A et B',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='TF-01-010') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='terraform_basics' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'TF-01-010',v_cert_id,v_theme_id,'À quoi sert le fichier terraform.tfvars ?','easy','SINGLE_CHOICE','terraform.tfvars permet de passer des valeurs aux variables.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Définir les valeurs des variables',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Définir les providers',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Définir les resources',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Définir les outputs',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='TF-01-011') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='terraform_basics' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'TF-01-011',v_cert_id,v_theme_id,'Où sont stockés les providers téléchargés ?','easy','SINGLE_CHOICE','Les providers sont stockés dans le répertoire .terraform du projet ou globalement.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','.terraform/providers',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','~/.terraform.d/plugins',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','terraform.d/plugins',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A et B',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='TF-01-012') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='terraform_basics' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'TF-01-012',v_cert_id,v_theme_id,'Comment spécifier la version d''un provider ?','easy','SINGLE_CHOICE','La syntaxe required_providers avec version est la bonne.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','required_providers { aws = { source = ''hashicorp/aws'' version = ''~> 4.0'' } }',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','provider ''aws'' { version = ''4.0'' }',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','terraform { required_providers { aws = ''4.0'' } }',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A seulement',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='TF-01-013') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='terraform_basics' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'TF-01-013',v_cert_id,v_theme_id,'Quelle est la syntaxe pour déclarer une ressource AWS EC2 ?','easy','SINGLE_CHOICE','resource TYPE NAME { ... } est la syntaxe correcte.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','resource ''aws_instance'' ''web'' { ami = ''ami-123'' instance_type = ''t2.micro'' }',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','resource aws_instance web { ami = ''ami-123'' instance_type = ''t2.micro'' }',TRUE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','resource ''aws_instance'' ''web'' { }',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A et B',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='TF-01-014') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='terraform_basics' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'TF-01-014',v_cert_id,v_theme_id,'Comment déclarer une variable d''entrée ?','easy','SINGLE_CHOICE','variable ''nom'' { ... } déclare une variable.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','variable ''instance_type'' { type = string default = ''t2.micro'' }',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','var instance_type = ''t2.micro''',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','input variable instance_type { }',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A seulement',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='TF-01-015') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='terraform_basics' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'TF-01-015',v_cert_id,v_theme_id,'Comment référencer une variable dans une ressource ?','easy','SINGLE_CHOICE','var.nom ou ${var.nom} dans les anciennes versions.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','var.instance_type',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','${var.instance_type}',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','$var.instance_type',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A et B',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='TF-01-016') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='terraform_basics' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'TF-01-016',v_cert_id,v_theme_id,'À quoi sert un output ?','easy','SINGLE_CHOICE','Les outputs sont utiles pour afficher des informations (IP, ID) et pour la composition.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Afficher des informations après un apply',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Exporter des valeurs pour d''autres modules',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','A et B',TRUE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Définir des variables',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='TF-01-017') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='terraform_basics' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'TF-01-017',v_cert_id,v_theme_id,'Comment déclarer un output ?','easy','SINGLE_CHOICE','output ''nom'' { value = ... }.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','output ''instance_ip'' { value = aws_instance.web.public_ip }',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','output instance_ip = aws_instance.web.public_ip',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','output { value = aws_instance.web.public_ip }',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A seulement',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='TF-01-018') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='terraform_basics' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'TF-01-018',v_cert_id,v_theme_id,'À quoi sert un data source ?','easy','SINGLE_CHOICE','Les data sources permettent d''interroger l''infrastructure existante.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Lire des informations existantes (AMI, VPC, etc.)',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Créer des ressources',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Détruire des ressources',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Stocker des données',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='TF-01-019') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='terraform_basics' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'TF-01-019',v_cert_id,v_theme_id,'Syntaxe d''un data source AWS AMI ?','easy','SINGLE_CHOICE','data TYPE NAME { ... }.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','data ''aws_ami'' ''ubuntu'' { most_recent = true owners = [''099720109477''] }',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','data aws_ami ubuntu { most_recent = true }',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','data ''ami'' ''ubuntu'' { }',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A et B',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='TF-01-020') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='terraform_basics' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'TF-01-020',v_cert_id,v_theme_id,'À quoi servent les locals ?','easy','SINGLE_CHOICE','locals { common_tags = { Environment = ''prod'' } }','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Définir des valeurs calculées réutilisables',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Définir des variables d''entrée',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Définir des outputs',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Définir des providers',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='TF-01-021') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='terraform_basics' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'TF-01-021',v_cert_id,v_theme_id,'Comment référencer un local ?','easy','SINGLE_CHOICE','local.nom ou ${local.nom}.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','local.common_tags',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','${local.common_tags}',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','locals.common_tags',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A et B',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='TF-01-022') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='terraform_basics' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'TF-01-022',v_cert_id,v_theme_id,'Comment Terraform gère-t-il les dépendances entre ressources ?','easy','SINGLE_CHOICE','Terraform analyse les références, depends_on est optionnel pour des dépendances implicites.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Automatiquement via les références d''attributs',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Manuellement avec depends_on',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','A et B',TRUE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Uniquement avec depends_on',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='TF-01-023') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='terraform_basics' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'TF-01-023',v_cert_id,v_theme_id,'Quand utiliser depends_on ?','easy','SINGLE_CHOICE','depends_on crée une dépendance explicite.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Quand une ressource dépend d''une autre sans référence directe',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Toujours',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Jamais',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Uniquement pour les modules',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='TF-01-024') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='terraform_basics' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'TF-01-024',v_cert_id,v_theme_id,'Que fait count dans une ressource ?','easy','SINGLE_CHOICE','count = 3 crée 3 ressources identiques.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Crée plusieurs instances de la ressource',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Compte les ressources',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Limite le nombre',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A seulement',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='TF-01-025') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='terraform_basics' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'TF-01-025',v_cert_id,v_theme_id,'Comment accéder à l''index d''une ressource créée avec count ?','easy','SINGLE_CHOICE','count.index donne l''index (0,1,2...).','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','count.index',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','index',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','count',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A seulement',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='TF-01-026') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='terraform_basics' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'TF-01-026',v_cert_id,v_theme_id,'Quelle est la différence entre count et for_each ?','easy','SINGLE_CHOICE','for_each permet d''itérer sur une collection, créant des clés uniques.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','for_each fonctionne avec des map/set, count avec des nombres',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Identiques',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','for_each est plus lent',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','count est plus flexible',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='TF-01-027') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='terraform_basics' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'TF-01-027',v_cert_id,v_theme_id,'Comment accéder à la clé et la valeur dans for_each ?','easy','SINGLE_CHOICE','each.key et each.value sont disponibles.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','each.key, each.value',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','key, value',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','for_each.key',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A seulement',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='TF-01-028') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='terraform_basics' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'TF-01-028',v_cert_id,v_theme_id,'Quelles sont les règles de cycle de vie (lifecycle) possibles ?','easy','SINGLE_CHOICE','Ces meta-arguments contrôlent le comportement lors des modifications.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','create_before_destroy, prevent_destroy, ignore_changes',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','create_before_destroy seulement',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','prevent_destroy seulement',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','ignore_changes seulement',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='TF-01-029') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='terraform_basics' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'TF-01-029',v_cert_id,v_theme_id,'Que fait prevent_destroy ?','easy','SINGLE_CHOICE','utile pour les ressources critiques (bases de données).','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Empêche la destruction de la ressource',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Empêche la création',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Empêche la modification',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A seulement',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='TF-01-030') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='terraform_basics' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'TF-01-030',v_cert_id,v_theme_id,'Que fait create_before_destroy ?','easy','SINGLE_CHOICE','Évite les temps d''arrêt lors des remplacements.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Crée la nouvelle ressource avant de détruire l''ancienne',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Détruit avant de créer',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Crée en parallèle',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A seulement',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='TF-01-031') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='terraform_basics' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'TF-01-031',v_cert_id,v_theme_id,'À quoi servent les provisioners ?','easy','SINGLE_CHOICE','Ex: file, remote-exec, local-exec (à utiliser avec précaution).','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Exécuter des scripts sur les ressources après création',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Configurer les providers',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Définir des outputs',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Gérer l''état',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='TF-01-032') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='terraform_basics' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'TF-01-032',v_cert_id,v_theme_id,'Quel provisioner exécute des commandes sur la machine locale ?','easy','SINGLE_CHOICE','local-exec exécute des commandes sur la machine exécutant Terraform.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','local-exec',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','remote-exec',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','file',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','chef',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='TF-01-033') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='terraform_basics' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'TF-01-033',v_cert_id,v_theme_id,'Pourquoi les provisioners sont-ils déconseillés ?','easy','SINGLE_CHOICE','Préférer des outils de configuration comme Ansible ou des images préconfigurées.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Ils ne sont pas déclaratifs, peuvent échouer et ne sont pas idempotents',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Ils sont lents',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Ils sont payants',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A seulement',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='TF-01-034') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='terraform_basics' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'TF-01-034',v_cert_id,v_theme_id,'À quoi servent les workspaces ?','easy','SINGLE_CHOICE','Chaque workspace a son propre fichier d''état.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Gérer plusieurs environnements (dev, prod) avec le même code',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Partager l''état entre équipes',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Stocker des variables',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A seulement',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='TF-01-035') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='terraform_basics' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'TF-01-035',v_cert_id,v_theme_id,'Comment lister les workspaces ?','easy','SINGLE_CHOICE','list ou ls.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','terraform workspace list',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','terraform workspace ls',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','A et B',TRUE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','terraform workspace show',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='TF-01-036') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='terraform_basics' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'TF-01-036',v_cert_id,v_theme_id,'Comment créer un nouveau workspace ?','easy','SINGLE_CHOICE','new crée et bascule sur le nouveau workspace.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','terraform workspace new dev',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','terraform workspace create dev',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','terraform workspace add dev',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A seulement',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='TF-01-037') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='terraform_basics' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'TF-01-037',v_cert_id,v_theme_id,'Comment basculer vers un workspace existant ?','easy','SINGLE_CHOICE','select change le workspace actif.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','terraform workspace select dev',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','terraform workspace switch dev',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','terraform workspace use dev',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A seulement',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='TF-01-038') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='terraform_basics' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'TF-01-038',v_cert_id,v_theme_id,'Terraform Cloud offre-t-il la collaboration d''état ?','easy','SINGLE_CHOICE','Terraform Cloud permet le stockage distant de l''état et la collaboration.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Oui',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Uniquement avec Enterprise',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Uniquement avec Open Source',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='TF-01-039') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='terraform_basics' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'TF-01-039',v_cert_id,v_theme_id,'À quoi sert un backend ?','easy','SINGLE_CHOICE','Les backends distants permettent le travail en équipe.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Stocker l''état à distance (S3, GCS, Azure, etc.)',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Stocker les providers',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Stocker les modules',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A seulement',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='TF-01-040') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='terraform_basics' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'TF-01-040',v_cert_id,v_theme_id,'Comment configurer un backend S3 ?','easy','SINGLE_CHOICE','La configuration se fait dans le bloc terraform.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','terraform { backend ''s3'' { bucket = ''mybucket'' key = ''terraform.tfstate'' region = ''us-east-1'' } }',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','backend ''s3'' { }',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','terraform backend s3 { }',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A seulement',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='TF-01-041') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='terraform_basics' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'TF-01-041',v_cert_id,v_theme_id,'Le backend local est-il le backend par défaut ?','easy','SINGLE_CHOICE','Par défaut, l''état est stocké localement dans terraform.tfstate.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Oui',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Uniquement pour les workspaces',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Uniquement pour les modules',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='TF-01-042') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='terraform_basics' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'TF-01-042',v_cert_id,v_theme_id,'Peut-on migrer d''un backend local à un backend distant ?','easy','SINGLE_CHOICE','terraform init -migrate-state copie l''état local vers le backend distant.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Oui (terraform init -migrate-state)',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Uniquement avec Terraform Cloud',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Uniquement avec S3',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='TF-01-043') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='terraform_basics' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'TF-01-043',v_cert_id,v_theme_id,'Qu''est-ce que le Terraform Registry ?','easy','SINGLE_CHOICE','Le registry héberge des modules réutilisables et des providers.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Dépôt public de modules et providers',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Backend distant',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Outil de versioning',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Interface web',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='TF-01-044') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='terraform_basics' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'TF-01-044',v_cert_id,v_theme_id,'Comment utiliser un module du registry ?','easy','SINGLE_CHOICE','source pointe vers le module, version est optionnelle.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','module ''vpc'' { source = ''terraform-aws-modules/vpc/aws'' version = ''3.0.0'' }',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','module vpc { source = ''terraform-aws-modules/vpc/aws'' }',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','A et B',TRUE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A seulement',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='TF-01-045') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='terraform_basics' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'TF-01-045',v_cert_id,v_theme_id,'Quelle commande formate les fichiers Terraform ?','easy','SINGLE_CHOICE','terraform fmt reformate les fichiers .tf selon le style canonique.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','terraform fmt',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','terraform format',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','terraform tidy',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','terraform style',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='TF-01-046') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='terraform_basics' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'TF-01-046',v_cert_id,v_theme_id,'Quelle commande valide la syntaxe des fichiers Terraform ?','easy','SINGLE_CHOICE','validate vérifie la syntaxe et la cohérence interne.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','terraform validate',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','terraform check',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','terraform syntax',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','terraform verify',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='TF-01-047') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='terraform_basics' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'TF-01-047',v_cert_id,v_theme_id,'Comment activer les logs détaillés (debug) ?','easy','SINGLE_CHOICE','La variable d''environnement TF_LOG contrôle le niveau de log.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','export TF_LOG=DEBUG',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','terraform --debug',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','terraform plan -debug',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A seulement',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='TF-01-048') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='terraform_basics' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'TF-01-048',v_cert_id,v_theme_id,'Comment enregistrer les logs dans un fichier ?','easy','SINGLE_CHOICE','TF_LOG_PATH dirige les logs vers un fichier.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','export TF_LOG_PATH=terraform.log',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','terraform plan 2> terraform.log',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','A et B',TRUE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A seulement',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='TF-01-049') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='terraform_basics' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'TF-01-049',v_cert_id,v_theme_id,'Comment spécifier une version minimale de Terraform dans le code ?','easy','SINGLE_CHOICE','Le bloc terraform avec required_version.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','terraform { required_version = ''>= 1.0'' }',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','required_version = ''1.0''',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','version = ''1.0''',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A seulement',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='TF-01-050') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='terraform_basics' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'TF-01-050',v_cert_id,v_theme_id,'Que se passe-t-il si la version de Terraform ne correspond pas à required_version ?','easy','SINGLE_CHOICE','Terraform affiche une erreur et s''arrête.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Erreur au démarrage',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Warning seulement',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Terraform s''exécute normalement',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A seulement',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='TF-02-001') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='configuration_language' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'TF-02-001',v_cert_id,v_theme_id,'Quels sont les types primitifs dans Terraform ?','easy','SINGLE_CHOICE','Les types primitifs sont string, number, bool.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','string, number, bool',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','string, int, boolean',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','string, float, bool',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','string, number, boolean',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='TF-02-002') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='configuration_language' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'TF-02-002',v_cert_id,v_theme_id,'Quels sont les types de collection ?','easy','SINGLE_CHOICE','list (ordre), map (clé-valeur), set (unique, non ordonné).','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','list, map, set',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','array, dictionary, set',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','list, map, object',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','list, map, tuple',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='TF-02-003') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='configuration_language' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'TF-02-003',v_cert_id,v_theme_id,'Quelle est la différence entre list et tuple ?','easy','SINGLE_CHOICE','tuple = [string, number, bool] peut mélanger les types.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','tuple permet des types d''éléments différents, list non',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','list permet des types différents, tuple non',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Identiques',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','tuple est ordonné, list non',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='TF-02-004') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='configuration_language' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'TF-02-004',v_cert_id,v_theme_id,'Comment définir une variable avec une description ?','easy','SINGLE_CHOICE','description est optionnelle mais recommandée.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','variable ''name'' { type = string description = ''Le nom de la ressource'' }',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','variable ''name'' { description = ''...'' }',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','variable ''name'' (description = ''...'')',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A et B',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='TF-02-005') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='configuration_language' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'TF-02-005',v_cert_id,v_theme_id,'Comment définir une variable sensible (ne pas afficher dans les logs) ?','easy','SINGLE_CHOICE','sensitive = true masque la valeur dans les logs.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','sensitive = true',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','secret = true',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','hidden = true',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A seulement',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='TF-02-006') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='configuration_language' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'TF-02-006',v_cert_id,v_theme_id,'Comment passer une variable via la ligne de commande ?','easy','SINGLE_CHOICE','-var ''key=value'' ou -var key=value.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','-var ''instance_type=t2.micro''',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','--var instance_type=t2.micro',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','-var instance_type=t2.micro',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A et C',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='TF-02-007') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='configuration_language' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'TF-02-007',v_cert_id,v_theme_id,'Comment passer un fichier de variables ?','easy','SINGLE_CHOICE','-var-file est l''option.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','-var-file=dev.tfvars',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','-var-file dev.tfvars',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','--var-file dev.tfvars',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A et B',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='TF-02-008') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='configuration_language' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'TF-02-008',v_cert_id,v_theme_id,'Quel fichier de variables est automatiquement chargé ?','easy','SINGLE_CHOICE','Ces fichiers sont chargés automatiquement s''ils existent.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','terraform.tfvars, terraform.tfvars.json, *.auto.tfvars',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','variables.tf',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','terraform.tfvars seulement',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A seulement',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='TF-02-009') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='configuration_language' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'TF-02-009',v_cert_id,v_theme_id,'Quelle est la priorité des sources de variables ?','easy','SINGLE_CHOICE','La ligne de commande écrase les autres sources.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Ligne de commande > fichier auto > terraform.tfvars > variables par défaut',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','fichier auto > ligne de commande > variables par défaut',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','variables par défaut > terraform.tfvars > ligne de commande',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A seulement',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='TF-02-010') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='configuration_language' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'TF-02-010',v_cert_id,v_theme_id,'Quelle fonction concatène des listes ?','easy','SINGLE_CHOICE','concat([1,2], [3,4]) = [1,2,3,4].','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','concat',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','merge',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','join',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','flatten',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='TF-02-011') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='configuration_language' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'TF-02-011',v_cert_id,v_theme_id,'Quelle fonction fusionne des maps ?','easy','SINGLE_CHOICE','merge(map1, map2) combine les maps.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','merge',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','concat',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','map',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','join',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='TF-02-012') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='configuration_language' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'TF-02-012',v_cert_id,v_theme_id,'Quelle fonction retourne la longueur d''une liste ou d''une map ?','easy','SINGLE_CHOICE','length(list) retourne le nombre d''éléments.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','length',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','count',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','size',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','len',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='TF-02-013') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='configuration_language' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'TF-02-013',v_cert_id,v_theme_id,'Quelle fonction retourne un élément d''une liste par index ?','easy','SINGLE_CHOICE','element(list, index) retourne l''élément (avec wrap-around).','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','element',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','index',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','lookup',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','get',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='TF-02-014') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='configuration_language' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'TF-02-014',v_cert_id,v_theme_id,'Quelle fonction cherche une clé dans une map avec valeur par défaut ?','easy','SINGLE_CHOICE','lookup(map, key, default) est très utilisée.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','lookup',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','get',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','element',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','index',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='TF-02-015') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='configuration_language' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'TF-02-015',v_cert_id,v_theme_id,'Quelle fonction crée une map à partir d''une liste de paires clé-valeur ?','easy','SINGLE_CHOICE','zipmap([''a'',''b''], [1,2]) = {''a'':1,''b'':2}.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','map',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','tomap',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','merge',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','zipmap',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='TF-02-016') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='configuration_language' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'TF-02-016',v_cert_id,v_theme_id,'Quelle fonction retourne une sous-liste (slice) ?','easy','SINGLE_CHOICE','slice(list, start, end) fonctionne comme en Python.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','slice',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','substr',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','split',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','element',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='TF-02-017') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='configuration_language' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'TF-02-017',v_cert_id,v_theme_id,'Quelle fonction convertit une chaîne en liste en la divisant ?','easy','SINGLE_CHOICE','split('','', ''a,b,c'') = [''a'',''b'',''c''].','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','split',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','join',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','regex',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','chomp',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='TF-02-018') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='configuration_language' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'TF-02-018',v_cert_id,v_theme_id,'Quelle fonction combine une liste en chaîne avec un séparateur ?','easy','SINGLE_CHOICE','join('','', [''a'',''b'',''c'']) = ''a,b,c''.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','join',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','split',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','format',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','concat',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='TF-02-019') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='configuration_language' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'TF-02-019',v_cert_id,v_theme_id,'Quelle fonction formate une chaîne (comme printf) ?','easy','SINGLE_CHOICE','format(''Hello %s'', name).','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','format',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','sprintf',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','printf',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','formatstring',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='TF-02-020') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='configuration_language' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'TF-02-020',v_cert_id,v_theme_id,'Quelle fonction retourne la valeur absolue ?','easy','SINGLE_CHOICE','abs(-5) = 5.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','abs',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','absolut',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','absolute',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','math.abs',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='TF-02-021') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='configuration_language' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'TF-02-021',v_cert_id,v_theme_id,'Quelle fonction retourne le plus grand nombre ?','easy','SINGLE_CHOICE','max(5,12,9) = 12.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','max',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','maximum',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','biggest',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','maxnum',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='TF-02-022') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='configuration_language' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'TF-02-022',v_cert_id,v_theme_id,'Quelle fonction retourne le plus petit nombre ?','easy','SINGLE_CHOICE','min(5,12,9) = 5.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','min',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','minimum',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','smallest',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','minnum',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='TF-02-023') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='configuration_language' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'TF-02-023',v_cert_id,v_theme_id,'Quelle fonction encode une chaîne en base64 ?','easy','SINGLE_CHOICE','base64encode(''hello'') = ''aGVsbG8=''.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','base64encode',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','base64',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','b64encode',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','encodebase64',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='TF-02-024') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='configuration_language' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'TF-02-024',v_cert_id,v_theme_id,'Quelle fonction décode une chaîne base64 ?','easy','SINGLE_CHOICE','base64decode(''aGVsbG8='') = ''hello''.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','base64decode',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','base64',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','b64decode',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','decodebase64',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='TF-02-025') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='configuration_language' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'TF-02-025',v_cert_id,v_theme_id,'Syntaxe de l''opérateur conditionnel (ternaire) ?','easy','SINGLE_CHOICE','condition ? valeur_si_vrai : valeur_si_faux.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','condition ? value_true : value_false',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','if condition then value_true else value_false',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','cond ? value_true : value_false',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A et C',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='TF-02-026') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='configuration_language' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'TF-02-026',v_cert_id,v_theme_id,'Comment utiliser une condition avec count ?','easy','SINGLE_CHOICE','C''est un pattern courant pour rendre une ressource optionnelle.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','count = var.create ? 1 : 0',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','count = var.create ? 0 : 1',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','count = if(var.create) 1 else 0',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A seulement',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='TF-02-027') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='configuration_language' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'TF-02-027',v_cert_id,v_theme_id,'Syntaxe d''une for expression pour transformer une liste ?','easy','SINGLE_CHOICE','[for item in list : expression] produit une liste.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','[for s in var.list : upper(s)]',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','{for s in var.list => upper(s)}',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','for s in var.list { upper(s) }',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A seulement',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='TF-02-028') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='configuration_language' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'TF-02-028',v_cert_id,v_theme_id,'Syntaxe d''une for expression pour produire une map ?','easy','SINGLE_CHOICE','{for item in list : key => value} produit une map.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','{for s in var.list : s => upper(s)}',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','[for s in var.list : upper(s)]',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','map(for s in var.list : s => upper(s))',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A seulement',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='TF-02-029') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='configuration_language' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'TF-02-029',v_cert_id,v_theme_id,'Comment filtrer avec une for expression ?','easy','SINGLE_CHOICE','Les deux syntaxes sont valides.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','[for s in var.list : upper(s) if length(s) > 3]',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','[for s in var.list if length(s) > 3 : upper(s)]',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','A et B',TRUE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A seulement',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='TF-02-030') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='configuration_language' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'TF-02-030',v_cert_id,v_theme_id,'À quoi servent les dynamic blocks ?','easy','SINGLE_CHOICE','dynamic permet de générer des blocs imbriqués dynamiquement.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Générer des blocs répétés (ex: security_group_rules)',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Définir des variables',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Créer des modules',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A seulement',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='TF-02-031') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='configuration_language' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'TF-02-031',v_cert_id,v_theme_id,'Syntaxe d''un dynamic block ?','easy','SINGLE_CHOICE','dynamic ''nom'' { for_each = collection content { ... } }.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','dynamic ''rule'' { for_each = var.rules content { ... } }',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','dynamic rule { for_each = var.rules content { ... } }',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','dynamic ''rule'' { content { ... } }',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A et B',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='TF-02-032') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='configuration_language' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'TF-02-032',v_cert_id,v_theme_id,'Que fait l''opérateur * (splat) ?','easy','SINGLE_CHOICE','aws_instance.web[*].public_ip retourne toutes les IPs.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Récupère un attribut de tous les éléments d''une liste',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Multiplie les nombres',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','A et B',TRUE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A seulement',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='TF-02-033') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='configuration_language' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'TF-02-033',v_cert_id,v_theme_id,'Quelle est la différence entre * et [*] ?','easy','SINGLE_CHOICE','Les deux syntaxes sont équivalentes.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','identique, mais [*] est plus explicite',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','[*] est pour les listes, * pour les maps',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','* est déprécié',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A seulement',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='TF-02-034') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='configuration_language' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'TF-02-034',v_cert_id,v_theme_id,'Comment interpoler une valeur dans une chaîne ?','easy','SINGLE_CHOICE','${} est la syntaxe d''interpolation.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','${var.name}',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','$var.name',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','{var.name}',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A et B',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='TF-02-035') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='configuration_language' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'TF-02-035',v_cert_id,v_theme_id,'Comment écrire une chaîne multi-lignes ?','easy','SINGLE_CHOICE','Heredoc (<<-EOT) ou """ (multi-lignes).','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','<<-EOT
...
EOT',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B',''''''' ... ''''''',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','""" ... """',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A et C',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='TF-02-036') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='configuration_language' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'TF-02-036',v_cert_id,v_theme_id,'Quelle fonction applique une regex ?','easy','SINGLE_CHOICE','regex capture la première correspondance, regexall toutes.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','regex',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','match',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','regexall',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A et C',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='TF-02-037') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='configuration_language' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'TF-02-037',v_cert_id,v_theme_id,'Que retourne regex(''([a-z]+)'', ''hello world'') ?','easy','SINGLE_CHOICE','regex retourne la première capture.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','hello',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','world',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','[''hello'']',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','null',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='TF-02-038') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='configuration_language' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'TF-02-038',v_cert_id,v_theme_id,'Quelle fonction lit le contenu d''un fichier ?','easy','SINGLE_CHOICE','file(''path'') retourne le contenu sous forme de chaîne.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','file',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','readfile',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','templatefile',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','filecontent',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='TF-02-039') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='configuration_language' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'TF-02-039',v_cert_id,v_theme_id,'Quelle fonction lit un fichier et le traite comme un template ?','easy','SINGLE_CHOICE','templatefile(''script.sh.tpl'', { var = ''value'' })','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','templatefile',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','file',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','template',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','render',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='TF-02-040') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='configuration_language' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'TF-02-040',v_cert_id,v_theme_id,'Quelle fonction liste les fichiers d''un répertoire ?','easy','SINGLE_CHOICE','fileset(path, pattern) retourne une liste de fichiers.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','fileset',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','listdir',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','glob',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','filelist',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='TF-02-041') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='configuration_language' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'TF-02-041',v_cert_id,v_theme_id,'Comment convertir une liste en set ?','easy','SINGLE_CHOICE','toset(list) élimine les doublons.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','toset',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','set',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','newset',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','convert',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='TF-02-042') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='configuration_language' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'TF-02-042',v_cert_id,v_theme_id,'Comment convertir une map en liste de valeurs ?','easy','SINGLE_CHOICE','values(map) retourne une liste des valeurs.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','values',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','mapvalues',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','list',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','tolist',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='TF-02-043') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='configuration_language' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'TF-02-043',v_cert_id,v_theme_id,'Comment convertir une map en liste de clés ?','easy','SINGLE_CHOICE','keys(map) retourne une liste des clés.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','keys',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','mapkeys',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','keylist',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','tokeys',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='TF-02-044') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='configuration_language' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'TF-02-044',v_cert_id,v_theme_id,'Que fait la fonction try ?','easy','SINGLE_CHOICE','try(expr1, expr2, ...) retourne la première non nulle.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Essaye plusieurs expressions, retourne la première qui réussit',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Gère les exceptions',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','A et B',TRUE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A seulement',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='TF-02-045') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='configuration_language' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'TF-02-045',v_cert_id,v_theme_id,'Que fait la fonction can ?','easy','SINGLE_CHOICE','can(expr) retourne true si l''expression réussit.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Vérifie si une expression est valide sans erreur',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Essaye d''exécuter',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','A et B',TRUE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A seulement',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='TF-02-046') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='configuration_language' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'TF-02-046',v_cert_id,v_theme_id,'Quelle fonction retourne l''horodatage actuel (RFC3339) ?','easy','SINGLE_CHOICE','timestamp() retourne une chaîne comme ''2024-01-01T00:00:00Z''.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','timestamp',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','time',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','now',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','current_time',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='TF-02-047') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='configuration_language' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'TF-02-047',v_cert_id,v_theme_id,'Comment formater une date ?','easy','SINGLE_CHOICE','formatdate(''DD MMM YYYY'', timestamp())','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','formatdate',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','dateformat',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','format_time',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','strftime',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='TF-02-048') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='configuration_language' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'TF-02-048',v_cert_id,v_theme_id,'Quelle fonction ajoute une durée à un timestamp ?','easy','SINGLE_CHOICE','timeadd(timestamp, ''72h'') ajoute 72 heures.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','timeadd',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','addtime',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','timestamp_add',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','time_plus',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='TF-02-049') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='configuration_language' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'TF-02-049',v_cert_id,v_theme_id,'Quelle fonction calcule le MD5 d''une chaîne ?','easy','SINGLE_CHOICE','md5(''hello'') retourne le hash.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','md5',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','hash',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','md5sum',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','digest',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='TF-02-050') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='configuration_language' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'TF-02-050',v_cert_id,v_theme_id,'Quelle fonction calcule le SHA256 ?','easy','SINGLE_CHOICE','sha256(''hello'') retourne le hash.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','sha256',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','sha256sum',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','hash',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','digest256',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='TF-02-051') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='configuration_language' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'TF-02-051',v_cert_id,v_theme_id,'Quelle fonction génère un UUID aléatoire ?','easy','SINGLE_CHOICE','uuid() retourne un UUID v4.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','uuid',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','uuidv4',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','random_uuid',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A et B',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='TF-02-052') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='configuration_language' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'TF-02-052',v_cert_id,v_theme_id,'Quelle fonction encode en base64 ?','easy','SINGLE_CHOICE','base64encode(''hello'')','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','base64encode',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','b64encode',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','encodebase64',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A et B',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='TF-02-053') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='configuration_language' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'TF-02-053',v_cert_id,v_theme_id,'Quelle fonction parse une chaîne JSON ?','easy','SINGLE_CHOICE','jsondecode(''{"a":1}'') retourne une map.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','jsondecode',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','jsonparse',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','from_json',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','parsejson',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='TF-02-054') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='configuration_language' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'TF-02-054',v_cert_id,v_theme_id,'Quelle fonction encode une valeur en JSON ?','easy','SINGLE_CHOICE','jsonencode({a=1}) = ''{"a":1}''.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','jsonencode',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','to_json',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','jsonstring',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','json',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='TF-02-055') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='configuration_language' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'TF-02-055',v_cert_id,v_theme_id,'Quelle fonction parse une chaîne YAML ?','easy','SINGLE_CHOICE','yamldecode(''a: 1'') retourne une map.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','yamldecode',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','yamlparse',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','from_yaml',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','parseyaml',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='TF-02-056') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='configuration_language' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'TF-02-056',v_cert_id,v_theme_id,'Quelle fonction encode une valeur en YAML ?','easy','SINGLE_CHOICE','yamlencode({a=1}) = ''a: 1\n''.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','yamlencode',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','to_yaml',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','yamlstring',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','yaml',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='TF-02-057') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='configuration_language' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'TF-02-057',v_cert_id,v_theme_id,'Comment configurer un provider AWS avec une région ?','easy','SINGLE_CHOICE','provider ''aws'' { ... } ou provider aws { ... }.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','provider ''aws'' { region = ''us-east-1'' }',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','provider aws { region = ''us-east-1'' }',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','aws { region = ''us-east-1'' }',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A et B',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='TF-02-058') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='configuration_language' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'TF-02-058',v_cert_id,v_theme_id,'Comment utiliser plusieurs configurations d''un même provider (alias) ?','easy','SINGLE_CHOICE','alias permet d''avoir plusieurs configurations.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','provider ''aws'' { alias = ''west'' region = ''us-west-2'' }',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','provider aws { alias = ''west'' region = ''us-west-2'' }',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','A et B',TRUE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A seulement',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='TF-02-059') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='configuration_language' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'TF-02-059',v_cert_id,v_theme_id,'Comment référencer un provider avec alias dans une ressource ?','easy','SINGLE_CHOICE','provider = aws.west.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','provider = aws.west',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','provider = ''aws.west''',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','provider = aws.alias',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A et B',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='TF-02-060') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='configuration_language' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'TF-02-060',v_cert_id,v_theme_id,'Comment appeler un module ?','easy','SINGLE_CHOICE','module ''nom'' { source = ... }.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','module ''vpc'' { source = ''./modules/vpc'' }',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','module vpc { source = ''./modules/vpc'' }',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','A et B',TRUE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A seulement',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='TF-02-061') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='configuration_language' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'TF-02-061',v_cert_id,v_theme_id,'Comment accéder à un output d''un module ?','easy','SINGLE_CHOICE','module.nom.output.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','module.vpc.vpc_id',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','${module.vpc.vpc_id}',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','A et B',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','module[''vpc''].vpc_id',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='TF-02-062') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='configuration_language' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'TF-02-062',v_cert_id,v_theme_id,'Comment spécifier une version pour un module du registry ?','easy','SINGLE_CHOICE','version = ''...'' dans le bloc module.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','source = ''terraform-aws-modules/vpc/aws'' version = ''3.0.0''',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','source = ''terraform-aws-modules/vpc/aws@3.0.0''',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','A et B',TRUE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A seulement',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='TF-02-063') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='configuration_language' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'TF-02-063',v_cert_id,v_theme_id,'Que fait count dans un module ?','easy','SINGLE_CHOICE','count = 3 crée 3 modules.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Crée plusieurs instances du module',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Compte les modules',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','A et B',TRUE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A seulement',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='TF-02-064') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='configuration_language' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'TF-02-064',v_cert_id,v_theme_id,'Que fait for_each dans un module ?','easy','SINGLE_CHOICE','for_each = var.map crée un module par élément.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Crée une instance par élément d''une map/set',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Itère sur les modules',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','A et B',TRUE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A seulement',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='TF-02-065') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='configuration_language' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'TF-02-065',v_cert_id,v_theme_id,'Quels sont les types de sources pour les modules ?','easy','SINGLE_CHOICE','Source peut être locale, registry, git, etc.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Chemin local, Terraform Registry, Git, HTTP',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Seulement local',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Seulement Registry',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Seulement Git',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='TF-02-066') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='configuration_language' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'TF-02-066',v_cert_id,v_theme_id,'Comment utiliser un module depuis GitHub ?','easy','SINGLE_CHOICE','git:: devant l''URL.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','source = ''github.com/hashicorp/example''',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','source = ''git::https://github.com/hashicorp/example.git''',TRUE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','source = ''github.com/hashicorp/example.git''',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A et C',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='TF-02-067') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='configuration_language' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'TF-02-067',v_cert_id,v_theme_id,'Comment utiliser une branche spécifique d''un dépôt Git ?','easy','SINGLE_CHOICE','Le paramètre ref spécifie la branche/tag/commit.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','source = ''git::https://example.com/repo.git?ref=dev''',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','source = ''git::https://example.com/repo.git'' version = ''dev''',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','A et B',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A seulement',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='TF-02-068') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='configuration_language' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'TF-02-068',v_cert_id,v_theme_id,'Un module peut-il avoir des outputs ?','easy','SINGLE_CHOICE','Les outputs permettent de passer des données du module au parent.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Oui',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Uniquement les modules racine',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Uniquement les modules enfants',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='TF-02-069') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='configuration_language' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'TF-02-069',v_cert_id,v_theme_id,'Comment passer des variables à un module ?','easy','SINGLE_CHOICE','Les arguments du module sont les noms des variables.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','module ''vpc'' { source = ''./vpc'' cidr = ''10.0.0.0/16'' }',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','module ''vpc'' { source = ''./vpc'' var.cidr = ''10.0.0.0/16'' }',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','module ''vpc'' { source = ''./vpc'' cidr = var.cidr }',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A et C',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='TF-02-070') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='configuration_language' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'TF-02-070',v_cert_id,v_theme_id,'Comment exposer une valeur du module ?','easy','SINGLE_CHOICE','output ''nom'' { value = ... }.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','output ''vpc_id'' { value = aws_vpc.main.id }',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','output vpc_id { value = aws_vpc.main.id }',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','A et B',TRUE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A seulement',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='TF-03-001') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='state_management' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'TF-03-001',v_cert_id,v_theme_id,'Quel est le nom par défaut du fichier d''état local ?','easy','SINGLE_CHOICE','terraform.tfstate est le fichier d''état par défaut.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','terraform.tfstate',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','state.tf',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','terraform.state',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','tfstate.json',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='TF-03-002') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='state_management' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'TF-03-002',v_cert_id,v_theme_id,'À quoi sert le fichier terraform.tfstate.backup ?','easy','SINGLE_CHOICE','Terraform crée automatiquement une sauvegarde avant de modifier l''état.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Sauvegarde de l''état précédent avant modification',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Fichier d''état principal',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Fichier de verrouillage',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A seulement',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='TF-03-003') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='state_management' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'TF-03-003',v_cert_id,v_theme_id,'Pourquoi utiliser un backend distant pour l''état ?','easy','SINGLE_CHOICE','Les backends distants permettent le partage et la sécurisation de l''état.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Collaboration en équipe, sécurité, verrouillage',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Performance',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Simplicité',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A seulement',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='TF-03-004') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='state_management' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'TF-03-004',v_cert_id,v_theme_id,'Quels sont des backends distants courants ?','easy','SINGLE_CHOICE','De nombreux backends sont disponibles.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','S3, GCS, AzureRM, HTTP, Terraform Cloud',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Seulement S3',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Seulement Terraform Cloud',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Seulement HTTP',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='TF-03-005') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='state_management' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'TF-03-005',v_cert_id,v_theme_id,'Comment configurer un backend S3 ?','easy','SINGLE_CHOICE','Le bloc terraform avec backend.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','terraform { backend ''s3'' { bucket = ''mybucket'' key = ''terraform.tfstate'' region = ''us-east-1'' } }',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','backend ''s3'' { bucket = ''mybucket'' }',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','terraform backend s3 { }',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A seulement',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='TF-03-006') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='state_management' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'TF-03-006',v_cert_id,v_theme_id,'Que se passe-t-il si le backend n''est pas configuré ?','easy','SINGLE_CHOICE','Par défaut, l''état est local.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','L''état est stocké localement',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Erreur',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','L''état est stocké dans un fichier temporaire',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A seulement',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='TF-03-007') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='state_management' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'TF-03-007',v_cert_id,v_theme_id,'Comment migrer d''un état local vers un backend distant ?','easy','SINGLE_CHOICE','init -migrate-state copie l''état local vers le backend.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','terraform init -migrate-state',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','terraform apply -migrate-state',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','terraform state migrate',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A seulement',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='TF-03-008') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='state_management' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'TF-03-008',v_cert_id,v_theme_id,'Le verrouillage d''état (state locking) est-il supporté par S3 ?','easy','SINGLE_CHOICE','S3 nécessite une table DynamoDB pour le verrouillage.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Oui (via DynamoDB)',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Uniquement avec Terraform Cloud',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Uniquement avec GCS',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='TF-03-009') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='state_management' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'TF-03-009',v_cert_id,v_theme_id,'Comment configurer le verrouillage pour S3 ?','easy','SINGLE_CHOICE','L''option dynamodb_table active le verrouillage.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','dynamodb_table = ''terraform-lock''',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','lock_table = ''terraform-lock''',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','locking = true',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A seulement',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='TF-03-010') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='state_management' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'TF-03-010',v_cert_id,v_theme_id,'Que se passe-t-il si le verrouillage échoue ?','easy','SINGLE_CHOICE','Terraform attend et réessaie périodiquement.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','terraform attend que le verrou soit libéré',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','terraform force l''opération',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','terraform annule',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A seulement',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='TF-03-011') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='state_management' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'TF-03-011',v_cert_id,v_theme_id,'Quelle commande liste les ressources dans l''état ?','easy','SINGLE_CHOICE','state list et show (avec fichier) listent les ressources.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','terraform state list',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','terraform show',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','terraform state show',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A et B',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='TF-03-012') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='state_management' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'TF-03-012',v_cert_id,v_theme_id,'Comment afficher les détails d''une ressource dans l''état ?','easy','SINGLE_CHOICE','state show affiche une ressource spécifique.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','terraform state show ''aws_instance.web''',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','terraform show -state=terraform.tfstate',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','A et B',TRUE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A seulement',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='TF-03-013') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='state_management' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'TF-03-013',v_cert_id,v_theme_id,'Comment supprimer une ressource de l''état sans la détruire ?','easy','SINGLE_CHOICE','state rm retire la ressource de l''état.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','terraform state rm ''aws_instance.web''',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','terraform destroy -target=aws_instance.web',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','terraform state remove',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A seulement',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='TF-03-014') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='state_management' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'TF-03-014',v_cert_id,v_theme_id,'Comment renommer une ressource dans l''état ?','easy','SINGLE_CHOICE','state mv déplace/renomme une ressource.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','terraform state mv ''aws_instance.web'' ''aws_instance.app''',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','terraform state rename',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','terraform state move',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A seulement',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='TF-03-015') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='state_management' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'TF-03-015',v_cert_id,v_theme_id,'Comment importer une ressource existante dans l''état ?','easy','SINGLE_CHOICE','terraform import <ressource> <id>.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','terraform import aws_instance.web i-12345',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','terraform state import aws_instance.web i-12345',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','terraform import aws_instance.web',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A seulement',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='TF-03-016') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='state_management' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'TF-03-016',v_cert_id,v_theme_id,'Que fait `terraform refresh` ?','easy','SINGLE_CHOICE','refresh synchronise l''état sans modifier l''infrastructure.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Met à jour l''état avec la réalité du cloud',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Replanifie l''infrastructure',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','A et B',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A seulement',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='TF-03-017') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='state_management' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'TF-03-017',v_cert_id,v_theme_id,'Comment afficher l''état au format JSON ?','easy','SINGLE_CHOICE','show -json produit un JSON complet.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','terraform show -json',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','terraform state show -json',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','terraform output -json',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A et B',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='TF-03-018') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='state_management' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'TF-03-018',v_cert_id,v_theme_id,'Comment marquer une valeur comme sensible dans l''état ?','easy','SINGLE_CHOICE','sensitive = true masque la valeur dans les logs.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','output ''password'' { value = random_password.password.result sensitive = true }',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','sensitive = true dans la variable',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','A et B',TRUE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A seulement',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='TF-03-019') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='state_management' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'TF-03-019',v_cert_id,v_theme_id,'Les valeurs sensibles sont-elles stockées en clair dans le fichier d''état ?','easy','SINGLE_CHOICE','Le fichier d''état contient les valeurs en clair, donc il faut le sécuriser.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Oui',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Non (chiffrées)',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Seulement si backend distant',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A seulement',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='TF-03-020') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='state_management' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'TF-03-020',v_cert_id,v_theme_id,'Comment chiffrer l''état local ?','easy','SINGLE_CHOICE','L''état local n''est pas chiffré, il faut passer à un backend distant chiffré.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Non possible, utiliser un backend distant chiffré (S3 avec KMS)',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','terraform state encrypt',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','A et B',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A seulement',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='TF-03-021') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='state_management' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'TF-03-021',v_cert_id,v_theme_id,'Chaque workspace a-t-il son propre fichier d''état ?','easy','SINGLE_CHOICE','Chaque workspace a son propre fichier d''état (terraform.tfstate.d/<workspace>).','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Oui',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Uniquement pour les backends distants',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Uniquement pour les backends locaux',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='TF-03-022') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='state_management' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'TF-03-022',v_cert_id,v_theme_id,'Comment voir l''état du workspace actuel ?','easy','SINGLE_CHOICE','show affiche l''état du workspace actif.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','terraform show',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','terraform state show',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','A et B',TRUE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A seulement',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='TF-03-023') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='state_management' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'TF-03-023',v_cert_id,v_theme_id,'Peut-on lister les ressources de tous les workspaces ?','easy','SINGLE_CHOICE','Il faut basculer sur chaque workspace.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Non, un workspace à la fois',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Oui, avec terraform state list --all',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Oui, avec terraform workspace show',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A seulement',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='TF-03-024') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='state_management' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'TF-03-024',v_cert_id,v_theme_id,'L''état d''un module est-il inclus dans l''état racine ?','easy','SINGLE_CHOICE','L''état est unifié : toutes les ressources, y compris celles des modules.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Oui',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Uniquement pour les modules locaux',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Uniquement pour les modules du registry',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='TF-03-025') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='state_management' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'TF-03-025',v_cert_id,v_theme_id,'Comment référencer une ressource d''un module dans l''état ?','easy','SINGLE_CHOICE','La ressource est préfixée par module.nom.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','module.vpc.aws_vpc.main.id',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','aws_vpc.main.id',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','module.vpc.id',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A seulement',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='TF-03-026') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='state_management' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'TF-03-026',v_cert_id,v_theme_id,'Peut-on importer une ressource dans un module ?','easy','SINGLE_CHOICE','Le chemin de la ressource inclut le module.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Oui, avec terraform import module.vpc.aws_vpc.main vpc-123',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Non, impossible',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Oui, mais seulement si le module n''a pas de count',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A seulement',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='TF-03-027') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='state_management' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'TF-03-027',v_cert_id,v_theme_id,'Comment renommer un module dans l''état ?','easy','SINGLE_CHOICE','state mv peut déplacer des modules.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','terraform state mv ''module.old'' ''module.new''',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','terraform state rename-module',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Impossible',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A seulement',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='TF-03-028') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='state_management' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'TF-03-028',v_cert_id,v_theme_id,'Qu''est-ce que le backend ''remote'' ?','easy','SINGLE_CHOICE','Le backend ''remote'' est spécifique à Terraform Cloud.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Backend pour Terraform Cloud/Enterprise',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Backend distant générique',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','A et B',TRUE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A seulement',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='TF-03-029') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='state_management' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'TF-03-029',v_cert_id,v_theme_id,'Quel backend supporte les workspaces natifs ?','easy','SINGLE_CHOICE','Le backend remote est intégré à Terraform Cloud/Enterprise.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','remote',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','s3',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','gcs',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','azure',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='TF-03-030') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='state_management' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'TF-03-030',v_cert_id,v_theme_id,'Comment configurer le backend ''remote'' ?','easy','SINGLE_CHOICE','La configuration nécessite l''organisation et le workspace.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','terraform { backend ''remote'' { hostname = ''app.terraform.io'' organization = ''monorg'' workspaces { name = ''monworkspace'' } } }',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','backend ''remote'' { }',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','A et B',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A seulement',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='TF-03-031') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='state_management' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'TF-03-031',v_cert_id,v_theme_id,'Le backend ''remote'' supporte-t-il le verrouillage ?','easy','SINGLE_CHOICE','Le verrouillage est intégré.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Oui',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Uniquement avec Terraform Enterprise',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Uniquement avec Terraform Cloud',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='TF-03-032') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='state_management' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'TF-03-032',v_cert_id,v_theme_id,'Peut-on utiliser le backend ''remote'' sans Terraform Cloud ?','easy','SINGLE_CHOICE','Remote nécessite TFC ou TFE.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Non',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Oui, avec Terraform Enterprise',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Oui, avec un serveur HTTP',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A et B',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='TF-03-033') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='state_management' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'TF-03-033',v_cert_id,v_theme_id,'Dans une pipeline CI/CD, où stocker l''état ?','easy','SINGLE_CHOICE','L''état doit être partagé entre les exécutions, donc backend distant.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Backend distant (S3, GCS, etc.)',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Localement (dans le workspace CI)',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','A et B',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A seulement',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='TF-03-034') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='state_management' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'TF-03-034',v_cert_id,v_theme_id,'Comment éviter les conflits d''état en CI/CD ?','easy','SINGLE_CHOICE','Verrouillage et sérialisation.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Utiliser un backend avec verrouillage',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Exécuter les pipelines en série',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','A et B',TRUE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A seulement',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='TF-03-035') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='state_management' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'TF-03-035',v_cert_id,v_theme_id,'Quelle variable d''environnement permet de passer des variables à Terraform ?','easy','SINGLE_CHOICE','TF_VAR_<nom> définit une variable.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','TF_VAR_name',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','TF_VAR_name',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','VAR_name',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A et B',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='TF-03-036') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='state_management' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'TF-03-036',v_cert_id,v_theme_id,'Comment spécifier le chemin du fichier d''état ?','easy','SINGLE_CHOICE','L''option -state est disponible sur plusieurs commandes.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','terraform plan -state=chemin.tfstate',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','TF_STATE=chemin.tfstate',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','A et B',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A seulement',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='TF-03-037') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='state_management' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'TF-03-037',v_cert_id,v_theme_id,'Comment utiliser des workspaces en CI/CD ?','easy','SINGLE_CHOICE','Sélectionner ou créer le workspace avant apply.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','terraform workspace select dev',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','terraform workspace new dev',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','A et B',TRUE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A seulement',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='TF-03-038') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='state_management' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'TF-03-038',v_cert_id,v_theme_id,'Comment savoir si l''état a changé après un apply ?','easy','SINGLE_CHOICE','L''option -detailed-exitcode retourne 2 si des changements sont nécessaires.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','terraform plan -detailed-exitcode',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','terraform apply -auto-approve -detailed-exitcode',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','A et B',TRUE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A seulement',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='TF-03-039') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='state_management' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'TF-03-039',v_cert_id,v_theme_id,'Que fait l''option -auto-approve ?','easy','SINGLE_CHOICE','Utile pour l''automatisation.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Applique sans demander confirmation',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Planifie automatiquement',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','A et B',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A seulement',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='TF-03-040') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='state_management' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'TF-03-040',v_cert_id,v_theme_id,'Comment passer une variable de type map en CI/CD ?','easy','SINGLE_CHOICE','La valeur doit être une chaîne JSON.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','TF_VAR_tags=''{"env":"prod"}''',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','TF_VAR_tags=''{"env":"prod"}''',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','A et B',TRUE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A seulement',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='TF-03-041') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='state_management' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'TF-03-041',v_cert_id,v_theme_id,'Comment utiliser un fichier .tfvars en CI/CD ?','easy','SINGLE_CHOICE','-var-file est l''option.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','-var-file=prod.tfvars',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','-var-file prod.tfvars',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','A et B',TRUE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A seulement',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='TF-03-042') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='state_management' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'TF-03-042',v_cert_id,v_theme_id,'Comment intégrer Terraform dans GitHub Actions ?','easy','SINGLE_CHOICE','L''action setup-terraform installe Terraform.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','hashicorp/setup-terraform@v2',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','terraform apply',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','A et B',TRUE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A seulement',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='TF-03-043') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='state_management' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'TF-03-043',v_cert_id,v_theme_id,'Qu''est-ce que le backend ''http'' ?','easy','SINGLE_CHOICE','Le backend HTTP permet de stocker l''état via une API.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Backend utilisant une API HTTP REST',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Backend pour Terraform Cloud',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','A et B',TRUE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A seulement',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='TF-03-044') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='state_management' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'TF-03-044',v_cert_id,v_theme_id,'Comment configurer le backend HTTP ?','easy','SINGLE_CHOICE','address et update_method sont requis.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','backend ''http'' { address = ''https://example.com/state'' update_method = ''PUT'' }',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','backend ''http'' { url = ''https://example.com/state'' }',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','A et B',TRUE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A seulement',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='TF-03-045') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='state_management' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'TF-03-045',v_cert_id,v_theme_id,'Le backend HTTP supporte-t-il le verrouillage ?','easy','SINGLE_CHOICE','lock_address et unlock_address sont optionnels.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Oui (via lock_address)',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Uniquement avec Terraform Enterprise',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Uniquement avec Terraform Cloud',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='TF-03-046') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='state_management' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'TF-03-046',v_cert_id,v_theme_id,'Comment stocker l''état dans Git ?','easy','SINGLE_CHOICE','Il est déconseillé de versionner l''état dans Git.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Déconseillé (fichier binaire, secrets, conflits)',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Possible avec -state',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','A et B',TRUE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A seulement',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='TF-03-047') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='state_management' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'TF-03-047',v_cert_id,v_theme_id,'Comment partager l''état entre équipes sans backend distant ?','easy','SINGLE_CHOICE','Un backend distant est la solution recommandée.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Impossible, utiliser un backend distant',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Partager le fichier via un stockage partagé (NFS)',TRUE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','A et B',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A seulement',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='TF-03-048') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='state_management' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'TF-03-048',v_cert_id,v_theme_id,'Comment sécuriser l''état stocké dans S3 ?','easy','SINGLE_CHOICE','Le bucket doit être privé et chiffré.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Bucket privé, chiffrement KMS, bucket policies',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Bucket public',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','A et B',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A seulement',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='TF-03-049') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='state_management' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'TF-03-049',v_cert_id,v_theme_id,'Que se passe-t-il si deux personnes appliquent en même temps sans verrouillage ?','easy','SINGLE_CHOICE','Le verrouillage est essentiel pour éviter la corruption.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Corruption de l''état, conflits',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Terraform gère automatiquement',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','A et B',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A seulement',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='TF-03-050') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='state_management' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'TF-03-050',v_cert_id,v_theme_id,'Comment forcer le déverrouillage de l''état ?','easy','SINGLE_CHOICE','force-unlock déverrouille manuellement (danger).','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','terraform force-unlock <ID>',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','terraform state unlock <ID>',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','A et B',TRUE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A seulement',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='TF-04-001') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='providers___modules' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'TF-04-001',v_cert_id,v_theme_id,'Où Terraform télécharge-t-il les providers ?','easy','SINGLE_CHOICE','Le registry est la source par défaut, mais on peut spécifier d''autres sources.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Terraform Registry',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','GitHub',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','A et B',TRUE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A seulement',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='TF-04-002') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='providers___modules' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'TF-04-002',v_cert_id,v_theme_id,'Comment spécifier la source d''un provider personnalisé ?','easy','SINGLE_CHOICE','La source est définie dans required_providers.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','required_providers { mycloud = { source = ''mycorp/mycloud'' version = ''1.0'' } }',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','provider ''mycloud'' { source = ''mycorp/mycloud'' }',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','A et B',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A seulement',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='TF-04-003') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='providers___modules' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'TF-04-003',v_cert_id,v_theme_id,'Un provider peut-il être développé en Go ?','easy','SINGLE_CHOICE','Les providers sont écrits en Go et compilés en binaires.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Oui',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Uniquement en HCL',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Uniquement en JSON',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='TF-04-004') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='providers___modules' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'TF-04-004',v_cert_id,v_theme_id,'Comment mettre à jour les providers ?','easy','SINGLE_CHOICE','init -upgrade met à jour les providers selon les contraintes.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','terraform init -upgrade',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','terraform providers update',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','A et B',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A seulement',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='TF-04-005') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='providers___modules' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'TF-04-005',v_cert_id,v_theme_id,'Que fait la commande `terraform providers` ?','easy','SINGLE_CHOICE','providers liste les providers et leurs versions.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Affiche les providers requis par la configuration',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Installe les providers',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','A et B',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A seulement',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='TF-04-006') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='providers___modules' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'TF-04-006',v_cert_id,v_theme_id,'Peut-on avoir plusieurs versions d''un même provider dans un projet ?','easy','SINGLE_CHOICE','C''est possible mais complexe, généralement une seule version par projet.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Non',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Oui (avec des alias et configurations séparées)',TRUE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Oui, mais déconseillé',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A et B',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='TF-04-007') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='providers___modules' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'TF-04-007',v_cert_id,v_theme_id,'Comment spécifier un provider pour une ressource ?','easy','SINGLE_CHOICE','provider = alias.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','resource ''aws_instance'' ''web'' { provider = aws.west }',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','resource aws_instance web { provider = aws.west }',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','A et B',TRUE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A seulement',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='TF-04-008') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='providers___modules' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'TF-04-008',v_cert_id,v_theme_id,'Qu''est-ce qu''un module Terraform ?','easy','SINGLE_CHOICE','Les modules permettent la réutilisation et l''organisation.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Ensemble de ressources regroupées',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Un provider',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Une ressource',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A seulement',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='TF-04-009') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='providers___modules' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'TF-04-009',v_cert_id,v_theme_id,'Comment créer un module local ?','easy','SINGLE_CHOICE','Un module est simplement un répertoire contenant des fichiers Terraform.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Créer un dossier avec des fichiers .tf',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Définir un module dans un fichier',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','A et B',TRUE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A seulement',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='TF-04-010') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='providers___modules' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'TF-04-010',v_cert_id,v_theme_id,'Comment appeler un module local ?','easy','SINGLE_CHOICE','source = chemin relatif.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','module ''vpc'' { source = ''./modules/vpc'' }',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','module vpc { source = ''./modules/vpc'' }',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','A et B',TRUE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A seulement',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='TF-04-011') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='providers___modules' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'TF-04-011',v_cert_id,v_theme_id,'Quelles sont les bonnes pratiques pour les modules ?','easy','SINGLE_CHOICE','Les modules doivent être bien encapsulés.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Versionner les modules, documentation, outputs',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Variables en entrée, outputs en sortie',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','A et B',TRUE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A seulement',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='TF-04-012') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='providers___modules' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'TF-04-012',v_cert_id,v_theme_id,'Comment documenter un module ?','easy','SINGLE_CHOICE','terraform-docs génère automatiquement la documentation.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Commentaires dans les fichiers, README',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','terraform-docs',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','A et B',TRUE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A seulement',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='TF-04-013') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='providers___modules' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'TF-04-013',v_cert_id,v_theme_id,'Comment tester un module ?','easy','SINGLE_CHOICE','Terratest est un framework de test pour Terraform.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','terraform init && terraform plan dans un exemple',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Terratest',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','A et B',TRUE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A seulement',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='TF-04-014') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='providers___modules' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'TF-04-014',v_cert_id,v_theme_id,'Que sont les modules du Terraform Registry ?','easy','SINGLE_CHOICE','Le registry contient des modules publics et privés.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Modules publics partagés',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Modules privés (Terraform Cloud)',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','A et B',TRUE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A seulement',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='TF-04-015') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='providers___modules' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'TF-04-015',v_cert_id,v_theme_id,'Comment publier un module sur le registry ?','easy','SINGLE_CHOICE','Le registry s''intègre avec GitHub.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Suivre la convention de nommage, versionner, push sur GitHub',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Utiliser l''API Terraform Registry',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','A et B',TRUE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A seulement',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='TF-04-016') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='providers___modules' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'TF-04-016',v_cert_id,v_theme_id,'Quelle est la structure minimale d''un module ?','easy','SINGLE_CHOICE','Un seul fichier .tf suffit, mais la séparation est recommandée.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','main.tf, variables.tf, outputs.tf',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','main.tf seulement',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','A et B',TRUE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A seulement',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='TF-04-017') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='providers___modules' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'TF-04-017',v_cert_id,v_theme_id,'Comment versionner un module ?','easy','SINGLE_CHOICE','Les tags Git sont la méthode standard.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Git tags (v1.0.0)',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Fichier version.tf',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','A et B',TRUE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A seulement',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='TF-04-018') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='providers___modules' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'TF-04-018',v_cert_id,v_theme_id,'Comment utiliser une version spécifique d''un module du registry ?','easy','SINGLE_CHOICE','version = ''...'' est la syntaxe.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','module ''vpc'' { source = ''terraform-aws-modules/vpc/aws'' version = ''3.0.0'' }',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','module ''vpc'' { source = ''terraform-aws-modules/vpc/aws@3.0.0'' }',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','A et B',TRUE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A seulement',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='TF-04-019') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='providers___modules' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'TF-04-019',v_cert_id,v_theme_id,'Comment passer des providers à un module ?','easy','SINGLE_CHOICE','Par défaut, le module utilise les providers du parent.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Les providers sont hérités par défaut',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','provider = aws.west dans le module',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','A et B',TRUE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A seulement',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='TF-04-020') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='providers___modules' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'TF-04-020',v_cert_id,v_theme_id,'Comment spécifier un provider différent pour un module ?','easy','SINGLE_CHOICE','providers = { nom_local = alias } dans l''appel du module.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','providers = { aws = aws.west }',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','provider = aws.west',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','A et B',TRUE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A seulement',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='TF-04-021') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='providers___modules' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'TF-04-021',v_cert_id,v_theme_id,'Un module peut-il avoir ses propres providers ?','easy','SINGLE_CHOICE','Un module peut déclarer required_providers.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Oui',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Uniquement les providers racine',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Uniquement les providers distants',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='TF-04-022') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='providers___modules' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'TF-04-022',v_cert_id,v_theme_id,'Comment éviter de répéter les mêmes variables dans plusieurs modules ?','easy','SINGLE_CHOICE','Les valeurs peuvent être centralisées.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Utiliser un fichier variables.tfvars global',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Utiliser des variables d''environnement',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','A et B',TRUE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A seulement',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='TF-04-023') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='providers___modules' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'TF-04-023',v_cert_id,v_theme_id,'Comment partager des outputs entre modules ?','easy','SINGLE_CHOICE','Le parent peut accéder aux outputs des modules.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Output du module enfant, utilisé par le parent',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Data sources',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','A et B',TRUE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A seulement',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='TF-04-024') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='providers___modules' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'TF-04-024',v_cert_id,v_theme_id,'Que sont les modules nested ?','easy','SINGLE_CHOICE','La composition de modules est recommandée.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Modules appelant d''autres modules',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Modules imbriqués',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','A et B',TRUE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A seulement',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='TF-04-025') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='providers___modules' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'TF-04-025',v_cert_id,v_theme_id,'Comment gérer les dépendances entre modules ?','easy','SINGLE_CHOICE','Les références créent des dépendances implicites.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Automatiquement via les références d''outputs',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','depends_on',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','A et B',TRUE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A seulement',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='TF-04-026') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='providers___modules' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'TF-04-026',v_cert_id,v_theme_id,'Peut-on avoir des cycles entre modules ?','easy','SINGLE_CHOICE','Les cycles ne sont pas autorisés.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Non, interdit',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Oui, avec depends_on',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Oui, mais déconseillé',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A seulement',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='TF-04-027') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='providers___modules' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'TF-04-027',v_cert_id,v_theme_id,'Comment forcer le rechargement d''un module ?','easy','SINGLE_CHOICE','init -upgrade met à jour les modules.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','terraform get -update',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','terraform init -upgrade',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','A et B',TRUE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A seulement',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='TF-04-028') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='providers___modules' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'TF-04-028',v_cert_id,v_theme_id,'Où sont stockés les modules téléchargés ?','easy','SINGLE_CHOICE','Les modules sont dans .terraform/modules.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','.terraform/modules',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','~/.terraform.d/modules',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','A et B',TRUE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A seulement',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='TF-04-029') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='providers___modules' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'TF-04-029',v_cert_id,v_theme_id,'Comment utiliser un module depuis un dépôt Git privé ?','easy','SINGLE_CHOICE','Utiliser git:: devant l''URL.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','source = ''git::https://github.com/org/repo.git''',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','source = ''git::ssh://git@github.com/org/repo.git''',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','A et B',TRUE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A seulement',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='TF-04-030') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='providers___modules' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'TF-04-030',v_cert_id,v_theme_id,'Comment utiliser un sous-répertoire d''un dépôt Git comme module ?','easy','SINGLE_CHOICE','// après l''URL indique le sous-répertoire.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','source = ''git::https://github.com/org/repo.git//modules/vpc''',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','source = ''git::https://github.com/org/repo.git?ref=v1.0//modules/vpc''',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','A et B',TRUE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A seulement',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='TF-04-031') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='providers___modules' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'TF-04-031',v_cert_id,v_theme_id,'Peut-on utiliser un module depuis un registry privé ?','easy','SINGLE_CHOICE','Terraform Cloud/Enterprise a un registry privé.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Oui (Terraform Cloud/Enterprise)',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Uniquement public',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A et B',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='TF-04-032') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='providers___modules' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'TF-04-032',v_cert_id,v_theme_id,'Comment référencer une ressource d''un module avec count ?','easy','SINGLE_CHOICE','La syntaxe avec [index] est correcte.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','module.vpc[0].vpc_id',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','module.vpc.0.vpc_id',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','A et B',TRUE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A seulement',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='TF-04-033') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='providers___modules' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'TF-04-033',v_cert_id,v_theme_id,'Comment référencer une ressource d''un module avec for_each ?','easy','SINGLE_CHOICE','La syntaxe avec [''clé''].','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','module.vpc[''dev''].vpc_id',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','module.vpc.dev.vpc_id',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','A et B',TRUE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A seulement',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='TF-04-034') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='providers___modules' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'TF-04-034',v_cert_id,v_theme_id,'Un module peut-il contenir des data sources ?','easy','SINGLE_CHOICE','Les data sources sont autorisées dans les modules.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Oui',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Uniquement les modules racine',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Uniquement les modules enfants',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='TF-04-035') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='providers___modules' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'TF-04-035',v_cert_id,v_theme_id,'Comment rendre un module paramétrable ?','easy','SINGLE_CHOICE','Les variables sont la clé de la flexibilité.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Définir des variables d''entrée',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Utiliser des locals',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','A et B',TRUE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A seulement',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='TF-04-036') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='providers___modules' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'TF-04-036',v_cert_id,v_theme_id,'Comment valider qu''un module est correct avant de le publier ?','easy','SINGLE_CHOICE','validate vérifie la syntaxe, fmt le style.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','terraform validate',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','terraform fmt',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','A et B',TRUE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A seulement',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='TF-04-037') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='providers___modules' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'TF-04-037',v_cert_id,v_theme_id,'Qu''est-ce que le module registry ?','easy','SINGLE_CHOICE','registry.terraform.io.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Dépôt public de modules',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Service de stockage',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','A et B',TRUE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A seulement',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='TF-04-038') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='providers___modules' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'TF-04-038',v_cert_id,v_theme_id,'Comment trouver des modules existants ?','easy','SINGLE_CHOICE','Le registry a une fonction de recherche.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Recherche sur le Terraform Registry',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','terraform search',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','A et B',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A seulement',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='TF-04-039') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='providers___modules' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'TF-04-039',v_cert_id,v_theme_id,'Qu''est-ce que le module versioning sémantique ?','easy','SINGLE_CHOICE','Le versioning sémantique est recommandé.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','MAJOR.MINOR.PATCH',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','v1.0.0',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','A et B',TRUE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A seulement',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='TF-04-040') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='providers___modules' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'TF-04-040',v_cert_id,v_theme_id,'Que signifie ~> dans une contrainte de version ?','easy','SINGLE_CHOICE','Permet les versions compatibles.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Pessimistic constraint (ex: ~> 1.0 = >=1.0, <2.0)',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Approximative',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','A et B',TRUE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A seulement',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='TF-04-041') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='providers___modules' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'TF-04-041',v_cert_id,v_theme_id,'Quelle est la différence entre = et == ?','easy','SINGLE_CHOICE','En HCL, = est pour les attributs, == pour les conditions.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Identiques en HCL',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','= est assignation, == est égalité',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','A et B',TRUE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A seulement',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='TF-04-042') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='providers___modules' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'TF-04-042',v_cert_id,v_theme_id,'Peut-on utiliser des providers communautaires ?','easy','SINGLE_CHOICE','Le registry contient des providers communautaires.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Oui',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Uniquement HashiCorp',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Uniquement vérifiés',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='TF-04-043') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='providers___modules' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'TF-04-043',v_cert_id,v_theme_id,'Comment spécifier un provider avec une version ?','easy','SINGLE_CHOICE','Les deux syntaxes sont valides, mais required_providers est préféré.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','required_providers { aws = { source = ''hashicorp/aws'' version = ''~> 4.0'' } }',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','provider ''aws'' { version = ''~> 4.0'' }',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','A et B',TRUE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A seulement',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='TF-04-044') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='providers___modules' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'TF-04-044',v_cert_id,v_theme_id,'Que se passe-t-il si une version de provider n''est pas spécifiée ?','easy','SINGLE_CHOICE','Terraform prend la dernière version disponible.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','La dernière version est utilisée',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Erreur',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','A et B',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A seulement',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='TF-04-045') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='providers___modules' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'TF-04-045',v_cert_id,v_theme_id,'Comment verrouiller les versions des providers ?','easy','SINGLE_CHOICE','Le lock file (.terraform.lock.hcl) enregistre les versions exactes.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','terraform providers lock',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','terraform init -lockfile=readonly',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','A et B',TRUE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A seulement',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='TF-04-046') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='providers___modules' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'TF-04-046',v_cert_id,v_theme_id,'Où est stocké le lock file ?','easy','SINGLE_CHOICE','Le fichier de verrouillage des providers.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','.terraform.lock.hcl',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','terraform.lock.hcl',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','lock.hcl',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A seulement',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='TF-04-047') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='providers___modules' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'TF-04-047',v_cert_id,v_theme_id,'Doit-on versionner le lock file ?','easy','SINGLE_CHOICE','Il est recommandé de le versionner.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Oui (pour la reproductibilité)',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Optionnel',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A seulement',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='TF-04-048') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='providers___modules' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'TF-04-048',v_cert_id,v_theme_id,'Comment mettre à jour le lock file ?','easy','SINGLE_CHOICE','init -upgrade met à jour les providers et le lock file.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','terraform init -upgrade',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','terraform providers lock',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','A et B',TRUE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A seulement',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='TF-04-049') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='providers___modules' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'TF-04-049',v_cert_id,v_theme_id,'Que signifie le provider ''hashicorp/aws'' ?','easy','SINGLE_CHOICE','Le namespace ''hashicorp'' indique un provider officiel.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Provider AWS officiel de HashiCorp',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Provider communautaire',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','A et B',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A seulement',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='TF-04-050') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='providers___modules' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'TF-04-050',v_cert_id,v_theme_id,'Peut-on créer un provider personnalisé ?','easy','SINGLE_CHOICE','Les providers personnalisés sont des binaires Go.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Oui, en développant en Go',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Oui, en HCL',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A et B',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='TF-05-001') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='cli_commands' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'TF-05-001',v_cert_id,v_theme_id,'Quelle commande initialise un répertoire Terraform ?','easy','SINGLE_CHOICE','init télécharge les providers et initialise les modules.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','terraform init',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','terraform start',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','terraform setup',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','terraform begin',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='TF-05-002') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='cli_commands' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'TF-05-002',v_cert_id,v_theme_id,'Quelle commande formate les fichiers ?','easy','SINGLE_CHOICE','fmt reformate les fichiers .tf selon le style canonique.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','terraform fmt',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','terraform format',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','terraform style',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','terraform lint',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='TF-05-003') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='cli_commands' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'TF-05-003',v_cert_id,v_theme_id,'Quelle commande valide la configuration ?','easy','SINGLE_CHOICE','validate vérifie la syntaxe et la cohérence.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','terraform validate',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','terraform check',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','terraform verify',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','terraform syntax',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='TF-05-004') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='cli_commands' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'TF-05-004',v_cert_id,v_theme_id,'Quelle commande montre le plan d''exécution ?','easy','SINGLE_CHOICE','plan affiche les changements à appliquer.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','terraform plan',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','terraform show',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','terraform graph',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','terraform output',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='TF-05-005') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='cli_commands' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'TF-05-005',v_cert_id,v_theme_id,'Quelle commande applique les changements ?','easy','SINGLE_CHOICE','apply applique le plan.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','terraform apply',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','terraform run',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','terraform deploy',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','terraform execute',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='TF-05-006') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='cli_commands' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'TF-05-006',v_cert_id,v_theme_id,'Quelle commande détruit l''infrastructure ?','easy','SINGLE_CHOICE','destroy supprime toutes les ressources.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','terraform destroy',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','terraform remove',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','terraform delete',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','terraform down',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='TF-05-007') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='cli_commands' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'TF-05-007',v_cert_id,v_theme_id,'Quelle commande affiche l''état actuel ?','easy','SINGLE_CHOICE','show et state list affichent l''état.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','terraform show',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','terraform state list',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','terraform output',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A et B',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='TF-05-008') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='cli_commands' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'TF-05-008',v_cert_id,v_theme_id,'Quelle commande affiche les outputs ?','easy','SINGLE_CHOICE','output affiche les outputs définis.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','terraform output',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','terraform show -output',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','A et B',TRUE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A seulement',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='TF-05-009') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='cli_commands' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'TF-05-009',v_cert_id,v_theme_id,'Quelle commande affiche le graphe des dépendances ?','easy','SINGLE_CHOICE','graph produit un DOT pour visualisation.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','terraform graph',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','terraform dependencies',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','terraform diagram',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','terraform web',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='TF-05-010') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='cli_commands' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'TF-05-010',v_cert_id,v_theme_id,'Comment afficher l''aide d''une commande ?','easy','SINGLE_CHOICE','-h ou help.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','terraform <cmd> -h',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','terraform help <cmd>',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','A et B',TRUE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A seulement',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='TF-05-011') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='cli_commands' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'TF-05-011',v_cert_id,v_theme_id,'Que fait `terraform version` ?','easy','SINGLE_CHOICE','version montre la version de Terraform et des providers.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Affiche la version de Terraform',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Affiche la version des providers',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','A et B',TRUE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A seulement',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='TF-05-012') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='cli_commands' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'TF-05-012',v_cert_id,v_theme_id,'Que fait `terraform workspace` ?','easy','SINGLE_CHOICE','workspace est une commande pour gérer les workspaces.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Gère les workspaces',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Affiche le workspace actuel',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','A et B',TRUE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A seulement',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='TF-05-013') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='cli_commands' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'TF-05-013',v_cert_id,v_theme_id,'Comment spécifier un fichier de variables ?','easy','SINGLE_CHOICE','-var-file accepte les deux syntaxes.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','-var-file=dev.tfvars',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','-var-file dev.tfvars',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','A et B',TRUE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A seulement',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='TF-05-014') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='cli_commands' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'TF-05-014',v_cert_id,v_theme_id,'Comment cibler une ressource spécifique ?','easy','SINGLE_CHOICE','-target=ressource ou -target ressource.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','-target=aws_instance.web',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','-target aws_instance.web',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','A et B',TRUE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A seulement',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='TF-05-015') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='cli_commands' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'TF-05-015',v_cert_id,v_theme_id,'Comment appliquer sans confirmation ?','easy','SINGLE_CHOICE','-auto-approve pour l''automatisation.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','-auto-approve',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','-force',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','-yes',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A seulement',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='TF-05-016') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='cli_commands' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'TF-05-016',v_cert_id,v_theme_id,'Comment limiter le nombre de ressources parallèles ?','easy','SINGLE_CHOICE','-parallelism contrôle le parallélisme.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','-parallelism=10',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','-concurrency=10',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','-max-parallel=10',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A seulement',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='TF-05-017') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='cli_commands' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'TF-05-017',v_cert_id,v_theme_id,'Comment afficher les logs détaillés ?','easy','SINGLE_CHOICE','TF_LOG=DEBUG ou -debug (certaines commandes).','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','-debug',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','-v',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','-verbose',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A et B',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='TF-05-018') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='cli_commands' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'TF-05-018',v_cert_id,v_theme_id,'Comment spécifier le fichier d''état ?','easy','SINGLE_CHOICE','-state=chemin.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','-state=chemin',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','-state chemin',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','A et B',TRUE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A seulement',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='TF-05-019') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='cli_commands' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'TF-05-019',v_cert_id,v_theme_id,'Comment générer un plan au format JSON ?','easy','SINGLE_CHOICE','-json produit une sortie JSON.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','terraform plan -json',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','terraform plan -out=tfplan -json',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','A et B',TRUE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A seulement',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='TF-05-020') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='cli_commands' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'TF-05-020',v_cert_id,v_theme_id,'Comment enregistrer un plan dans un fichier ?','easy','SINGLE_CHOICE','plan -out enregistre le plan binaire.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','terraform plan -out=tfplan',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','terraform apply -out=tfplan',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','A et B',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A seulement',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='TF-05-021') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='cli_commands' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'TF-05-021',v_cert_id,v_theme_id,'Comment appliquer un plan enregistré ?','easy','SINGLE_CHOICE','apply tfplan utilise le plan sauvegardé.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','terraform apply tfplan',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','terraform apply -auto-approve tfplan',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','A et B',TRUE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A seulement',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='TF-05-022') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='cli_commands' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'TF-05-022',v_cert_id,v_theme_id,'Comment rafraîchir l''état sans appliquer ?','easy','SINGLE_CHOICE','refresh et apply -refresh-only synchronisent l''état.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','terraform refresh',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','terraform apply -refresh-only',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','A et B',TRUE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A seulement',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='TF-05-023') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='cli_commands' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'TF-05-023',v_cert_id,v_theme_id,'Comment lister les ressources dans l''état ?','easy','SINGLE_CHOICE','state list est la commande.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','terraform state list',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','terraform state list',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','terraform show -list',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A et B',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='TF-05-024') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='cli_commands' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'TF-05-024',v_cert_id,v_theme_id,'Comment afficher une ressource spécifique ?','easy','SINGLE_CHOICE','state show affiche la ressource.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','terraform state show aws_instance.web',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','terraform show aws_instance.web',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','A et B',TRUE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A seulement',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='TF-05-025') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='cli_commands' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'TF-05-025',v_cert_id,v_theme_id,'Comment supprimer une ressource de l''état ?','easy','SINGLE_CHOICE','state rm retire la ressource de l''état.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','terraform state rm aws_instance.web',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','terraform state remove aws_instance.web',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','A et B',TRUE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A seulement',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='TF-05-026') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='cli_commands' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'TF-05-026',v_cert_id,v_theme_id,'Comment déplacer une ressource dans l''état ?','easy','SINGLE_CHOICE','state mv renomme/déplace.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','terraform state mv aws_instance.web aws_instance.app',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','terraform state move aws_instance.web aws_instance.app',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','A et B',TRUE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A seulement',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='TF-05-027') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='cli_commands' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'TF-05-027',v_cert_id,v_theme_id,'Comment importer une ressource existante ?','easy','SINGLE_CHOICE','import associe une ressource existante à l''état.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','terraform import aws_instance.web i-12345',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','terraform import module.vpc.aws_instance.web i-12345',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','A et B',TRUE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A seulement',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='TF-05-028') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='cli_commands' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'TF-05-028',v_cert_id,v_theme_id,'Comment créer un nouveau workspace ?','easy','SINGLE_CHOICE','new crée et bascule.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','terraform workspace new dev',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','terraform workspace create dev',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','A et B',TRUE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A seulement',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='TF-05-029') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='cli_commands' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'TF-05-029',v_cert_id,v_theme_id,'Comment lister les workspaces ?','easy','SINGLE_CHOICE','list ou ls.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','terraform workspace list',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','terraform workspace ls',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','A et B',TRUE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A seulement',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='TF-05-030') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='cli_commands' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'TF-05-030',v_cert_id,v_theme_id,'Comment basculer vers un workspace ?','easy','SINGLE_CHOICE','select change le workspace actif.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','terraform workspace select dev',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','terraform workspace switch dev',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','A et B',TRUE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A seulement',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='TF-05-031') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='cli_commands' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'TF-05-031',v_cert_id,v_theme_id,'Comment afficher le workspace actuel ?','easy','SINGLE_CHOICE','show affiche le workspace courant.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','terraform workspace show',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','terraform workspace current',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','A et B',TRUE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A seulement',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='TF-05-032') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='cli_commands' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'TF-05-032',v_cert_id,v_theme_id,'Comment lister les providers requis ?','easy','SINGLE_CHOICE','providers affiche les providers nécessaires.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','terraform providers',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','terraform providers list',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','A et B',TRUE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A seulement',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='TF-05-033') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='cli_commands' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'TF-05-033',v_cert_id,v_theme_id,'Comment mettre à jour les providers ?','easy','SINGLE_CHOICE','init -upgrade met à jour les providers.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','terraform init -upgrade',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','terraform get -update',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','A et B',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A seulement',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='TF-05-034') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='cli_commands' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'TF-05-034',v_cert_id,v_theme_id,'Comment verrouiller les versions exactes des providers ?','easy','SINGLE_CHOICE','providers lock génère le lock file.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','terraform providers lock',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','terraform lock providers',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','A et B',TRUE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A seulement',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='TF-05-035') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='cli_commands' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'TF-05-035',v_cert_id,v_theme_id,'Où sont stockés les providers ?','easy','SINGLE_CHOICE','Les providers peuvent être dans .terraform ou globalement.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','.terraform/providers',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','~/.terraform.d/plugins',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','A et B',TRUE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A seulement',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='TF-05-036') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='cli_commands' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'TF-05-036',v_cert_id,v_theme_id,'Comment activer les logs de débogage ?','easy','SINGLE_CHOICE','TF_LOG et TF_LOG_PATH contrôlent les logs.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','export TF_LOG=DEBUG',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','export TF_LOG_PATH=terraform.log',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','A et B',TRUE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A seulement',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='TF-05-037') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='cli_commands' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'TF-05-037',v_cert_id,v_theme_id,'Quels niveaux de log sont disponibles ?','easy','SINGLE_CHOICE','TRACE est le plus détaillé.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','TRACE, DEBUG, INFO, WARN, ERROR',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','DEBUG, INFO, ERROR',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','INFO, WARN, ERROR',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A seulement',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='TF-05-038') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='cli_commands' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'TF-05-038',v_cert_id,v_theme_id,'Comment générer un fichier de plan lisible ?','easy','SINGLE_CHOICE','show -json convertit le plan binaire en JSON.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','terraform plan -out=tfplan',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','terraform show -json tfplan > plan.json',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','A et B',TRUE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A seulement',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='TF-05-039') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='cli_commands' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'TF-05-039',v_cert_id,v_theme_id,'Comment voir les ressources qui seront modifiées ?','easy','SINGLE_CHOICE','plan montre les changements.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','terraform plan',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','terraform state list',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','A et B',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A seulement',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='TF-05-040') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='cli_commands' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'TF-05-040',v_cert_id,v_theme_id,'Comment forcer le remplacement d''une ressource ?','easy','SINGLE_CHOICE','taint marque la ressource pour remplacement; -replace est plus récent.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','taint (terraform taint aws_instance.web)',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','apply -replace=aws_instance.web',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','A et B',TRUE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A seulement',FALSE,3);
    END IF;
END $$;
