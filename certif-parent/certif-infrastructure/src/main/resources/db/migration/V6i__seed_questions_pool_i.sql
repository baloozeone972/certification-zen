-- =============================================================================
-- V6i__seed_questions_pool_i.sql
-- CertifApp — Import pool questions (317 questions, springboot3 certifications)
-- Idempotent : INSERT ... ON CONFLICT DO NOTHING
-- =============================================================================

-- ── SPRINGBOOT3 (317 questions) ──────
DO $$
DECLARE
    v_cert_id TEXT := 'springboot3';
    v_theme_id UUID; v_q_id UUID; v_opt_id UUID;
BEGIN
    IF NOT EXISTS (SELECT 1 FROM certifications WHERE id = v_cert_id) THEN
        RAISE NOTICE 'Certification % absente', v_cert_id; RETURN;
    END IF;
    INSERT INTO certification_themes (id, certification_id, code, label, question_count, display_order)
    VALUES (uuid_generate_v4(), v_cert_id, 'auto_configuration', 'Auto-configuration', 0, 0)
    ON CONFLICT (certification_id, code) DO NOTHING;
    INSERT INTO certification_themes (id, certification_id, code, label, question_count, display_order)
    VALUES (uuid_generate_v4(), v_cert_id, 'spring_boot_actuator', 'Spring Boot Actuator', 0, 0)
    ON CONFLICT (certification_id, code) DO NOTHING;
    INSERT INTO certification_themes (id, certification_id, code, label, question_count, display_order)
    VALUES (uuid_generate_v4(), v_cert_id, 'spring_data', 'Spring Data', 0, 0)
    ON CONFLICT (certification_id, code) DO NOTHING;
    INSERT INTO certification_themes (id, certification_id, code, label, question_count, display_order)
    VALUES (uuid_generate_v4(), v_cert_id, 'spring_security', 'Spring Security', 0, 0)
    ON CONFLICT (certification_id, code) DO NOTHING;
    INSERT INTO certification_themes (id, certification_id, code, label, question_count, display_order)
    VALUES (uuid_generate_v4(), v_cert_id, 'spring_cloud', 'Spring Cloud', 0, 0)
    ON CONFLICT (certification_id, code) DO NOTHING;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-AC-001') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='auto_configuration' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-AC-001',v_cert_id,v_theme_id,'Quelle annotation active l''auto-configuration de Spring Boot ?','easy','SINGLE_CHOICE','@EnableAutoConfiguration active le mécanisme d''auto-configuration.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','@EnableAutoConfiguration',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','@SpringBootApplication',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','@Configuration',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','@ComponentScan',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-AC-002') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='auto_configuration' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-AC-002',v_cert_id,v_theme_id,'Quelles annotations compose @SpringBootApplication ?','easy','SINGLE_CHOICE','@SpringBootApplication est composée de ces trois annotations.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','@Configuration, @EnableAutoConfiguration, @ComponentScan',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','@Configuration, @EnableAutoConfiguration',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','@SpringBootConfiguration, @ComponentScan',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','@Configuration, @ComponentScan',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-AC-003') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='auto_configuration' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-AC-003',v_cert_id,v_theme_id,'Quand Spring Boot applique-t-il l''auto-configuration ?','easy','SINGLE_CHOICE','L''auto-configuration est appliquée au démarrage de l''application.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','À la compilation',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Au démarrage',TRUE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','À la première requête',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','À la création du contexte',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-AC-004') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='auto_configuration' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-AC-004',v_cert_id,v_theme_id,'Quel est l''ordre d''exécution des auto-configurations ?','medium','SINGLE_CHOICE','@AutoConfigureOrder permet de définir l''ordre d''exécution.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Défini par @AutoConfigureOrder',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Aléatoire',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Ordre alphabétique',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Ordre de déclaration',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-AC-005') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='auto_configuration' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-AC-005',v_cert_id,v_theme_id,'Que signifie ''condition'' dans l''auto-configuration ?','medium','SINGLE_CHOICE','Les auto-configurations sont conditionnées par des annotations @Conditional.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Configuration appliquée si condition remplie',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Configuration obligatoire',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Configuration ignorée',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Configuration conditionnelle',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-AC-006') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='auto_configuration' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-AC-006',v_cert_id,v_theme_id,'Comment exclure une auto-configuration spécifique ?','easy','SINGLE_CHOICE','L''attribut exclude de @EnableAutoConfiguration permet d''exclure des classes.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','@EnableAutoConfiguration(exclude = DataSourceAutoConfiguration.class)',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','@SpringBootApplication(exclude = DataSourceAutoConfiguration.class)',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','@ExcludeAutoConfiguration(DataSourceAutoConfiguration.class)',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','@AutoConfiguration(exclude = DataSourceAutoConfiguration.class)',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-AC-007') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='auto_configuration' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-AC-007',v_cert_id,v_theme_id,'Comment exclure une auto-configuration par nom ?','medium','SINGLE_CHOICE','excludeName permet d''exclure par nom complet de classe.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','@EnableAutoConfiguration(excludeName = "org...")',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','@SpringBootApplication(excludeName = "org...")',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','@ExcludeAutoConfiguration(name = "org...")',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','@AutoConfiguration(excludeClass = "org...")',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-AC-008') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='auto_configuration' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-AC-008',v_cert_id,v_theme_id,'Comment exclure des auto-configurations via properties ?','medium','SINGLE_CHOICE','La propriété spring.autoconfigure.exclude liste les exclusions.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','spring.autoconfigure.exclude',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','spring.boot.autoconfigure.exclude',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','auto.configuration.exclude',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','spring.exclude.autoconfigure',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-AC-009') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='auto_configuration' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-AC-009',v_cert_id,v_theme_id,'Peut-on exclure plusieurs auto-configurations ?','hard','SINGLE_CHOICE','On peut lister plusieurs classes séparées par des virgules.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Oui, séparées par des virgules',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Non, une seule',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Oui, avec excludeAll',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Oui, avec excludes[]',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-AC-010') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='auto_configuration' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-AC-010',v_cert_id,v_theme_id,'Dans quel fichier sont déclarées les auto-configurations ?','hard','SINGLE_CHOICE','Depuis Spring Boot 2.7, le fichier AutoConfiguration.imports est utilisé.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','META-INF/spring/org.springframework.boot.autoconfigure.AutoConfiguration.imports',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','META-INF/spring.factories',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','META-INF/autoconfigure',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','spring-autoconfigure-metadata.properties',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-AC-011') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='auto_configuration' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-AC-011',v_cert_id,v_theme_id,'Quel était le fichier avant Spring Boot 2.7 ?','hard','SINGLE_CHOICE','Avant 2.7, spring.factories était utilisé pour déclarer les auto-configurations.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','META-INF/spring.factories',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','META-INF/autoconfigure',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','META-INF/spring-autoconfigure',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','META-INF/spring-configuration',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-AC-012') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='auto_configuration' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-AC-012',v_cert_id,v_theme_id,'Que vérifie @ConditionalOnClass ?','easy','SINGLE_CHOICE','@ConditionalOnClass active la configuration si une classe est présente.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Présence d''une classe dans le classpath',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Absence d''une classe',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Présence d''un bean',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Valeur d''une propriété',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-AC-013') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='auto_configuration' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-AC-013',v_cert_id,v_theme_id,'Que vérifie @ConditionalOnMissingClass ?','medium','SINGLE_CHOICE','@ConditionalOnMissingClass active si la classe est absente.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Absence d''une classe',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Présence d''une classe',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Absence d''un bean',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Présence d''un bean',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-AC-014') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='auto_configuration' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-AC-014',v_cert_id,v_theme_id,'Que vérifie @ConditionalOnBean ?','easy','SINGLE_CHOICE','@ConditionalOnBean active si un bean du type donné existe.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Présence d''un bean',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Absence d''un bean',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Présence d''une classe',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Valeur d''une propriété',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-AC-015') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='auto_configuration' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-AC-015',v_cert_id,v_theme_id,'Que vérifie @ConditionalOnMissingBean ?','medium','SINGLE_CHOICE','@ConditionalOnMissingBean crée un bean seulement s''il n''existe pas.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Absence d''un bean',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Présence d''un bean',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Absence d''une classe',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Présence d''une propriété',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-AC-016') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='auto_configuration' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-AC-016',v_cert_id,v_theme_id,'Que vérifie @ConditionalOnProperty ?','easy','SINGLE_CHOICE','@ConditionalOnProperty active si une propriété a la bonne valeur.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Valeur d''une propriété',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Présence d''un bean',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Présence d''une classe',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Absence d''une classe',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-AC-017') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='auto_configuration' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-AC-017',v_cert_id,v_theme_id,'Comment spécifier la valeur attendue d''une propriété ?','medium','SINGLE_CHOICE','L''attribut havingValue définit la valeur attendue.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','havingValue = "valeur"',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','value = "valeur"',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','expected = "valeur"',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','match = "valeur"',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-AC-018') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='auto_configuration' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-AC-018',v_cert_id,v_theme_id,'Que signifie havingValue = "true" ?','hard','SINGLE_CHOICE','La propriété doit avoir la valeur true.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Propriété doit être true',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Propriété doit exister',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Propriété doit être false',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Propriété ignorée',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-AC-019') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='auto_configuration' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-AC-019',v_cert_id,v_theme_id,'Quand @ConditionalOnWebApplication s''applique-t-elle ?','medium','SINGLE_CHOICE','La condition est vraie pour les applications web.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Aux applications web',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Aux applications non web',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Aux applications Servlet',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Aux applications Reactive',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-AC-020') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='auto_configuration' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-AC-020',v_cert_id,v_theme_id,'Comment cibler uniquement les applications Servlet ?','hard','SINGLE_CHOICE','L''attribut type permet de spécifier le type d''application web.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','type = Type.SERVLET',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','webType = SERVLET',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','applicationType = SERVLET',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','serverType = SERVLET',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-AC-021') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='auto_configuration' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-AC-021',v_cert_id,v_theme_id,'Que permet @ConditionalOnExpression ?','hard','SINGLE_CHOICE','@ConditionalOnExpression utilise une expression SpEL.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Expression SpEL',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Vérification de classe',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Vérification de bean',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Vérification de propriété',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-AC-022') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='auto_configuration' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-AC-022',v_cert_id,v_theme_id,'Exemple d''expression SpEL valide ?','hard','SINGLE_CHOICE','L''expression doit être une expression SpEL valide entre guillemets.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','''${property}''.equals(''value'')',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','${property} == ''value''',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','#{property == ''value''}',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','@property == ''value''',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-AC-023') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='auto_configuration' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-AC-023',v_cert_id,v_theme_id,'Que vérifie @ConditionalOnResource ?','hard','SINGLE_CHOICE','@ConditionalOnResource active si une ressource est présente.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Présence d''une ressource',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Présence d''une classe',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Présence d''un bean',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Présence d''une propriété',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-AC-024') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='auto_configuration' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-AC-024',v_cert_id,v_theme_id,'Comment spécifier plusieurs ressources ?','hard','SINGLE_CHOICE','L''attribut resources prend un tableau de chemins.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','resources = {"file1", "file2"}',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','value = {"file1", "file2"}',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','names = {"file1", "file2"}',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','paths = {"file1", "file2"}',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-AC-025') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='auto_configuration' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-AC-025',v_cert_id,v_theme_id,'Quelle annotation définit l''ordre d''exécution ?','hard','SINGLE_CHOICE','@AutoConfigureOrder est spécifique aux auto-configurations.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','@AutoConfigureOrder',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','@Order',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','@Priority',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','@AutoOrder',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-AC-026') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='auto_configuration' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-AC-026',v_cert_id,v_theme_id,'Quelle annotation exécute après d''autres configurations ?','hard','SINGLE_CHOICE','@AutoConfigureAfter garantit l''exécution après les configurations spécifiées.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','@AutoConfigureAfter',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','@After',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','@PostConfiguration',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','@AutoOrderAfter',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-AC-027') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='auto_configuration' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-AC-027',v_cert_id,v_theme_id,'Quelle annotation exécute avant d''autres configurations ?','hard','SINGLE_CHOICE','@AutoConfigureBefore garantit l''exécution avant les configurations spécifiées.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','@AutoConfigureBefore',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','@Before',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','@PreConfiguration',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','@AutoOrderBefore',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-AC-028') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='auto_configuration' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-AC-028',v_cert_id,v_theme_id,'Comment afficher le rapport d''auto-configuration ?','easy','SINGLE_CHOICE','L''option --debug affiche le rapport d''auto-configuration.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','--debug',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','--trace',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','--auto-config-report',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','--spring.debug',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-AC-029') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='auto_configuration' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-AC-029',v_cert_id,v_theme_id,'Que montre le rapport d''auto-configuration ?','hard','SINGLE_CHOICE','Le rapport montre quelles configurations sont appliquées et pourquoi certaines sont ignorées.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Configurations appliquées et ignorées',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Toutes les configurations',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Seules les erreurs',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Les beans créés',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-AC-030') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='auto_configuration' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-AC-030',v_cert_id,v_theme_id,'Quelle annotation lie des propriétés à un bean ?','easy','SINGLE_CHOICE','@ConfigurationProperties lie les propriétés d''un préfixe à un bean.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','@ConfigurationProperties',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','@Value',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','@PropertySource',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','@ConfigurationBinding',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-AC-031') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='auto_configuration' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-AC-031',v_cert_id,v_theme_id,'Comment spécifier le préfixe des propriétés ?','medium','SINGLE_CHOICE','L''attribut prefix définit le préfixe des propriétés.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','prefix = "app"',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','value = "app"',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','name = "app"',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','key = "app"',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-AC-032') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='auto_configuration' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-AC-032',v_cert_id,v_theme_id,'Quelle annotation enregistre les @ConfigurationProperties ?','medium','SINGLE_CHOICE','@EnableConfigurationProperties enregistre les beans @ConfigurationProperties.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','@EnableConfigurationProperties',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','@ConfigurationPropertiesScan',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','@PropertySource',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','@Component',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-AC-033') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='auto_configuration' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-AC-033',v_cert_id,v_theme_id,'Peut-on utiliser @ConfigurationProperties sans @EnableConfigurationProperties ?','hard','SINGLE_CHOICE','Si la classe est annotée @Component, elle est automatiquement détectée.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Oui, avec @Component',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Non, obligatoire',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Oui, avec @Bean',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Non, jamais',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-AC-034') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='auto_configuration' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-AC-034',v_cert_id,v_theme_id,'Comment valider les propriétés ?','hard','SINGLE_CHOICE','On peut utiliser les annotations de validation JSR-303.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Annotations JSR-303',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','@Validated',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','@NotNull, @Min, @Max',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-AC-035') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='auto_configuration' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-AC-035',v_cert_id,v_theme_id,'Comment désactiver complètement l''auto-configuration ?','medium','SINGLE_CHOICE','La propriété spring.boot.enableautoconfiguration=false désactive l''auto-configuration.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','spring.boot.enableautoconfiguration=false',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','spring.autoconfigure.exclude=*',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','@EnableAutoConfiguration(excludeName = "*")',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','spring.boot.autoconfigure.enabled=false',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-AC-036') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='auto_configuration' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-AC-036',v_cert_id,v_theme_id,'Que se passe-t-il si auto-configuration est désactivée ?','hard','SINGLE_CHOICE','Toutes les auto-configurations sont désactivées.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Plus aucune configuration automatique',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Seulement les configurations de base',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Erreur au démarrage',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Les beans doivent être déclarés manuellement',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-AC-037') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='auto_configuration' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-AC-037',v_cert_id,v_theme_id,'Que vérifie @ConditionalOnSingleCandidate ?','hard','SINGLE_CHOICE','Vérifie qu''un seul bean du type donné est présent.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Un seul bean du type existe',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Au moins un bean existe',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Aucun bean n''existe',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Plusieurs beans existent',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-AC-038') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='auto_configuration' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-AC-038',v_cert_id,v_theme_id,'Que vérifie @ConditionalOnCloudPlatform ?','hard','SINGLE_CHOICE','Active la configuration sur une plateforme cloud spécifique (AWS, GCP, Azure).','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Plateforme cloud spécifique',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Présence d''un cloud',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Version du cloud',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Provider cloud',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-AC-039') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='auto_configuration' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-AC-039',v_cert_id,v_theme_id,'Quand @ConditionalOnNotWebApplication s''applique-t-elle ?','hard','SINGLE_CHOICE','La condition est vraie pour les applications non web.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Aux applications non web',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Aux applications web',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Aux applications batch',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Aux applications console',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-AC-040') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='auto_configuration' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-AC-040',v_cert_id,v_theme_id,'Que vérifie @ConditionalOnJava ?','hard','SINGLE_CHOICE','Active la configuration pour une version spécifique de Java.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Version de Java',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Fournisseur Java',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Architecture JVM',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Java EE',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-AC-041') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='auto_configuration' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-AC-041',v_cert_id,v_theme_id,'Que vérifie @ConditionalOnJndi ?','hard','SINGLE_CHOICE','Active si une ressource JNDI spécifique est disponible.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Présence d''une ressource JNDI',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Présence d''un serveur JNDI',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Configuration JNDI',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Support JNDI',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-AC-042') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='auto_configuration' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-AC-042',v_cert_id,v_theme_id,'Quelle est la différence entre @SpringBootConfiguration et @Configuration ?','hard','SINGLE_CHOICE','@SpringBootConfiguration marque la classe de configuration principale.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','@SpringBootConfiguration indique la classe principale',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Identiques',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','@SpringBootConfiguration est plus spécifique',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','@SpringBootConfiguration active auto-configuration',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-AC-043') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='auto_configuration' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-AC-043',v_cert_id,v_theme_id,'Que fait @ImportAutoConfiguration ?','hard','SINGLE_CHOICE','@ImportAutoConfiguration permet d''importer des auto-configurations spécifiques.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Importe des auto-configurations spécifiques',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Importe toutes les auto-configurations',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Désactive des auto-configurations',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Remplace @EnableAutoConfiguration',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-AC-044') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='auto_configuration' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-AC-044',v_cert_id,v_theme_id,'Que fait @AutoConfigurationPackage ?','hard','SINGLE_CHOICE','@AutoConfigurationPackage enregistre le package pour les scans ultérieurs.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Enregistre le package pour le scan',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Configure le package racine',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Définit le package d''auto-configuration',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Scanne les composants',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-AC-045') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='auto_configuration' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-AC-045',v_cert_id,v_theme_id,'Comment Spring Boot analyse les échecs d''auto-configuration ?','hard','SINGLE_CHOICE','Les FailureAnalyzer fournissent des messages d''erreur explicites.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','FailureAnalyzer',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','ErrorHandler',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','ExceptionAnalyzer',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','ProblemReporter',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-AC-046') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='auto_configuration' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-AC-046',v_cert_id,v_theme_id,'Comment créer un FailureAnalyzer personnalisé ?','hard','SINGLE_CHOICE','On peut implémenter FailureAnalyzer ou étendre AbstractFailureAnalyzer.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Implémenter FailureAnalyzer',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Étendre AbstractFailureAnalyzer',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Utiliser @FailureAnalyzer',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A et B',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-AC-047') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='auto_configuration' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-AC-047',v_cert_id,v_theme_id,'Où sont stockées les métadonnées de configuration ?','hard','SINGLE_CHOICE','Le fichier spring-configuration-metadata.json contient les métadonnées.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','META-INF/spring-configuration-metadata.json',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','META-INF/configuration-metadata.json',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','META-INF/spring-metadata.json',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','META-INF/config-metadata.json',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-AC-048') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='auto_configuration' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-AC-048',v_cert_id,v_theme_id,'Quel plugin génère les métadonnées ?','hard','SINGLE_CHOICE','Le processor spring-boot-configuration-processor génère les métadonnées.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','spring-boot-configuration-processor',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','spring-boot-metadata-processor',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','spring-configuration-processor',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','boot-configuration-processor',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-AC-049') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='auto_configuration' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-AC-049',v_cert_id,v_theme_id,'Comment migrer de spring.factories vers AutoConfiguration.imports ?','hard','SINGLE_CHOICE','Les entrées de spring.factories doivent être déplacées dans AutoConfiguration.imports.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Déplacer les entrées dans le nouveau fichier',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Garder les deux',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Supprimer spring.factories',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Utiliser un script',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-AC-050') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='auto_configuration' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-AC-050',v_cert_id,v_theme_id,'Une auto-configuration doit-elle être légère ?','hard','SINGLE_CHOICE','Les auto-configurations doivent être légères et conditionnées.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Oui, utiliser @Conditional',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Non, peut être lourde',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Oui, éviter les opérations coûteuses',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A et C',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-AC-051') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='auto_configuration' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-AC-051',v_cert_id,v_theme_id,'Doit-on documenter les conditions d''une auto-configuration ?','hard','SINGLE_CHOICE','La documentation aide à comprendre quand la configuration s''applique.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Oui, pour comprendre pourquoi elle s''applique',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Non, automatique',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Oui, avec @ConditionalReport',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Non, inutile',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-AC-052') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='auto_configuration' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-AC-052',v_cert_id,v_theme_id,'Une auto-configuration doit-elle être dans un package séparé ?','hard','SINGLE_CHOICE','Il est recommandé de regrouper les auto-configurations dans un package dédié.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Oui, pour éviter les conflits',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Non, n''importe où',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Oui, dans un package dédié',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Non, dans le package principal',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-AC-053') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='auto_configuration' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-AC-053',v_cert_id,v_theme_id,'Comment tester une auto-configuration ?','hard','SINGLE_CHOICE','@SpringBootTest permet de tester l''application avec auto-configuration.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','@SpringBootTest',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','@AutoConfigureTest',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','@TestAutoConfiguration',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','@AutoConfigurationTest',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-AC-054') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='auto_configuration' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-AC-054',v_cert_id,v_theme_id,'Comment isoler une auto-configuration dans les tests ?','hard','SINGLE_CHOICE','@ImportAutoConfiguration permet d''importer uniquement les auto-configurations nécessaires.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','@ImportAutoConfiguration',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','@TestAutoConfiguration',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','@AutoConfigurationTest',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','@TestConfiguration',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-AC-055') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='auto_configuration' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-AC-055',v_cert_id,v_theme_id,'Comment désactiver l''auto-configuration dans les tests ?','hard','SINGLE_CHOICE','En spécifiant des classes de configuration, l''auto-configuration est désactivée.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','@SpringBootTest(classes = {...}) avec configuration manuelle',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','@DisableAutoConfiguration',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','@TestAutoConfiguration(false)',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','@NoAutoConfiguration',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-AC-056') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='auto_configuration' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-AC-056',v_cert_id,v_theme_id,'Comment savoir pourquoi une configuration est ignorée ?','hard','SINGLE_CHOICE','L''option --debug montre les conditions et pourquoi les configurations sont ignorées.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','--debug affiche les conditions',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','--trace',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','--auto-config-report',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','--spring.debug',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-AC-057') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='auto_configuration' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-AC-057',v_cert_id,v_theme_id,'Que montre la condition négative ?','hard','SINGLE_CHOICE','Les conditions négatives expliquent pourquoi une configuration est ignorée.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Pourquoi une configuration n''est pas appliquée',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Les configurations appliquées',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Les erreurs',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Les beans créés',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-AC-058') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='auto_configuration' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-AC-058',v_cert_id,v_theme_id,'Les auto-configurations ralentissent-elles le démarrage ?','hard','SINGLE_CHOICE','L''évaluation des conditions a un coût, mais reste acceptable.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Oui, légèrement',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Non, optimisées',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Oui, beaucoup',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Non, au contraire',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-AC-059') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='auto_configuration' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-AC-059',v_cert_id,v_theme_id,'Comment améliorer le temps de démarrage ?','hard','SINGLE_CHOICE','Plusieurs techniques peuvent accélérer le démarrage.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Désactiver les auto-configurations inutiles',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Utiliser @Conditional efficacement',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Exclure les classes inutiles',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-AC-060') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='auto_configuration' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-AC-060',v_cert_id,v_theme_id,'Spring Security a-t-il une auto-configuration ?','hard','SINGLE_CHOICE','SecurityAutoConfiguration configure la sécurité par défaut.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Oui, SecurityAutoConfiguration',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Oui, mais désactivée par défaut',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Oui, WebSecurityConfigurerAdapter',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-AC-061') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='auto_configuration' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-AC-061',v_cert_id,v_theme_id,'Comment désactiver l''auto-configuration de sécurité ?','hard','SINGLE_CHOICE','On peut exclure SecurityAutoConfiguration.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','@EnableAutoConfiguration(exclude = SecurityAutoConfiguration.class)',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','spring.security.enabled=false',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','@DisableSecurityAutoConfiguration',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','security.auto=false',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-AC-062') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='auto_configuration' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-AC-062',v_cert_id,v_theme_id,'Quelle auto-configuration configure JPA ?','hard','SINGLE_CHOICE','HibernateJpaAutoConfiguration configure Hibernate et JPA.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','HibernateJpaAutoConfiguration',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','JpaAutoConfiguration',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','DataJpaAutoConfiguration',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','JpaRepositoriesAutoConfiguration',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-AC-063') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='auto_configuration' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-AC-063',v_cert_id,v_theme_id,'Comment configurer le dialecte Hibernate ?','hard','SINGLE_CHOICE','La propriété spring.jpa.properties.hibernate.dialect définit le dialecte.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','spring.jpa.properties.hibernate.dialect',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','spring.jpa.dialect',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','hibernate.dialect',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','jpa.dialect',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-AC-064') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='auto_configuration' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-AC-064',v_cert_id,v_theme_id,'Quelle auto-configuration configure la DataSource ?','hard','SINGLE_CHOICE','DataSourceAutoConfiguration configure la source de données.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','DataSourceAutoConfiguration',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','JdbcAutoConfiguration',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','ConnectionPoolAutoConfiguration',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','DatabaseAutoConfiguration',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-AC-065') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='auto_configuration' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-AC-065',v_cert_id,v_theme_id,'Quel pool de connexion est utilisé par défaut ?','hard','SINGLE_CHOICE','HikariCP est le pool de connexion par défaut depuis Spring Boot 2.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','HikariCP',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Tomcat JDBC',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Apache DBCP2',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','C3P0',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-AC-066') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='auto_configuration' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-AC-066',v_cert_id,v_theme_id,'Quelle auto-configuration configure le conteneur web ?','hard','SINGLE_CHOICE','ServletWebServerFactoryAutoConfiguration configure le serveur web.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','ServletWebServerFactoryAutoConfiguration',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','WebServerAutoConfiguration',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','TomcatAutoConfiguration',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','ServletContainerAutoConfiguration',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-AC-067') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='auto_configuration' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-AC-067',v_cert_id,v_theme_id,'Comment changer le port du serveur ?','hard','SINGLE_CHOICE','La propriété server.port définit le port d''écoute.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','server.port=8081',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','spring.server.port=8081',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','web.port=8081',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','http.port=8081',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-AC-068') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='auto_configuration' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-AC-068',v_cert_id,v_theme_id,'Quelle auto-configuration configure Jackson ?','hard','SINGLE_CHOICE','JacksonAutoConfiguration configure l''ObjectMapper.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','JacksonAutoConfiguration',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','JsonAutoConfiguration',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','ObjectMapperAutoConfiguration',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','SerializationAutoConfiguration',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-AC-069') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='auto_configuration' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-AC-069',v_cert_id,v_theme_id,'Comment personnaliser l''ObjectMapper ?','hard','SINGLE_CHOICE','Plusieurs méthodes permettent de personnaliser l''ObjectMapper.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Définir un @Bean ObjectMapper',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','spring.jackson.* properties',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Jackson2ObjectMapperBuilder',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-AC-070') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='auto_configuration' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-AC-070',v_cert_id,v_theme_id,'Quelle auto-configuration configure le cache ?','hard','SINGLE_CHOICE','CacheAutoConfiguration configure le cache avec @EnableCaching.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','CacheAutoConfiguration',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','CachingAutoConfiguration',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','CacheManagerAutoConfiguration',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','SpringCacheAutoConfiguration',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-AC-071') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='auto_configuration' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-AC-071',v_cert_id,v_theme_id,'Quel cache provider est utilisé par défaut ?','hard','SINGLE_CHOICE','ConcurrentMapCache est le provider par défaut.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','ConcurrentMapCache',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','EhCache',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Caffeine',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','RedisCache',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-AC-072') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='auto_configuration' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-AC-072',v_cert_id,v_theme_id,'Quelle auto-configuration configure les transactions ?','hard','SINGLE_CHOICE','TransactionAutoConfiguration configure le gestionnaire de transactions.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','TransactionAutoConfiguration',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','JtaAutoConfiguration',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','DataSourceTransactionManagerAutoConfiguration',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','TxAutoConfiguration',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-AC-073') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='auto_configuration' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-AC-073',v_cert_id,v_theme_id,'Comment activer la gestion des transactions ?','hard','SINGLE_CHOICE','@EnableTransactionManagement active la gestion des transactions.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','@EnableTransactionManagement',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','@Transactional',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','@EnableTx',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','@TransactionManagement',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-AC-074') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='auto_configuration' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-AC-074',v_cert_id,v_theme_id,'Quelle auto-configuration configure WebFlux ?','hard','SINGLE_CHOICE','WebFluxAutoConfiguration configure l''environnement réactif.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','WebFluxAutoConfiguration',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','ReactiveWebServerAutoConfiguration',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','WebReactiveAutoConfiguration',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','FluxAutoConfiguration',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-AC-075') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='auto_configuration' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-AC-075',v_cert_id,v_theme_id,'Comment détecter automatiquement WebFlux vs MVC ?','hard','SINGLE_CHOICE','Spring Boot détecte la présence de spring-webflux ou spring-webmvc.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Spring Boot choisit selon les dépendances',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','À configurer manuellement',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Par propriété spring.web.type',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Par annotation',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-AC-076') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='auto_configuration' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-AC-076',v_cert_id,v_theme_id,'Quelle dépendance active l''actuator ?','hard','SINGLE_CHOICE','Le starter spring-boot-starter-actuator active l''actuator.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','spring-boot-starter-actuator',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','spring-boot-actuator',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','spring-actuator-starter',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','boot-starter-actuator',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-AC-077') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='auto_configuration' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-AC-077',v_cert_id,v_theme_id,'Quels endpoints sont exposés par défaut ?','hard','SINGLE_CHOICE','Seuls health et info sont exposés par défaut.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','health, info',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','health, metrics, info',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','health seulement',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','tous',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-AC-078') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='auto_configuration' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-AC-078',v_cert_id,v_theme_id,'Comment exposer tous les endpoints ?','hard','SINGLE_CHOICE','La propriété management.endpoints.web.exposure.include=* expose tous les endpoints.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','management.endpoints.web.exposure.include=*',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','actuator.endpoints.all=true',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','spring.actuator.expose-all=true',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','management.endpoints.expose-all=true',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-AC-079') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='auto_configuration' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-AC-079',v_cert_id,v_theme_id,'Quelle dépendance active DevTools ?','hard','SINGLE_CHOICE','spring-boot-devtools active les outils de développement.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','spring-boot-devtools',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','spring-devtools',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','boot-devtools',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','spring-boot-dev-tools',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-AC-080') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='auto_configuration' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-AC-080',v_cert_id,v_theme_id,'Que fait DevTools automatiquement ?','hard','SINGLE_CHOICE','DevTools fournit plusieurs fonctionnalités de développement.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Redémarrage automatique',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Rechargement live',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Cache désactivé',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-AC-081') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='auto_configuration' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-AC-081',v_cert_id,v_theme_id,'Comment exclure des ressources du redémarrage ?','hard','SINGLE_CHOICE','La propriété spring.devtools.restart.exclude liste les ressources exclues.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','spring.devtools.restart.exclude',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','devtools.restart.ignore',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','spring.restart.exclude',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','devtools.exclude',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-AC-082') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='auto_configuration' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-AC-082',v_cert_id,v_theme_id,'Quelle auto-configuration configure Spring Batch ?','hard','SINGLE_CHOICE','BatchAutoConfiguration configure l''environnement batch.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','BatchAutoConfiguration',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','SpringBatchAutoConfiguration',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','JobAutoConfiguration',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','BatchConfig',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-AC-083') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='auto_configuration' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-AC-083',v_cert_id,v_theme_id,'Comment désactiver l''exécution automatique des jobs ?','hard','SINGLE_CHOICE','spring.batch.job.enabled=false empêche l''exécution automatique des jobs.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','spring.batch.job.enabled=false',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','batch.jobs.enabled=false',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','spring.batch.enabled=false',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','batch.enabled=false',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-AC-084') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='auto_configuration' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-AC-084',v_cert_id,v_theme_id,'Quelle auto-configuration configure l''envoi de mails ?','hard','SINGLE_CHOICE','MailSenderAutoConfiguration configure le JavaMailSender.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','MailSenderAutoConfiguration',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','EmailAutoConfiguration',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','MailAutoConfiguration',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','SendMailAutoConfiguration',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-AC-085') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='auto_configuration' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-AC-085',v_cert_id,v_theme_id,'Quelles propriétés sont nécessaires pour le mail ?','hard','SINGLE_CHOICE','Les propriétés spring.mail.host et spring.mail.port sont obligatoires.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','spring.mail.host, spring.mail.port',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','mail.host, mail.port',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','email.host, email.port',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','smtp.host, smtp.port',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-AC-086') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='auto_configuration' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-AC-086',v_cert_id,v_theme_id,'Quelle auto-configuration configure la validation ?','hard','SINGLE_CHOICE','ValidationAutoConfiguration configure le Validator.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','ValidationAutoConfiguration',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','ValidatorAutoConfiguration',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Jsr303AutoConfiguration',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','BeanValidationAutoConfiguration',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-AC-087') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='auto_configuration' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-AC-087',v_cert_id,v_theme_id,'Comment activer la validation automatique des paramètres ?','hard','SINGLE_CHOICE','@Validated sur la classe active la validation des méthodes.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','@Validated sur la classe',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','@Valid sur les paramètres',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','@EnableValidation',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','@ValidationEnabled',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-AC-088') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='auto_configuration' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-AC-088',v_cert_id,v_theme_id,'Quelle auto-configuration configure Quartz ?','hard','SINGLE_CHOICE','QuartzAutoConfiguration configure le scheduler Quartz.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','QuartzAutoConfiguration',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','SchedulerAutoConfiguration',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','JobSchedulerAutoConfiguration',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','CronAutoConfiguration',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-AC-089') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='auto_configuration' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-AC-089',v_cert_id,v_theme_id,'Comment persister les jobs Quartz ?','hard','SINGLE_CHOICE','spring.quartz.job-store-type=jdbc active la persistance JDBC.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','spring.quartz.job-store-type=jdbc',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','quartz.store=jdbc',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','spring.quartz.persist=true',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','quartz.jdbc=true',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-AC-090') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='auto_configuration' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-AC-090',v_cert_id,v_theme_id,'Quelle auto-configuration configure RSocket ?','hard','SINGLE_CHOICE','RSocketAutoConfiguration configure le support RSocket.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','RSocketAutoConfiguration',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','SocketAutoConfiguration',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','ReactiveSocketAutoConfiguration',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','MessagingAutoConfiguration',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-AC-091') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='auto_configuration' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-AC-091',v_cert_id,v_theme_id,'Sur quel port RSocket écoute par défaut ?','hard','SINGLE_CHOICE','Le port par défaut pour RSocket est 7000.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','7000',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','8080',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','9090',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','8888',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-AC-092') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='auto_configuration' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-AC-092',v_cert_id,v_theme_id,'Quelle auto-configuration configure WebSocket ?','hard','SINGLE_CHOICE','WebSocketAutoConfiguration configure le support WebSocket.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','WebSocketAutoConfiguration',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','SocketAutoConfiguration',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','WsAutoConfiguration',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','MessageBrokerAutoConfiguration',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-AC-093') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='auto_configuration' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-AC-093',v_cert_id,v_theme_id,'Comment activer STOMP sur WebSocket ?','hard','SINGLE_CHOICE','@EnableWebSocketMessageBroker active le broker STOMP.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','@EnableWebSocketMessageBroker',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','@EnableStomp',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','@EnableWebSocketStomp',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','@MessageBroker',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-AC-094') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='auto_configuration' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-AC-094',v_cert_id,v_theme_id,'Quelle auto-configuration configure GraphQL ?','hard','SINGLE_CHOICE','GraphQlAutoConfiguration configure le support GraphQL.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','GraphQlAutoConfiguration',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','GraphQLAutoConfiguration',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','ApiAutoConfiguration',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','SchemaAutoConfiguration',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-AC-095') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='auto_configuration' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-AC-095',v_cert_id,v_theme_id,'Où placer les fichiers schema.graphqls ?','hard','SINGLE_CHOICE','Les fichiers schema sont dans src/main/resources/graphql/ par défaut.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','src/main/resources/graphql/',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','src/main/resources/schema/',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','src/main/graphql/',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','src/main/resources/',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-AC-096') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='auto_configuration' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-AC-096',v_cert_id,v_theme_id,'Quelle auto-configuration configure les web services SOAP ?','hard','SINGLE_CHOICE','WebServicesAutoConfiguration configure le support SOAP.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','WebServicesAutoConfiguration',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','SoapAutoConfiguration',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','WsAutoConfiguration',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','JaxWsAutoConfiguration',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-AC-097') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='auto_configuration' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-AC-097',v_cert_id,v_theme_id,'Comment exposer un endpoint SOAP ?','hard','SINGLE_CHOICE','@Endpoint marque une classe comme endpoint SOAP.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','@Endpoint',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','@WebService',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','@SoapEndpoint',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','@WsEndpoint',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-AC-098') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='auto_configuration' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-AC-098',v_cert_id,v_theme_id,'Quelle auto-configuration configure Spring Integration ?','hard','SINGLE_CHOICE','IntegrationAutoConfiguration configure Spring Integration.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','IntegrationAutoConfiguration',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','MessageAutoConfiguration',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','FlowAutoConfiguration',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','ChannelAutoConfiguration',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-AC-099') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='auto_configuration' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-AC-099',v_cert_id,v_theme_id,'Comment activer les intégrations avec @EnableIntegration ?','hard','SINGLE_CHOICE','Le starter spring-boot-starter-integration active automatiquement.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Automatique avec starter',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Manuel uniquement',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','@EnableIntegration required',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Par configuration XML',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-AC-100') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='auto_configuration' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-AC-100',v_cert_id,v_theme_id,'Quelle auto-configuration configure Spring AOP ?','hard','SINGLE_CHOICE','AopAutoConfiguration configure le support AOP.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','AopAutoConfiguration',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','AspectAutoConfiguration',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','ProxyAutoConfiguration',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','AdviceAutoConfiguration',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-ACT-001') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='spring_boot_actuator' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-ACT-001',v_cert_id,v_theme_id,'Quelle dépendance ajoute Actuator ?','easy','SINGLE_CHOICE','Le starter spring-boot-starter-actuator active Actuator.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','spring-boot-starter-actuator',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','spring-boot-actuator',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','spring-actuator-starter',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','boot-starter-actuator',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-ACT-002') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='spring_boot_actuator' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-ACT-002',v_cert_id,v_theme_id,'Quels sont les deux endpoints exposés par défaut ?','easy','SINGLE_CHOICE','Seuls /health et /info sont exposés par défaut pour des raisons de sécurité.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','/health et /info',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','/metrics et /health',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','/info et /metrics',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','/health et /env',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-ACT-003') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='spring_boot_actuator' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-ACT-003',v_cert_id,v_theme_id,'Quel endpoint donne l''état de santé de l''application ?','easy','SINGLE_CHOICE','/health fournit des informations sur la santé de l''application.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','/health',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','/info',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','/status',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','/ping',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-ACT-004') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='spring_boot_actuator' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-ACT-004',v_cert_id,v_theme_id,'Quel endpoint donne des informations sur l''application ?','easy','SINGLE_CHOICE','/info fournit des informations personnalisables sur l''application.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','/info',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','/health',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','/metadata',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','/details',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-ACT-005') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='spring_boot_actuator' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-ACT-005',v_cert_id,v_theme_id,'Quel endpoint expose les métriques de l''application ?','medium','SINGLE_CHOICE','/metrics expose les métriques comme la mémoire, CPU, etc.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','/metrics',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','/stats',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','/measure',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','/counters',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-ACT-006') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='spring_boot_actuator' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-ACT-006',v_cert_id,v_theme_id,'Quel endpoint expose les propriétés de configuration ?','medium','SINGLE_CHOICE','/env expose les propriétés d''environnement et de configuration.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','/env',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','/config',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','/properties',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','/settings',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-ACT-007') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='spring_boot_actuator' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-ACT-007',v_cert_id,v_theme_id,'Quel endpoint expose la liste des beans Spring ?','medium','SINGLE_CHOICE','/beans liste tous les beans du contexte Spring.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','/beans',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','/components',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','/context',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','/instances',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-ACT-008') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='spring_boot_actuator' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-ACT-008',v_cert_id,v_theme_id,'Quel endpoint expose les mappings des endpoints web ?','medium','SINGLE_CHOICE','/mappings montre les routes HTTP et leurs contrôleurs.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','/mappings',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','/routes',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','/endpoints',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','/apis',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-ACT-009') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='spring_boot_actuator' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-ACT-009',v_cert_id,v_theme_id,'Quel endpoint expose les threads de l''application ?','medium','SINGLE_CHOICE','/threaddump retourne un dump des threads.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','/threaddump',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','/threads',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','/dump',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','/stack',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-ACT-010') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='spring_boot_actuator' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-ACT-010',v_cert_id,v_theme_id,'Quel endpoint expose la configuration des logs ?','medium','SINGLE_CHOICE','/loggers permet de consulter et modifier les niveaux de log.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','/loggers',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','/logs',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','/logging',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','/logconfig',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-ACT-011') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='spring_boot_actuator' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-ACT-011',v_cert_id,v_theme_id,'Comment exposer tous les endpoints Actuator ?','hard','SINGLE_CHOICE','include=* expose tous les endpoints disponibles.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','management.endpoints.web.exposure.include=*',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','actuator.endpoints.all=true',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','spring.actuator.expose-all=true',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','management.endpoints.expose-all=true',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-ACT-012') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='spring_boot_actuator' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-ACT-012',v_cert_id,v_theme_id,'Comment exposer uniquement health et info ?','hard','SINGLE_CHOICE','include=health,info limite l''exposition à ces deux endpoints.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','management.endpoints.web.exposure.include=health,info',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','actuator.endpoints=health,info',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','spring.actuator.include=health,info',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','endpoints.expose=health,info',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-ACT-013') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='spring_boot_actuator' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-ACT-013',v_cert_id,v_theme_id,'Comment exclure un endpoint spécifique ?','hard','SINGLE_CHOICE','exclude permet de retirer des endpoints de l''exposition.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','management.endpoints.web.exposure.exclude=env',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','actuator.endpoints.exclude=env',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','spring.actuator.exclude=env',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','endpoints.exclude=env',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-ACT-014') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='spring_boot_actuator' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-ACT-014',v_cert_id,v_theme_id,'Comment changer le préfixe des endpoints Actuator ?','hard','SINGLE_CHOICE','base-path change le préfixe (par défaut /actuator).','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','management.endpoints.web.base-path=/actuator',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','actuator.base-path=/actuator',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','spring.actuator.path=/actuator',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','endpoints.base-path=/actuator',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-ACT-015') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='spring_boot_actuator' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-ACT-015',v_cert_id,v_theme_id,'Comment afficher les détails complets de santé ?','hard','SINGLE_CHOICE','show-details=always montre les détails de chaque composant.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','management.endpoint.health.show-details=always',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','health.show-details=true',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','actuator.health.details=always',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','endpoint.health.details=always',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-ACT-016') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='spring_boot_actuator' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-ACT-016',v_cert_id,v_theme_id,'Comment créer un HealthIndicator personnalisé ?','hard','SINGLE_CHOICE','On peut implémenter HealthIndicator ou étendre AbstractHealthIndicator.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Implémenter HealthIndicator',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Étendre AbstractHealthIndicator',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Utiliser @HealthIndicator',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A et B',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-ACT-017') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='spring_boot_actuator' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-ACT-017',v_cert_id,v_theme_id,'Que retourne un HealthIndicator personnalisé ?','hard','SINGLE_CHOICE','health() retourne un objet Health avec status et détails.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Health object',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Status only',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','String',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Boolean',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-ACT-018') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='spring_boot_actuator' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-ACT-018',v_cert_id,v_theme_id,'Quels sont les statuts possibles d''un Health ?','hard','SINGLE_CHOICE','Les statuts standards sont UP, DOWN, OUT_OF_SERVICE, UNKNOWN.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','UP, DOWN, OUT_OF_SERVICE, UNKNOWN',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','OK, KO, UNKNOWN',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','GREEN, RED, YELLOW',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','HEALTHY, UNHEALTHY',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-ACT-019') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='spring_boot_actuator' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-ACT-019',v_cert_id,v_theme_id,'Comment ordonner les HealthIndicator ?','hard','SINGLE_CHOICE','@Order permet de définir l''ordre d''exécution des health indicators.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','@Order',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','@Priority',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','@HealthOrder',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Ordre alphabétique',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-ACT-020') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='spring_boot_actuator' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-ACT-020',v_cert_id,v_theme_id,'Comment désactiver un HealthIndicator spécifique ?','hard','SINGLE_CHOICE','Ex: management.health.db.enabled=false désactive le health check DB.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','management.health.indicator.enabled=false',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','health.indicator.disabled=true',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','actuator.health.ignore=indicator',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','endpoint.health.disable=indicator',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-ACT-021') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='spring_boot_actuator' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-ACT-021',v_cert_id,v_theme_id,'Quelles métriques sont exposées par défaut ?','hard','SINGLE_CHOICE','Plusieurs métriques sont exposées : JVM, CPU, HTTP, Logback, etc.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','JVM, CPU, HTTP, Logback',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Seulement JVM',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Seulement HTTP',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Aucune',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-ACT-022') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='spring_boot_actuator' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-ACT-022',v_cert_id,v_theme_id,'Comment créer un compteur personnalisé ?','hard','SINGLE_CHOICE','Plusieurs façons de créer des métriques personnalisées.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','@Autowired MeterRegistry',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','MeterRegistry.counter().increment()',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Counter.builder().register()',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-ACT-023') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='spring_boot_actuator' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-ACT-023',v_cert_id,v_theme_id,'Quelle annotation crée automatiquement des métriques ?','hard','SINGLE_CHOICE','@Timed mesure le temps d''exécution des méthodes.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','@Timed',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','@Counted',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','@Metric',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','@Measured',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-ACT-024') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='spring_boot_actuator' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-ACT-024',v_cert_id,v_theme_id,'Comment taguer une métrique ?','hard','SINGLE_CHOICE','Les tags peuvent être ajoutés à la création ou après.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','MeterRegistry.counter("name", "tag", "value")',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','counter.tags("tag", "value")',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','metric.tag("tag", "value")',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A et B',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-ACT-025') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='spring_boot_actuator' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-ACT-025',v_cert_id,v_theme_id,'Comment exporter les métriques vers Prometheus ?','hard','SINGLE_CHOICE','Prometheus nécessite la dépendance et la configuration adéquate.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Ajouter micrometer-registry-prometheus',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Exporter vers /actuator/prometheus',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Configuration de Prometheus',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-ACT-026') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='spring_boot_actuator' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-ACT-026',v_cert_id,v_theme_id,'Comment ajouter des informations personnalisées à /info ?','hard','SINGLE_CHOICE','Propriétés ou InfoContributor personnalisé.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','info.app.name=MyApp dans application.properties',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','@InfoContributor',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','InfoContributor personnalisé',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-ACT-027') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='spring_boot_actuator' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-ACT-027',v_cert_id,v_theme_id,'Quelle information est automatiquement incluse ?','hard','SINGLE_CHOICE','Les fichiers build-info.properties et git.properties sont inclus automatiquement.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','build, git',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','application name',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','version',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','aucune',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-ACT-028') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='spring_boot_actuator' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-ACT-028',v_cert_id,v_theme_id,'Comment exposer les informations Git ?','hard','SINGLE_CHOICE','Le plugin git-commit-id génère git.properties.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Plugin git-commit-id',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','spring.git.info=true',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','git.properties généré',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A et C',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-ACT-029') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='spring_boot_actuator' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-ACT-029',v_cert_id,v_theme_id,'Comment exposer les informations de build ?','hard','SINGLE_CHOICE','Le plugin Maven peut générer build-info.properties.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Plugin spring-boot-maven-plugin',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','build-info.properties',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','spring.build.info=true',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A et B',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-ACT-030') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='spring_boot_actuator' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-ACT-030',v_cert_id,v_theme_id,'Comment changer dynamiquement le niveau de log ?','hard','SINGLE_CHOICE','POST avec le nouveau niveau dans le corps de la requête.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','POST /actuator/loggers/package',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','PUT /actuator/loggers/package',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','PATCH /actuator/loggers/package',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','GET /actuator/loggers/package',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-ACT-031') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='spring_boot_actuator' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-ACT-031',v_cert_id,v_theme_id,'Quels niveaux de log sont disponibles ?','hard','SINGLE_CHOICE','Les niveaux standard sont TRACE, DEBUG, INFO, WARN, ERROR, OFF.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','TRACE, DEBUG, INFO, WARN, ERROR, OFF',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','ALL, DEBUG, INFO, WARN, ERROR, NONE',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','FINE, FINER, FINEST, INFO, WARNING, SEVERE',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','DEBUG, INFO, WARN, ERROR',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-ACT-032') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='spring_boot_actuator' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-ACT-032',v_cert_id,v_theme_id,'Comment obtenir les niveaux de log actuels ?','hard','SINGLE_CHOICE','GET /actuator/loggers retourne tous les loggers.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','GET /actuator/loggers',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','GET /actuator/logs',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','GET /actuator/levels',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','GET /actuator/logconfig',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-ACT-033') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='spring_boot_actuator' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-ACT-033',v_cert_id,v_theme_id,'Quelles informations sont exposées par /env ?','hard','SINGLE_CHOICE','/env expose toutes les sources de configuration.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Propriétés système, variables d''environnement, properties',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Seulement application.properties',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Seulement les variables système',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Seulement les variables d''environnement',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-ACT-034') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='spring_boot_actuator' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-ACT-034',v_cert_id,v_theme_id,'Comment exposer /env en toute sécurité ?','hard','SINGLE_CHOICE','/env peut exposer des secrets, il faut sécuriser.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Restreindre l''accès',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Masquer les valeurs sensibles',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Ne pas exposer en production',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-ACT-035') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='spring_boot_actuator' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-ACT-035',v_cert_id,v_theme_id,'Comment sécuriser les endpoints Actuator ?','hard','SINGLE_CHOICE','Plusieurs méthodes pour sécuriser les endpoints.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Spring Security',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','management.endpoints.web.exposure.exclude=*',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Changer le port',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-ACT-036') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='spring_boot_actuator' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-ACT-036',v_cert_id,v_theme_id,'Comment changer le port d''Actuator ?','hard','SINGLE_CHOICE','management.server.port change le port d''Actuator.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','management.server.port=8081',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','actuator.port=8081',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','spring.actuator.port=8081',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','endpoints.port=8081',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-ACT-037') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='spring_boot_actuator' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-ACT-037',v_cert_id,v_theme_id,'Comment désactiver Actuator en production ?','hard','SINGLE_CHOICE','enabled-by-default=false désactive tous les endpoints.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','management.endpoints.enabled-by-default=false',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','actuator.enabled=false',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','spring.actuator.enabled=false',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','endpoints.enabled=false',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-ACT-038') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='spring_boot_actuator' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-ACT-038',v_cert_id,v_theme_id,'Comment créer un endpoint personnalisé ?','hard','SINGLE_CHOICE','Plusieurs annotations pour créer des endpoints.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','@Endpoint',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','@WebEndpoint',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','@RestController avec @ReadOperation',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-ACT-039') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='spring_boot_actuator' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-ACT-039',v_cert_id,v_theme_id,'Quelle annotation marque une opération de lecture ?','hard','SINGLE_CHOICE','@ReadOperation pour les opérations GET.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','@ReadOperation',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','@GetMapping',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','@Read',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','@Query',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-ACT-040') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='spring_boot_actuator' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-ACT-040',v_cert_id,v_theme_id,'Quelle annotation marque une opération d''écriture ?','hard','SINGLE_CHOICE','@WriteOperation pour les opérations POST/PUT/DELETE.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','@WriteOperation',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','@PostMapping',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','@Write',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','@Update',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-ACT-041') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='spring_boot_actuator' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-ACT-041',v_cert_id,v_theme_id,'Quelle annotation marque une opération de suppression ?','hard','SINGLE_CHOICE','@DeleteOperation pour les opérations DELETE.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','@DeleteOperation',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','@DeleteMapping',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','@WriteOperation',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','@Delete',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-ACT-042') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='spring_boot_actuator' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-ACT-042',v_cert_id,v_theme_id,'Comment définir l''ID d''un endpoint personnalisé ?','hard','SINGLE_CHOICE','L''attribut id de @Endpoint définit l''URL.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','@Endpoint(id = "myendpoint")',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','@WebEndpoint(name = "myendpoint")',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','@RestController("myendpoint")',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','@RequestMapping("/myendpoint")',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-ACT-043') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='spring_boot_actuator' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-ACT-043',v_cert_id,v_theme_id,'Peut-on sécuriser un endpoint personnalisé ?','hard','SINGLE_CHOICE','Spring Security peut sécuriser les endpoints.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Oui, avec Spring Security',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Non, endpoints publics',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Oui, avec @PreAuthorize',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A et C',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-ACT-044') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='spring_boot_actuator' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-ACT-044',v_cert_id,v_theme_id,'Les endpoints Actuator sont-ils exposés via JMX ?','hard','SINGLE_CHOICE','Les endpoints sont exposés via JMX par défaut.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Oui, par défaut',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Oui, si activé',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Uniquement pour les beans',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-ACT-045') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='spring_boot_actuator' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-ACT-045',v_cert_id,v_theme_id,'Comment désactiver l''exposition JMX ?','hard','SINGLE_CHOICE','Exclude=* désactive l''exposition JMX.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','management.endpoints.jmx.exposure.exclude=*',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','jmx.enabled=false',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','spring.jmx.enabled=false',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','actuator.jmx=false',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-ACT-046') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='spring_boot_actuator' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-ACT-046',v_cert_id,v_theme_id,'Quel endpoint expose les événements d''audit ?','hard','SINGLE_CHOICE','/auditevents expose les événements d''audit.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','/auditevents',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','/audit',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','/events',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','/logs',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-ACT-047') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='spring_boot_actuator' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-ACT-047',v_cert_id,v_theme_id,'Comment enregistrer un événement d''audit ?','hard','SINGLE_CHOICE','AuditEventPublisher permet de publier des événements.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','AuditEventPublisher.publishEvent()',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','EventPublisher.publish()',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','AuditLogger.log()',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','ApplicationEventPublisher',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-ACT-048') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='spring_boot_actuator' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-ACT-048',v_cert_id,v_theme_id,'Quel endpoint génère un heap dump ?','hard','SINGLE_CHOICE','/heapdump génère un fichier HPROF.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','/heapdump',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','/dump',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','/heap',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','/memory',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-ACT-049') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='spring_boot_actuator' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-ACT-049',v_cert_id,v_theme_id,'À quoi sert un heap dump ?','hard','SINGLE_CHOICE','Les heap dumps sont essentiels pour le diagnostic mémoire.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Analyser la mémoire',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Trouver des leaks',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Diagnostiquer OOME',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-ACT-050') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='spring_boot_actuator' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-ACT-050',v_cert_id,v_theme_id,'Quel endpoint expose les métriques pour Prometheus ?','hard','SINGLE_CHOICE','/actuator/prometheus est l''endpoint standard pour Prometheus.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','/prometheus',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','/metrics/prometheus',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','/actuator/prometheus',TRUE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','/scrape',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-SBA-001') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='spring_boot_actuator' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-SBA-001',v_cert_id,v_theme_id,'Sélectionnez TOUTES les affirmations correctes concernant les endpoints Actuator :','medium','SINGLE_CHOICE','Les endpoints Actuator sont accessibles par défaut sur le port 8080 (option A), il est possible de sécuriser les endpoints Actuator (option B) et ils sont exposés sur le chemin /actuator (option C). Les endpoints peuvent en revanche être personnalisés (option D est fausse).','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Les endpoints sont accessibles par défaut sur le port 8080',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Il est possible de sécuriser les endpoints Actuator',TRUE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Les endpoints Actuator sont exposés sur le chemin /actuator',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Les endpoints ne peuvent pas être personnalisés',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-SBA-002') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='spring_boot_actuator' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-SBA-002',v_cert_id,v_theme_id,'Quelle est l''endpoint par défaut pour vérifier la santé de l''application ?','easy','SINGLE_CHOICE','L''endpoint par défaut pour vérifier la santé de l''application est /health.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','/health',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','/status',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','/info',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','/metrics',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-SBA-003') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='spring_boot_actuator' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-SBA-003',v_cert_id,v_theme_id,'Quelles sont les DEUX propositions vraies concernant la création d''un endpoint personnalisé avec Actuator ?','hard','SINGLE_CHOICE','On peut utiliser l''annotation @Endpoint (option A) et on peut utiliser l''annotation @ReadOperation pour une opération de lecture (option C). Il est nécessaire de créer une classe qui implémente EndpointWebExtension pour des fonctionnalités plus avancées (option B est partielle), et les endpoints personnalisés peuvent être sécurisés (option D est fausse).','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','On peut utiliser l''annotation @Endpoint',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Il est nécessaire de créer une classe qui implémente EndpointWebExtension',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','On peut utiliser l''annotation @ReadOperation pour une opération de lecture',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Les endpoints personnalisés ne peuvent pas être sécurisés',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-SBA-005') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='spring_boot_actuator' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-SBA-005',v_cert_id,v_theme_id,'Sélectionnez TOUTES les affirmations correctes concernant la configuration d''Actuator :','easy','SINGLE_CHOICE','On peut désactiver certains endpoints en les mettant à false dans application.properties (option A), il est possible de personnaliser le chemin des endpoints Actuator (option B) et on peut activer des endpoints supplémentaires en les mettant à true dans application.properties (option D). Actuator peut être configuré via application.properties (option C est fausse).','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','On peut désactiver certains endpoints en les mettant à false dans application.properties',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Il est possible de personnaliser le chemin des endpoints Actuator',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Actuator ne peut pas être configuré via application.properties',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','On peut activer des endpoints supplémentaires en les mettant à true dans application.properties',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-SBA-005') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='spring_boot_actuator' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-SBA-005',v_cert_id,v_theme_id,'Sélectionnez TOUTES les affirmations correctes concernant l''endpoint /health :','medium','SINGLE_CHOICE','L''endpoint /health affiche l''état de santé globale de l''application, ce qui est correct. Il peut également être personnalisé pour inclure des détails spécifiques, ce qui est aussi correct. Cependant, il peut fournir des informations sur les composants individuels de l''application et vérifier la santé des bases de données, donc ces options sont incorrectes.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Affiche l''état de santé globale de l''application',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Peut être personnalisé pour inclure des détails spécifiques',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','N''offre pas d''informations sur les composants individuels de l''application',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Permet de vérifier la santé des bases de données',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-SBA-006') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='spring_boot_actuator' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-SBA-006',v_cert_id,v_theme_id,'Quelle est la fonction principale de l''endpoint /metrics ?','easy','SINGLE_CHOICE','L''endpoint /metrics est principalement utilisé pour exposer des métriques d''utilisation et de performance, ce qui est correct. Les autres options ne correspondent pas à la fonction principale de cet endpoint.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Afficher les informations sur la santé de l''application',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Exposer des métriques d''utilisation et de performance',TRUE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Gérer les configurations de l''application',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Afficher les informations d''environnement',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-SBA-007') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='spring_boot_actuator' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-SBA-007',v_cert_id,v_theme_id,'Quelles sont les DEUX propositions vraies concernant la création d''un endpoint personnalisé avec Actuator ?','hard','SINGLE_CHOICE','Il est possible de créer un endpoint personnalisé en utilisant l''annotation @Endpoint, ce qui est correct. Il est également nécessaire d''implémenter l''interface Endpoint, ce qui est aussi correct. L''étendre AbstractEndpoint n''est pas nécessaire et les endpoints personnalisés ne sont pas enregistrés dans le fichier application.properties, donc ces options sont incorrectes.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Il est possible de créer un endpoint personnalisé en étendant la classe AbstractEndpoint',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','On peut utiliser l''annotation @Endpoint pour définir un endpoint personnalisé',TRUE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Les endpoints personnalisés doivent être enregistrés dans le fichier application.properties',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Il est nécessaire d''implémenter l''interface Endpoint',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-SBA-008') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='spring_boot_actuator' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-SBA-008',v_cert_id,v_theme_id,'Comment désactiver un endpoint Actuator spécifique ?','medium','SINGLE_CHOICE','Pour désactiver un endpoint Actuator spécifique, il faut ajouter la propriété management.endpoints.web.exposure.exclude dans application.properties, ce qui est correct. Les autres options ne sont pas valides pour désactiver un endpoint Actuator spécifique.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','En ajoutant la propriété management.endpoints.web.exposure.exclude dans application.properties',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','En modifiant le fichier de configuration XML',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','En utilisant l''annotation @DisableEndpoint dans la classe principale de l''application',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','En supprimant le starter Actuator du projet',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-SBA-009') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='spring_boot_actuator' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-SBA-009',v_cert_id,v_theme_id,'Sélectionnez TOUTES les affirmations correctes concernant l''endpoint /loggers :','easy','SINGLE_CHOICE','L''endpoint /loggers permet de modifier les niveaux de log des loggers au runtime et de récupérer la configuration actuelle des loggers, ce qui est correct. Cependant, il n''affiche pas les messages de log en temps réel et ne nécessite pas nécessairement une authentification pour être accédé, donc ces options sont incorrectes.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Permet de modifier les niveaux de log des loggers au runtime',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Affiche les messages de log en temps réel',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Permet de récupérer la configuration actuelle des loggers',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Nécessite une authentification pour être accédé',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-SBA-010') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='spring_boot_actuator' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-SBA-010',v_cert_id,v_theme_id,'Quelles sont les DEUX affirmations correctes concernant les endpoints Actuator ?','medium','SINGLE_CHOICE','Les endpoints Actuator sont accessibles via HTTP par défaut, ce qui est correct. Ils peuvent également être sécurisés en utilisant Spring Security, ce qui est aussi correct. Cependant, tous les endpoints ne sont pas exposés par défaut pour des raisons de sécurité, ce qui est incorrect. Enfin, bien que les endpoints puissent être personnalisés en ajoutant des beans, cette affirmation n''est pas spécifiquement correcte dans le contexte des endpoints Actuator.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Les endpoints sont accessibles via HTTP par défaut.',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Les endpoints peuvent être sécurisés en utilisant Spring Security.',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Tous les endpoints sont exposés par défaut pour des raisons de sécurité.',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Les endpoints peuvent être personnalisés en ajoutant des beans.',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-SBA-011') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='spring_boot_actuator' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-SBA-011',v_cert_id,v_theme_id,'Quel est le code HTTP renvoyé par l''endpoint /health lorsque l''application est en bonne santé ?','easy','SINGLE_CHOICE','L''endpoint /health renvoie un code HTTP 200 lorsque l''application est en bonne santé, ce qui est correct.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','200',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','404',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','500',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','302',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-SBA-012') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='spring_boot_actuator' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-SBA-012',v_cert_id,v_theme_id,'Sélectionnez TOUTES les affirmations correctes concernant la création d''un endpoint personnalisé avec Actuator :','hard','SINGLE_CHOICE','Les endpoints personnalisés doivent être annotés avec @RestController, ce qui est correct. Les endpoints personnalisés peuvent également être sécurisés en utilisant Spring Security, ce qui est aussi correct. Cependant, étendre AbstractEndpoint n''est pas la méthode recommandée pour créer un endpoint personnalisé dans Actuator, ce qui est incorrect. De plus, il n''est pas nécessaire d''implémenter l''interface Endpoint pour créer un endpoint personnalisé, ce qui est également incorrect.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Il est possible de créer un endpoint personnalisé en étendant AbstractEndpoint.',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Les endpoints personnalisés doivent être annotés avec @RestController.',TRUE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Il est nécessaire d''implémenter l''interface Endpoint.',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Les endpoints personnalisés peuvent être sécurisés en utilisant Spring Security.',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-SBA-013') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='spring_boot_actuator' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-SBA-013',v_cert_id,v_theme_id,'Quelle est la différence entre les métriques ''counter'' et ''gauge'' dans Actuator ?','medium','SINGLE_CHOICE','Un compteur incrémente ses valeurs, tandis qu''une jauge peut augmenter ou diminuer, ce qui est correct.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Un compteur incrémente ses valeurs, tandis qu''une jauge peut augmenter ou diminuer.',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Un compteur peut augmenter ou diminuer, tandis qu''une jauge incrémente ses valeurs.',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Un compteur et une jauge ont la même fonctionnalité dans Actuator.',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Les métriques ''counter'' et ''gauge'' ne sont pas disponibles dans Actuator.',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-SBA-014') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='spring_boot_actuator' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-SBA-014',v_cert_id,v_theme_id,'Comment désactiver un endpoint Actuator spécifique ?','easy','SINGLE_CHOICE','Pour désactiver un endpoint Actuator spécifique, il faut ajouter la propriété management.endpoints.web.exposure.exclude=nomEndpoint dans le fichier de configuration, ce qui est correct.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','En ajoutant la propriété management.endpoints.web.exposure.exclude=nomEndpoint',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','En supprimant le starter Actuator de la dépendance.',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','En modifiant l''annotation @Endpoint dans le code source.',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','En utilisant la propriété management.endpoints.web.exposure.include=nomEndpoint',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-SBA-015') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='spring_boot_actuator' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-SBA-015',v_cert_id,v_theme_id,'Sélectionnez TOUTES les affirmations correctes concernant les métriques dans Spring Boot Actuator :','medium','SINGLE_CHOICE','Les métriques peuvent effectivement être exposées via HTTP et JMX, ce qui est une fonctionnalité importante d''Actuator. Spring Boot Acteur fournit des métriques sur les connexions HTTP par défaut, ce qui est une autre affirmation correcte. Les métriques peuvent être personnalisées en ajoutant des beans de type MeterRegistry, ce qui est également correct. Cependant, les métriques ne sont pas stockées dans une base de données par défaut ; elles sont généralement exposées via des endpoints HTTP ou JMX.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Les métriques peuvent être exposées via HTTP et JMX.',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Spring Boot Actuator fournit des métriques sur les connexions HTTP par défaut.',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Les métriques peuvent être personnalisées en ajoutant des beans de type MeterRegistry.',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Les métriques sont stockées dans la base de données par défaut.',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-SBA-016') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='spring_boot_actuator' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-SBA-016',v_cert_id,v_theme_id,'Quelle est la méthode par défaut pour vérifier l''état de santé d''une application Spring Boot Actuator ?','easy','SINGLE_CHOICE','/health est l''endpoint par défaut utilisé pour vérifier l''état de santé d''une application Spring Boot Actuator. Il fournit des informations sur le statut global et les détails spécifiques de l''application.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','/health',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','/status',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','/info',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','/metrics',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-SBA-017') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='spring_boot_actuator' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-SBA-017',v_cert_id,v_theme_id,'Quelles sont les DEUX propositions vraies concernant la création d''endpoints personnalisés dans Spring Boot Actuator ?','hard','SINGLE_CHOICE','Les endpoints personnalisés doivent être annotés avec @Endpoint, ce qui est une affirmation correcte. On peut utiliser l''annotation @ReadOperation pour définir une opération de lecture, ce qui est également correct. Cependant, il n''est pas vrai que les endpoints personnalisés ne peuvent pas être sécurisés ; ils peuvent être protégés en utilisant des mécanismes de sécurité tels que Spring Security. De plus, l''implémentation directe de l''interface Endpoint est moins courante et généralement déconseillée en faveur de l''utilisation des annotations.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','On peut créer des endpoints personnalisés en implémentant l''interface Endpoint.',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Les endpoints personnalisés doivent être annotés avec @Endpoint.',TRUE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','On peut utiliser l''annotation @ReadOperation pour définir une opération de lecture.',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Les endpoints personnalisés ne peuvent pas être sécurisés.',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-DATA-001') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='spring_data' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-DATA-001',v_cert_id,v_theme_id,'Quelle annotation marque une entité JPA ?','easy','SINGLE_CHOICE','@Entity est l''annotation JPA standard pour les entités.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','@Entity',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','@Table',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','@Document',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','@Model',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-DATA-002') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='spring_data' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-DATA-002',v_cert_id,v_theme_id,'Quelle interface étendre pour créer un repository JPA ?','easy','SINGLE_CHOICE','Plusieurs interfaces sont disponibles selon les besoins.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','JpaRepository<T, ID>',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','CrudRepository<T, ID>',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Repository<T, ID>',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-DATA-003') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='spring_data' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-DATA-003',v_cert_id,v_theme_id,'Quelle annotation active les repositories JPA ?','easy','SINGLE_CHOICE','@EnableJpaRepositories active la détection des repositories JPA.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','@EnableJpaRepositories',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','@EnableRepositories',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','@JpaRepositories',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','@EnableSpringData',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-DATA-004') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='spring_data' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-DATA-004',v_cert_id,v_theme_id,'Quelle méthode trouverait les utilisateurs par nom ?','medium','SINGLE_CHOICE','findBy suivi du nom de propriété est la convention Spring Data.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','findByName(String name)',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','getByName(String name)',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','selectByName(String name)',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','queryByName(String name)',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-DATA-005') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='spring_data' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-DATA-005',v_cert_id,v_theme_id,'Quelle méthode trouverait les utilisateurs par nom et âge ?','medium','SINGLE_CHOICE','And combine deux conditions dans le nom de méthode.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','findByNameAndAge(String name, int age)',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','findByNameAge(String name, int age)',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','findByName_Age(String name, int age)',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','findByName+Age(String name, int age)',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-DATA-006') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='spring_data' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-DATA-006',v_cert_id,v_theme_id,'Quelle méthode compterait les utilisateurs par nom ?','medium','SINGLE_CHOICE','countBy est le préfixe pour les méthodes de comptage.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','countByName(String name)',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','findCountByName(String name)',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','getCountByName(String name)',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','numberByName(String name)',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-DATA-007') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='spring_data' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-DATA-007',v_cert_id,v_theme_id,'Quelle méthode supprimerait les utilisateurs par nom ?','hard','SINGLE_CHOICE','deleteBy est le préfixe pour les suppressions.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','deleteByName(String name)',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','removeByName(String name)',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','eraseByName(String name)',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','clearByName(String name)',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-DATA-008') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='spring_data' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-DATA-008',v_cert_id,v_theme_id,'Que signifie le mot-clé ''Distinct'' dans une méthode ?','hard','SINGLE_CHOICE','Distinct élimine les doublons des résultats.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Retourne des résultats uniques',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Retourne des doublons',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Ignore les null',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Trie les résultats',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-DATA-009') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='spring_data' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-DATA-009',v_cert_id,v_theme_id,'Quelle méthode trouverait les 10 premiers utilisateurs ?','hard','SINGLE_CHOICE','First et Top sont équivalents pour limiter les résultats.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','findFirst10ByOrderByAge()',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','findTop10ByOrderByAge()',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','find10ByOrderByAge()',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A et B',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-DATA-010') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='spring_data' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-DATA-010',v_cert_id,v_theme_id,'Quelle annotation définit une requête JPQL personnalisée ?','medium','SINGLE_CHOICE','@Query permet d''écrire des requêtes JPQL personnalisées.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','@Query',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','@JPQL',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','@NativeQuery',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','@SqlQuery',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-DATA-011') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='spring_data' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-DATA-011',v_cert_id,v_theme_id,'Comment écrire une requête native SQL ?','medium','SINGLE_CHOICE','nativeQuery=true indique une requête SQL native.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','@Query(value = "SELECT * FROM user", nativeQuery = true)',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','@NativeQuery("SELECT * FROM user")',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','@SqlQuery("SELECT * FROM user")',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','@Query(native = true, value = "SELECT * FROM user")',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-DATA-012') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='spring_data' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-DATA-012',v_cert_id,v_theme_id,'Comment passer des paramètres dans @Query ?','hard','SINGLE_CHOICE','Les paramètres nommés (:param) ou positionnels (?1) sont supportés.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A',':param ou ?1',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','${param}',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','#{param}',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','@param',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-DATA-013') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='spring_data' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-DATA-013',v_cert_id,v_theme_id,'À quoi sert @Modifying ?','hard','SINGLE_CHOICE','@Modifying indique que la requête modifie les données.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Requête de modification',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Requête de lecture',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Requête de suppression',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Requête d''insertion',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-DATA-014') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='spring_data' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-DATA-014',v_cert_id,v_theme_id,'Que faut-il ajouter avec @Modifying pour vider le cache ?','hard','SINGLE_CHOICE','clearAutomatically vide le cache après la modification.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','@Modifying(clearAutomatically = true)',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','@Modifying(flushAutomatically = true)',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','@Modifying(clearPersistenceContext = true)',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','@Modifying(refresh = true)',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-DATA-015') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='spring_data' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-DATA-015',v_cert_id,v_theme_id,'Comment paginer les résultats d''un repository ?','hard','SINGLE_CHOICE','Pageable permet la pagination des résultats.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Ajouter Pageable en paramètre',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Ajouter PageRequest en paramètre',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Ajouter Sort en paramètre',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Ajouter Limit en paramètre',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-DATA-016') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='spring_data' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-DATA-016',v_cert_id,v_theme_id,'Quel type retourne une méthode avec Pageable ?','hard','SINGLE_CHOICE','Page ou Slice peuvent être retournés selon les besoins.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Page<T>',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','List<T>',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Slice<T>',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A et C',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-DATA-017') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='spring_data' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-DATA-017',v_cert_id,v_theme_id,'Différence entre Page et Slice ?','hard','SINGLE_CHOICE','Page inclut le nombre total d''éléments, Slice non.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Page connaît le total, Slice non',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Slice connaît le total, Page non',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Identiques',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Page est pour les listes, Slice pour les sets',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-DATA-018') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='spring_data' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-DATA-018',v_cert_id,v_theme_id,'Comment trier les résultats d''un repository ?','hard','SINGLE_CHOICE','Deux méthodes : OrderBy dans le nom ou paramètre Sort.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Ajouter Sort en paramètre',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Ajouter OrderBy dans le nom',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Ajouter @OrderBy',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A et B',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-DATA-019') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='spring_data' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-DATA-019',v_cert_id,v_theme_id,'Qu''est-ce qu''une projection ?','hard','SINGLE_CHOICE','Les projections limitent les champs retournés.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Sélectionner uniquement certains champs',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Joindre des tables',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Grouper des données',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Trier des résultats',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-DATA-020') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='spring_data' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-DATA-020',v_cert_id,v_theme_id,'Comment créer une projection interface ?','hard','SINGLE_CHOICE','Les interfaces et records peuvent servir de projections.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Interface avec des getters',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Classe avec des champs',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Record',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A et C',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-DATA-021') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='spring_data' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-DATA-021',v_cert_id,v_theme_id,'Les projections fermées utilisent-elles tous les champs ?','hard','SINGLE_CHOICE','Les projections fermées ne contiennent que les getters définis.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Non, seulement les getters définis',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Oui, tous les champs',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Oui, avec @Projection',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Non, avec @Closed',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-DATA-022') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='spring_data' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-DATA-022',v_cert_id,v_theme_id,'Quelle annotation gère les transactions ?','hard','SINGLE_CHOICE','@Transactional est l''annotation standard pour les transactions.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','@Transactional',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','@Transaction',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','@Tx',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','@Transact',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-DATA-023') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='spring_data' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-DATA-023',v_cert_id,v_theme_id,'Quelle propagation est la valeur par défaut ?','hard','SINGLE_CHOICE','REQUIRED est la propagation par défaut.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','REQUIRED',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','REQUIRES_NEW',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','MANDATORY',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','SUPPORTS',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-DATA-024') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='spring_data' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-DATA-024',v_cert_id,v_theme_id,'Quelle isolation est la valeur par défaut ?','hard','SINGLE_CHOICE','DEFAULT utilise l''isolation par défaut de la base de données.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','DEFAULT',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','READ_COMMITTED',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','REPEATABLE_READ',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','SERIALIZABLE',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-DATA-025') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='spring_data' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-DATA-025',v_cert_id,v_theme_id,'Quelle annotation active l''auditing ?','hard','SINGLE_CHOICE','@EnableJpaAuditing active l''auditing JPA.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','@EnableJpaAuditing',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','@EnableAuditing',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','@Auditing',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','@JpaAuditing',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-DATA-026') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='spring_data' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-DATA-026',v_cert_id,v_theme_id,'Quelle annotation marque une date de création ?','hard','SINGLE_CHOICE','@CreatedDate est géré par Spring Data.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','@CreatedDate',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','@CreationTimestamp',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','@CreateDate',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','@DateCreated',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-DATA-027') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='spring_data' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-DATA-027',v_cert_id,v_theme_id,'Quelle annotation marque une date de modification ?','hard','SINGLE_CHOICE','@LastModifiedDate est géré par Spring Data.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','@LastModifiedDate',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','@UpdateTimestamp',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','@ModificationDate',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','@DateModified',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-DATA-028') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='spring_data' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-DATA-028',v_cert_id,v_theme_id,'Quelle annotation marque le créateur ?','hard','SINGLE_CHOICE','@CreatedBy capture l''utilisateur qui a créé l''entité.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','@CreatedBy',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','@Creator',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','@CreateBy',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','@Author',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-DATA-029') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='spring_data' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-DATA-029',v_cert_id,v_theme_id,'Quelle interface fournit l''utilisateur courant ?','hard','SINGLE_CHOICE','AuditorAware fournit l''utilisateur courant pour l''auditing.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','AuditorAware<T>',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','CurrentUserProvider',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','UserAuditor',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','AuditProvider',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-DATA-030') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='spring_data' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-DATA-030',v_cert_id,v_theme_id,'Quelle annotation marque une entité MongoDB ?','hard','SINGLE_CHOICE','@Document est l''annotation pour les entités MongoDB.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','@Document',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','@Entity',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','@Collection',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','@MongoEntity',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-DATA-031') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='spring_data' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-DATA-031',v_cert_id,v_theme_id,'Quelle interface étendre pour un repository MongoDB ?','hard','SINGLE_CHOICE','MongoRepository étend CrudRepository pour MongoDB.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','MongoRepository<T, ID>',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','MongoDbRepository<T, ID>',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','DocumentRepository<T, ID>',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','NoSqlRepository<T, ID>',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-DATA-032') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='spring_data' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-DATA-032',v_cert_id,v_theme_id,'Quelle annotation marque une entité Redis ?','hard','SINGLE_CHOICE','@RedisHash définit la clé pour les entités Redis.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','@RedisHash',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','@RedisEntity',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','@Hash',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','@RedisDocument',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-DATA-033') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='spring_data' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-DATA-033',v_cert_id,v_theme_id,'Quelle interface étendre pour un repository Redis ?','hard','SINGLE_CHOICE','CrudRepository fonctionne avec Redis via Spring Data Redis.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','CrudRepository<T, ID>',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','RedisRepository<T, ID>',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','KeyValueRepository<T, ID>',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','HashRepository<T, ID>',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-DATA-034') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='spring_data' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-DATA-034',v_cert_id,v_theme_id,'Quelle annotation marque une table Cassandra ?','hard','SINGLE_CHOICE','@Table est l''annotation pour les tables Cassandra.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','@Table',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','@CassandraTable',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','@ColumnFamily',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','@Entity',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-DATA-035') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='spring_data' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-DATA-035',v_cert_id,v_theme_id,'Quelle interface étendre pour un repository Cassandra ?','hard','SINGLE_CHOICE','CassandraRepository est l''interface spécifique pour Cassandra.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','CassandraRepository<T, ID>',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','CrudRepository<T, ID>',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','CqlRepository<T, ID>',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','NoSqlRepository<T, ID>',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-DATA-036') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='spring_data' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-DATA-036',v_cert_id,v_theme_id,'Quelle annotation marque une entité JDBC ?','hard','SINGLE_CHOICE','@Table est l''annotation pour les entités Spring Data JDBC.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','@Table',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','@JdbcEntity',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','@Row',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','@JdbcTable',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-DATA-037') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='spring_data' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-DATA-037',v_cert_id,v_theme_id,'Quelle interface étendre pour un repository JDBC ?','hard','SINGLE_CHOICE','CrudRepository fonctionne avec Spring Data JDBC.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','CrudRepository<T, ID>',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','JdbcRepository<T, ID>',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','RowMapper<T>',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','SimpleJdbcRepository<T, ID>',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-DATA-038') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='spring_data' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-DATA-038',v_cert_id,v_theme_id,'Qu''est-ce que R2DBC ?','hard','SINGLE_CHOICE','R2DBC est l''API reactive pour les bases de données.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','API reactive pour bases de données',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','ORM traditionnel',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Pool de connexions',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Driver JDBC',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-DATA-039') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='spring_data' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-DATA-039',v_cert_id,v_theme_id,'Quelle interface étendre pour un repository R2DBC ?','hard','SINGLE_CHOICE','ReactiveCrudRepository est l''interface pour R2DBC.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','ReactiveCrudRepository<T, ID>',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','R2dbcRepository<T, ID>',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','ReactiveRepository<T, ID>',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','FluxRepository<T, ID>',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-DATA-040') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='spring_data' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-DATA-040',v_cert_id,v_theme_id,'Quels types sont utilisés pour les résultats ?','hard','SINGLE_CHOICE','Les types reactive Project Reactor sont utilisés.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Mono<T> et Flux<T>',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','CompletableFuture<T>',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','DeferredResult<T>',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','ListenableFuture<T>',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-DATA-041') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='spring_data' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-DATA-041',v_cert_id,v_theme_id,'Qu''est-ce qu''une Specification ?','hard','SINGLE_CHOICE','Les Specifications permettent de construire des requêtes dynamiques.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Requête dynamique',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Requête fixe',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Requête native',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Requête JPQL',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-DATA-042') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='spring_data' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-DATA-042',v_cert_id,v_theme_id,'Quelle interface étendre pour les Specifications ?','hard','SINGLE_CHOICE','Specification est l''interface pour les requêtes dynamiques.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Specification<T>',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','QuerySpecification<T>',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','DynamicQuery<T>',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','CriteriaQuery<T>',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-DATA-043') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='spring_data' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-DATA-043',v_cert_id,v_theme_id,'Qu''est-ce que QueryDSL ?','hard','SINGLE_CHOICE','QueryDSL permet des requêtes type-safe avec une API fluente.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Framework de requêtes type-safe',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','ORM',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Pool de connexions',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Cache',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-DATA-044') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='spring_data' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-DATA-044',v_cert_id,v_theme_id,'Quelle interface étendre pour QueryDSL ?','hard','SINGLE_CHOICE','QuerydslPredicateExecutor ajoute le support QueryDSL.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','QuerydslPredicateExecutor<T>',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','QueryDslRepository<T>',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','PredicateExecutor<T>',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','DslRepository<T>',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-DATA-045') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='spring_data' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-DATA-045',v_cert_id,v_theme_id,'À quoi servent les Entity Graphs ?','hard','SINGLE_CHOICE','Les Entity Graphs contrôlent quelles associations sont chargées.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Optimiser les chargements JPA',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Définir des index',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Créer des contraintes',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Gérer les transactions',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-DATA-046') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='spring_data' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-DATA-046',v_cert_id,v_theme_id,'Quelle annotation définit un Entity Graph ?','hard','SINGLE_CHOICE','@NamedEntityGraph définit un graph nommé.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','@NamedEntityGraph',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','@EntityGraph',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','@Graph',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','@FetchGraph',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-DATA-047') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='spring_data' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-DATA-047',v_cert_id,v_theme_id,'Comment utiliser un Entity Graph dans un repository ?','hard','SINGLE_CHOICE','@EntityGraph sur une méthode de repository active le graph.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','@EntityGraph(attributePaths = {"address"})',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','@Fetch(attributePaths = {"address"})',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','@Load(attributePaths = {"address"})',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','@Graph(attributePaths = {"address"})',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-DATA-048') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='spring_data' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-DATA-048',v_cert_id,v_theme_id,'Qu''est-ce que le problème N+1 ?','hard','SINGLE_CHOICE','Le problème N+1 est une requête principale suivie de N requêtes pour les associations.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','N requêtes + 1 pour les associations',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','N tables + 1 join',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','N transactions + 1 rollback',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','N caches + 1 miss',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-DATA-049') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='spring_data' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-DATA-049',v_cert_id,v_theme_id,'Comment résoudre le problème N+1 ?','hard','SINGLE_CHOICE','Plusieurs techniques résolvent le problème N+1.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','JOIN FETCH',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Entity Graphs',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','@BatchSize',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-DATA-050') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='spring_data' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-DATA-050',v_cert_id,v_theme_id,'Quelle est la syntaxe JOIN FETCH ?','hard','SINGLE_CHOICE','JOIN FETCH charge l''association dans la même requête.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','FROM User u JOIN FETCH u.address',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','FROM User u JOIN u.address FETCH',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','FROM User u FETCH JOIN u.address',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','FROM User u INNER FETCH u.address',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-SEC-001') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='spring_security' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-SEC-001',v_cert_id,v_theme_id,'Quelle dépendance ajoute Spring Security ?','easy','SINGLE_CHOICE','Le starter spring-boot-starter-security inclut toutes les dépendances nécessaires.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','spring-boot-starter-security',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','spring-security-core',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','spring-security-starter',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','spring-boot-security',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-SEC-002') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='spring_security' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-SEC-002',v_cert_id,v_theme_id,'Quel est l''utilisateur par défaut créé par Spring Security ?','easy','SINGLE_CHOICE','Spring Security crée un utilisateur ''user'' avec un mot de passe généré.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','user',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','admin',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','spring',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','default',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-SEC-003') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='spring_security' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-SEC-003',v_cert_id,v_theme_id,'Où est affiché le mot de passe par défaut ?','easy','SINGLE_CHOICE','Le mot de passe est affiché dans les logs au démarrage de l''application.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Dans les logs au démarrage',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Dans application.properties',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Dans la console',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Dans un fichier séparé',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-SEC-004') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='spring_security' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-SEC-004',v_cert_id,v_theme_id,'Comment désactiver la sécurité par défaut ?','medium','SINGLE_CHOICE','Exclure SecurityAutoConfiguration désactive la sécurité par défaut.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','spring.security.enabled=false',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','security.basic.enabled=false',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','spring.autoconfigure.exclude=SecurityAutoConfiguration',TRUE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','spring.security.disabled=true',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-SEC-005') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='spring_security' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-SEC-005',v_cert_id,v_theme_id,'Quel bean configure la sécurité ?','medium','SINGLE_CHOICE','SecurityFilterChain est le bean de configuration moderne (Spring Security 5.7+).','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','SecurityFilterChain',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','WebSecurityConfigurerAdapter',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','HttpSecurity',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','AuthenticationManager',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-SEC-006') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='spring_security' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-SEC-006',v_cert_id,v_theme_id,'Quelle annotation remplace WebSecurityConfigurerAdapter ?','hard','SINGLE_CHOICE','@EnableWebSecurity avec un bean SecurityFilterChain remplace l''ancien adaptateur.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','@EnableWebSecurity',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','@SecurityConfig',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','@WebSecurity',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','@EnableSecurity',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-SEC-007') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='spring_security' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-SEC-007',v_cert_id,v_theme_id,'Comment autoriser toutes les requêtes ?','medium','SINGLE_CHOICE','anyRequest().permitAll() autorise toutes les requêtes sans authentification.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','http.authorizeHttpRequests().anyRequest().permitAll()',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','http.authorizeRequests().anyRequest().permitAll()',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','http.authorizeHttpRequests().allRequests().permitAll()',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','http.authorizeRequests().all().permit()',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-SEC-008') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='spring_security' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-SEC-008',v_cert_id,v_theme_id,'Comment exiger l''authentification pour toutes les requêtes ?','hard','SINGLE_CHOICE','Les deux syntaxes sont acceptées selon la version.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','http.authorizeHttpRequests().anyRequest().authenticated()',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','http.authorizeRequests().anyRequest().authenticated()',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','http.authorizeHttpRequests().allRequests().authenticated()',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A et B',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-SEC-009') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='spring_security' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-SEC-009',v_cert_id,v_theme_id,'Comment définir des règles par URL ?','hard','SINGLE_CHOICE','Plusieurs méthodes existent selon la version et le besoin.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','http.authorizeHttpRequests().requestMatchers("/admin/**").hasRole("ADMIN")',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','http.authorizeRequests().antMatchers("/admin/**").hasRole("ADMIN")',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','http.authorizeHttpRequests().mvcMatchers("/admin/**").hasRole("ADMIN")',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-SEC-010') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='spring_security' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-SEC-010',v_cert_id,v_theme_id,'Quelle interface représente un utilisateur authentifié ?','medium','SINGLE_CHOICE','UserDetails est l''interface standard pour les utilisateurs.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','UserDetails',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Authentication',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Principal',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','User',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-SEC-011') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='spring_security' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-SEC-011',v_cert_id,v_theme_id,'Quelle interface charge les utilisateurs ?','hard','SINGLE_CHOICE','UserDetailsService charge les utilisateurs par nom d''utilisateur.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','UserDetailsService',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','AuthenticationProvider',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','UserDetailsManager',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','UserService',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-SEC-012') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='spring_security' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-SEC-012',v_cert_id,v_theme_id,'Quel encodeur est recommandé ?','medium','SINGLE_CHOICE','BCryptPasswordEncoder est l''encodeur recommandé pour les mots de passe.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','BCryptPasswordEncoder',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','MD5PasswordEncoder',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','ShaPasswordEncoder',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','PlainTextPasswordEncoder',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-SEC-013') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='spring_security' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-SEC-013',v_cert_id,v_theme_id,'Comment déclarer l''encodeur de mots de passe ?','hard','SINGLE_CHOICE','Plusieurs façons de déclarer l''encodeur.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','@Bean public PasswordEncoder passwordEncoder() { return new BCryptPasswordEncoder(); }',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','@Bean public PasswordEncoder encoder() { return PasswordEncoderFactories.createDelegatingPasswordEncoder(); }',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','@Bean public BCryptPasswordEncoder bCryptPasswordEncoder() { return new BCryptPasswordEncoder(); }',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A et B',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-SEC-014') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='spring_security' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-SEC-014',v_cert_id,v_theme_id,'Quel est le format du mot de passe avec DelegatingPasswordEncoder ?','hard','SINGLE_CHOICE','Le préfixe {bcrypt} indique l''algorithme utilisé.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','{bcrypt}$2a$10$...',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','$2a$10$...',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','bcrypt:$2a$10$...',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Bcrypt:$2a$10$...',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-SEC-015') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='spring_security' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-SEC-015',v_cert_id,v_theme_id,'La protection CSRF est-elle activée par défaut ?','hard','SINGLE_CHOICE','La protection CSRF est activée par défaut pour les applications web.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Oui',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Uniquement pour les API REST',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Uniquement pour les formulaires',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-SEC-016') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='spring_security' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-SEC-016',v_cert_id,v_theme_id,'Comment désactiver CSRF pour une API REST ?','hard','SINGLE_CHOICE','La syntaxe a évolué avec les versions.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','http.csrf().disable()',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','http.csrf().disabled()',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','http.csrf(csrf -> csrf.disable())',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A et C',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-SEC-017') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='spring_security' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-SEC-017',v_cert_id,v_theme_id,'Comment configurer CORS ?','hard','SINGLE_CHOICE','Plusieurs niveaux de configuration CORS existent.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','http.cors().configurationSource(corsConfigurationSource())',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','http.cors(cors -> cors.configurationSource(corsConfigurationSource()))',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','@CrossOrigin',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-SEC-018') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='spring_security' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-SEC-018',v_cert_id,v_theme_id,'Comment configurer une application stateless (JWT) ?','hard','SINGLE_CHOICE','STATELESS désactive la création de sessions HTTP.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','http.sessionManagement().sessionCreationPolicy(SessionCreationPolicy.STATELESS)',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','http.sessionManagement().stateless()',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','http.sessionManagement().sessionPolicy(SessionPolicy.STATELESS)',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','http.sessionCreationPolicy(STATELESS)',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-SEC-019') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='spring_security' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-SEC-019',v_cert_id,v_theme_id,'Quelle annotation active la sécurité au niveau des méthodes ?','hard','SINGLE_CHOICE','@EnableMethodSecurity est l''annotation moderne pour la sécurité des méthodes.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','@EnableMethodSecurity',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','@EnableGlobalMethodSecurity',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','@MethodSecurity',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','@GlobalMethodSecurity',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-SEC-020') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='spring_security' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-SEC-020',v_cert_id,v_theme_id,'Quelle annotation restreint l''accès à une méthode ?','hard','SINGLE_CHOICE','Plusieurs annotations sont supportées selon la configuration.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','@PreAuthorize("hasRole(''ADMIN'')")',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','@Secured("ROLE_ADMIN")',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','@RolesAllowed("ADMIN")',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-SEC-021') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='spring_security' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-SEC-021',v_cert_id,v_theme_id,'Comment filtrer les résultats d''une méthode ?','hard','SINGLE_CHOICE','@PostFilter filtre les résultats retournés par une méthode.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','@PostFilter',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','@PreFilter',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','@Filter',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','@AfterFilter',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-SEC-022') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='spring_security' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-SEC-022',v_cert_id,v_theme_id,'Quelle bibliothèque est recommandée pour JWT ?','hard','SINGLE_CHOICE','Plusieurs bibliothèques JWT sont disponibles.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','jjwt (io.jsonwebtoken)',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','nimbus-jose-jwt',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','java-jwt',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-SEC-023') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='spring_security' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-SEC-023',v_cert_id,v_theme_id,'Quel filtre vérifie le token JWT ?','hard','SINGLE_CHOICE','Un filtre OncePerRequestFilter personnalisé vérifie le token.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','OncePerRequestFilter personnalisé',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','JwtAuthenticationFilter',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','TokenAuthenticationFilter',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','BearerTokenAuthenticationFilter',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-SEC-024') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='spring_security' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-SEC-024',v_cert_id,v_theme_id,'Quelle dépendance ajoute OAuth2 ?','hard','SINGLE_CHOICE','Deux starters selon le besoin (client ou resource server).','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','spring-boot-starter-oauth2-resource-server',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','spring-boot-starter-oauth2-client',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','spring-security-oauth2',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A et B',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-SEC-025') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='spring_security' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-SEC-025',v_cert_id,v_theme_id,'Comment configurer un resource server JWT ?','hard','SINGLE_CHOICE','Configuration par properties ou Java config.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','spring.security.oauth2.resourceserver.jwt.jwk-set-uri',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','spring.security.oauth2.resourceserver.jwt.issuer-uri',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','http.oauth2ResourceServer().jwt()',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-SEC-026') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='spring_security' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-SEC-026',v_cert_id,v_theme_id,'Comment configurer un client OAuth2 ?','hard','SINGLE_CHOICE','Configuration par properties et Java config.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','spring.security.oauth2.client.registration',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','spring.security.oauth2.client.provider',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','http.oauth2Login()',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-SEC-027') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='spring_security' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-SEC-027',v_cert_id,v_theme_id,'Comment obtenir l''AuthenticationManager ?','hard','SINGLE_CHOICE','Plusieurs façons d''obtenir l''AuthenticationManager.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','@Autowired AuthenticationManager',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','AuthenticationManagerBuilder',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','http.getSharedObject(AuthenticationManager.class)',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','B et C',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-SEC-028') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='spring_security' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-SEC-028',v_cert_id,v_theme_id,'Comment créer un AuthenticationProvider personnalisé ?','hard','SINGLE_CHOICE','Plusieurs approches pour créer un provider personnalisé.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Implémenter AuthenticationProvider',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Étendre AbstractUserDetailsAuthenticationProvider',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Étendre DaoAuthenticationProvider',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-SEC-029') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='spring_security' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-SEC-029',v_cert_id,v_theme_id,'Comment activer Remember Me ?','hard','SINGLE_CHOICE','rememberMe() active la fonctionnalité avec configuration optionnelle.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','http.rememberMe()',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','http.rememberMe().key("uniqueKey")',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','http.rememberMe().tokenValiditySeconds(86400)',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-SEC-030') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='spring_security' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-SEC-030',v_cert_id,v_theme_id,'Comment configurer la déconnexion ?','hard','SINGLE_CHOICE','logout() active la déconnexion avec configuration optionnelle.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','http.logout()',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','http.logout().logoutUrl("/logout")',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','http.logout().logoutSuccessUrl("/login?logout")',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-SEC-031') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='spring_security' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-SEC-031',v_cert_id,v_theme_id,'Comment personnaliser la page de login ?','hard','SINGLE_CHOICE','formLogin() permet de personnaliser la page de connexion.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','http.formLogin().loginPage("/login")',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','http.formLogin().defaultSuccessUrl("/home")',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','http.formLogin().failureUrl("/login?error")',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-SEC-032') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='spring_security' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-SEC-032',v_cert_id,v_theme_id,'Comment personnaliser la réponse 403 ?','hard','SINGLE_CHOICE','ExceptionHandling permet de personnaliser les réponses d''erreur.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','http.exceptionHandling().accessDeniedPage("/access-denied")',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','http.exceptionHandling().accessDeniedHandler(handler)',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','http.exceptionHandling().authenticationEntryPoint(entryPoint)',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-SEC-033') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='spring_security' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-SEC-033',v_cert_id,v_theme_id,'Quels en-têtes de sécurité sont ajoutés par défaut ?','hard','SINGLE_CHOICE','Spring Security ajoute plusieurs en-têtes de sécurité par défaut.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','X-Content-Type-Options, X-Frame-Options',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Cache-Control',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Strict-Transport-Security',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-SEC-034') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='spring_security' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-SEC-034',v_cert_id,v_theme_id,'Comment désactiver les en-têtes de sécurité ?','hard','SINGLE_CHOICE','headers().disable() désactive tous les en-têtes de sécurité.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','http.headers().disable()',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','http.headers(headers -> headers.disable())',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','headers.enabled=false',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A et B',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-SEC-035') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='spring_security' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-SEC-035',v_cert_id,v_theme_id,'Comment tester un contrôleur sécurisé ?','hard','SINGLE_CHOICE','Plusieurs annotations permettent de simuler l''authentification.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','@WithMockUser',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','@WithUserDetails',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','@WithAnonymousUser',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-SEC-036') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='spring_security' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-SEC-036',v_cert_id,v_theme_id,'Comment tester avec un utilisateur spécifique ?','hard','SINGLE_CHOICE','WithMockUser et WithUserDetails simulent des utilisateurs.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','@WithMockUser(username = "admin", roles = {"ADMIN"})',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','@WithUserDetails("admin")',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','@WithSecurityContext',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A et B',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-SEC-037') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='spring_security' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-SEC-037',v_cert_id,v_theme_id,'Quelle annotation active la sécurité pour les tests ?','hard','SINGLE_CHOICE','@EnableMethodSecurity doit être activée pour les tests de sécurité.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','@EnableMethodSecurity',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','@TestSecurity',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','@WithSecurityContext',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','@MockSecurity',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-SEC-038') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='spring_security' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-SEC-038',v_cert_id,v_theme_id,'Quel est le facteur de force par défaut de BCrypt ?','hard','SINGLE_CHOICE','Le facteur de force par défaut est 10 (2^10 itérations).','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','10',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','12',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','8',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','14',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-SEC-039') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='spring_security' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-SEC-039',v_cert_id,v_theme_id,'Où sont stockés les mots de passe par défaut ?','hard','SINGLE_CHOICE','Par défaut, les utilisateurs sont stockés en mémoire.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','En mémoire',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','En base de données',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Dans un fichier',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Dans le cache',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-SEC-040') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='spring_security' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-SEC-040',v_cert_id,v_theme_id,'Comment configurer l''authentification JDBC ?','hard','SINGLE_CHOICE','jdbcAuthentication() configure l''authentification via JDBC.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','http.jdbcAuthentication()',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','auth.jdbcAuthentication().dataSource(dataSource)',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','http.userDetailsService(jdbcUserDetailsManager)',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A et B',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-SEC-041') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='spring_security' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-SEC-041',v_cert_id,v_theme_id,'Comment configurer l''authentification LDAP ?','hard','SINGLE_CHOICE','ldapAuthentication() configure l''authentification LDAP.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','http.ldapAuthentication()',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','auth.ldapAuthentication().contextSource()',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','http.ldapAuthentication().userDnPatterns()',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-SEC-042') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='spring_security' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-SEC-042',v_cert_id,v_theme_id,'Comment Spring Security protège contre la fixation de session ?','hard','SINGLE_CHOICE','Spring Security change l''ID de session à l''authentification.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Nouvelle session à la connexion',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Migration de session',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Changement d''ID',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-SEC-043') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='spring_security' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-SEC-043',v_cert_id,v_theme_id,'Comment limiter le nombre de sessions simultanées ?','hard','SINGLE_CHOICE','maximumSessions(1) limite à une session par utilisateur.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','http.sessionManagement().maximumSessions(1)',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','http.sessionManagement().maxSessionsPerUser(1)',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','http.sessionManagement().concurrentSessions(1)',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','http.sessionManagement().sessionConcurrency(1)',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-SEC-044') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='spring_security' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-SEC-044',v_cert_id,v_theme_id,'Comment implémenter l''historique des mots de passe ?','hard','SINGLE_CHOICE','L''historique nécessite une implémentation personnalisée.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','PasswordEncoder personnalisé',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','UserDetailsService personnalisé',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','AuthenticationProvider personnalisé',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-SEC-045') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='spring_security' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-SEC-045',v_cert_id,v_theme_id,'Comment implémenter le verrouillage de compte ?','hard','SINGLE_CHOICE','Le verrouillage combine UserDetails et gestion des échecs.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','UserDetails.isAccountNonLocked()',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','AuthenticationFailureHandler',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','UserDetailsService',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A et B',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-SEC-046') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='spring_security' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-SEC-046',v_cert_id,v_theme_id,'Comment gérer l''expiration des mots de passe ?','hard','SINGLE_CHOICE','L''expiration combine UserDetails et logique personnalisée.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','UserDetails.isCredentialsNonExpired()',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','PasswordEncoder personnalisé',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','AuthenticationProvider',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A et B',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-SEC-047') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='spring_security' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-SEC-047',v_cert_id,v_theme_id,'Comment implémenter la 2FA ?','hard','SINGLE_CHOICE','La 2FA nécessite une implémentation personnalisée.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','AuthenticationProvider personnalisé',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Deuxième facteur avec token',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Spring Security Extension',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-SEC-048') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='spring_security' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-SEC-048',v_cert_id,v_theme_id,'Comment implémenter la réinitialisation de mot de passe ?','hard','SINGLE_CHOICE','La réinitialisation combine plusieurs composants.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Token sécurisé',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Email avec lien',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Formulaire de réinitialisation',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-SEC-049') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='spring_security' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-SEC-049',v_cert_id,v_theme_id,'Comment écouter les événements de sécurité ?','hard','SINGLE_CHOICE','Plusieurs façons d''écouter les événements d''authentification.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','@EventListener',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','ApplicationListener<AbstractAuthenticationEvent>',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','AuthenticationEventPublisher',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-SEC-050') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='spring_security' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-SEC-050',v_cert_id,v_theme_id,'Quelle est la meilleure pratique pour les mots de passe ?','hard','SINGLE_CHOICE','Les bonnes pratiques combinent plusieurs aspects.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','BCrypt avec force ≥ 10',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Salage individuel',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Longueur minimale 8',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-CLD-001') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='spring_cloud' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-CLD-001',v_cert_id,v_theme_id,'Qu''est-ce que Spring Cloud ?','medium','SINGLE_CHOICE','Spring Cloud fournit des outils pour les architectures microservices.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Framework pour microservices',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Serveur web',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Base de données',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','ORM',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-CLD-002') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='spring_cloud' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-CLD-002',v_cert_id,v_theme_id,'Quel service est utilisé pour la découverte de services ?','easy','SINGLE_CHOICE','Plusieurs options de service discovery existent.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Eureka',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Consul',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Zookeeper',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-CLD-003') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='spring_cloud' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-CLD-003',v_cert_id,v_theme_id,'Quelle annotation active un serveur Eureka ?','medium','SINGLE_CHOICE','@EnableEurekaServer transforme l''application en serveur Eureka.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','@EnableEurekaServer',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','@EnableDiscoveryServer',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','@EurekaServer',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','@EnableServiceRegistry',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-CLD-004') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='spring_cloud' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-CLD-004',v_cert_id,v_theme_id,'Quelle annotation active un client Eureka ?','medium','SINGLE_CHOICE','@EnableDiscoveryClient est générique pour plusieurs implémentations.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','@EnableEurekaClient',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','@EnableDiscoveryClient',TRUE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','@EurekaClient',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','@EnableServiceDiscovery',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-CLD-005') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='spring_cloud' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-CLD-005',v_cert_id,v_theme_id,'Quel client HTTP supporte le load balancing ?','hard','SINGLE_CHOICE','Plusieurs clients supportent le load balancing.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','RestTemplate avec @LoadBalanced',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','WebClient.Builder avec @LoadBalanced',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','FeignClient',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-CLD-006') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='spring_cloud' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-CLD-006',v_cert_id,v_theme_id,'Quelle annotation marque un client Feign ?','hard','SINGLE_CHOICE','@FeignClient déclare un client HTTP déclaratif.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','@FeignClient',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','@RestClient',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','@HttpClient',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','@ServiceClient',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-CLD-007') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='spring_cloud' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-CLD-007',v_cert_id,v_theme_id,'Comment activer les clients Feign ?','hard','SINGLE_CHOICE','@EnableFeignClients active la détection des clients Feign.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','@EnableFeignClients',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','@FeignClients',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','@EnableFeign',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','@FeignAutoConfiguration',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-CLD-008') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='spring_cloud' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-CLD-008',v_cert_id,v_theme_id,'Quelle annotation active un circuit breaker ?','hard','SINGLE_CHOICE','@HystrixCommand (ancien) ou l''API Resilience4j moderne.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','@CircuitBreaker',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','@HystrixCommand',TRUE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','@Resilience4j',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','@Retryable',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-CLD-009') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='spring_cloud' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-CLD-009',v_cert_id,v_theme_id,'Quels patterns sont supportés par Resilience4j ?','hard','SINGLE_CHOICE','Resilience4j supporte de nombreux patterns de résilience.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Circuit Breaker, Retry, Rate Limiter',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Time Limiter, Bulkhead',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Cache, Fallback',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-CLD-010') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='spring_cloud' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-CLD-010',v_cert_id,v_theme_id,'Quels sont les états d''un circuit breaker ?','hard','SINGLE_CHOICE','CLOSED (normal), OPEN (coupé), HALF_OPEN (test).','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','CLOSED, OPEN, HALF_OPEN',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','ON, OFF, TEST',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','ACTIVE, INACTIVE, PENDING',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','RUNNING, STOPPED, PAUSED',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-CLD-011') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='spring_cloud' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-CLD-011',v_cert_id,v_theme_id,'Quel projet Spring Cloud est un API Gateway ?','hard','SINGLE_CHOICE','Gateway (WebFlux) et Zuul (Servlet) sont les deux gateways.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Spring Cloud Gateway',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Spring Cloud Zuul',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Spring Cloud Router',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A et B',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-CLD-012') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='spring_cloud' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-CLD-012',v_cert_id,v_theme_id,'Comment définir une route dans Gateway ?','hard','SINGLE_CHOICE','Plusieurs façons de configurer les routes.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','spring.cloud.gateway.routes',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','@Bean RouteLocator',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Configuration Java',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-CLD-013') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='spring_cloud' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-CLD-013',v_cert_id,v_theme_id,'Quels types de filtres existent dans Gateway ?','hard','SINGLE_CHOICE','Gateway supporte plusieurs types de filtres.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Pre et Post filters',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Global filters',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Route filters',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-CLD-014') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='spring_cloud' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-CLD-014',v_cert_id,v_theme_id,'Quel service centralise la configuration ?','hard','SINGLE_CHOICE','Config Server centralise la configuration externe.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Spring Cloud Config Server',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Spring Cloud Vault',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Spring Cloud Configuration',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Spring Config',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-CLD-015') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='spring_cloud' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-CLD-015',v_cert_id,v_theme_id,'Quelle annotation active un Config Server ?','hard','SINGLE_CHOICE','@EnableConfigServer transforme l''application en serveur de configuration.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','@EnableConfigServer',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','@ConfigurationServer',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','@ConfigServer',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','@EnableConfigurationServer',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-CLD-016') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='spring_cloud' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-CLD-016',v_cert_id,v_theme_id,'Quels backends sont supportés par Config Server ?','hard','SINGLE_CHOICE','De nombreux backends sont supportés.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Git, Vault, JDBC',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Filesystem, S3',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Consul, Etcd',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-CLD-017') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='spring_cloud' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-CLD-017',v_cert_id,v_theme_id,'Comment un client charge la configuration ?','hard','SINGLE_CHOICE','Le client charge la configuration au démarrage.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','spring.config.import=configserver:',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','@RefreshScope',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','@ConfigurationProperties',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A et C',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-CLD-018') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='spring_cloud' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-CLD-018',v_cert_id,v_theme_id,'À quoi sert @RefreshScope ?','hard','SINGLE_CHOICE','@RefreshScope permet de recharger les beans après un refresh.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Recharger la configuration dynamiquement',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Créer un scope personnalisé',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Gérer le cycle de vie',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Optimiser les performances',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-CLD-019') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='spring_cloud' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-CLD-019',v_cert_id,v_theme_id,'Qu''est-ce que Spring Cloud Bus ?','hard','SINGLE_CHOICE','Bus propage les événements (refresh, etc.) à travers les services.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Propagation d''événements entre services',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Message broker',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','API Gateway',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Service discovery',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-CLD-020') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='spring_cloud' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-CLD-020',v_cert_id,v_theme_id,'À quoi sert Spring Cloud Sleuth ?','hard','SINGLE_CHOICE','Sleuth ajoute des identifiants de trace pour le debugging distribué.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Tracing distribué',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Logging',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Monitoring',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Sécurité',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-CLD-021') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='spring_cloud' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-CLD-021',v_cert_id,v_theme_id,'Quels identifiants ajoute Sleuth ?','hard','SINGLE_CHOICE','Sleuth ajoute traceId et spanId aux logs.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','traceId, spanId',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','requestId, sessionId',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','correlationId, messageId',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','userId, transactionId',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-CLD-022') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='spring_cloud' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-CLD-022',v_cert_id,v_theme_id,'À quoi sert Zipkin ?','hard','SINGLE_CHOICE','Zipkin collecte et visualise les données de tracing.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Visualisation des traces',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Stockage des logs',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Métriques',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Alerting',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-CLD-023') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='spring_cloud' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-CLD-023',v_cert_id,v_theme_id,'Qu''est-ce que Spring Cloud Stream ?','hard','SINGLE_CHOICE','Stream simplifie le développement d''applications événementielles.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Framework pour messaging',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Stream processing',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Message broker',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','API Gateway',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-CLD-024') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='spring_cloud' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-CLD-024',v_cert_id,v_theme_id,'Quels binders sont supportés par Stream ?','hard','SINGLE_CHOICE','De nombreux binders sont disponibles.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Kafka, RabbitMQ',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','AWS Kinesis, Azure Event Hubs',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Google Pub/Sub',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-CLD-025') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='spring_cloud' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-CLD-025',v_cert_id,v_theme_id,'Quelle annotation marque un supplier de messages ?','hard','SINGLE_CHOICE','@Source (ancien) ou java.util.function.Supplier (moderne).','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','@Supplier',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','@Source',TRUE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','@Producer',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','@Publisher',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-CLD-026') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='spring_cloud' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-CLD-026',v_cert_id,v_theme_id,'Quelle annotation marque un consumer de messages ?','hard','SINGLE_CHOICE','@Sink (ancien) ou java.util.function.Consumer (moderne).','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','@Consumer',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','@Sink',TRUE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','@Processor',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','@Subscriber',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-CLD-027') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='spring_cloud' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-CLD-027',v_cert_id,v_theme_id,'Quel type de fonction traite et produit des messages ?','hard','SINGLE_CHOICE','Function transforme un message d''entrée en sortie.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Function<I, O>',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Supplier<O>',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Consumer<I>',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Processor<I, O>',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-CLD-028') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='spring_cloud' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-CLD-028',v_cert_id,v_theme_id,'Comment sécuriser les communications entre services ?','hard','SINGLE_CHOICE','Plusieurs options de sécurité sont disponibles.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Spring Cloud Security',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','OAuth2',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','mTLS',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-CLD-029') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='spring_cloud' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-CLD-029',v_cert_id,v_theme_id,'À quoi sert Spring Cloud Vault ?','hard','SINGLE_CHOICE','Vault gère les secrets (mots de passe, clés API, etc.).','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Gestion des secrets',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Configuration',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Service discovery',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Load balancing',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-CLD-030') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='spring_cloud' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-CLD-030',v_cert_id,v_theme_id,'Qu''est-ce que Spring Cloud Kubernetes ?','hard','SINGLE_CHOICE','Spring Cloud Kubernetes s''intègre avec les primitives K8s.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Intégration avec Kubernetes',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Service discovery via K8s',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Configuration via ConfigMaps',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-CLD-031') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='spring_cloud' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-CLD-031',v_cert_id,v_theme_id,'Comment activer la découverte Kubernetes ?','hard','SINGLE_CHOICE','La découverte nécessite l''activation explicite.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','@EnableDiscoveryClient',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','spring.cloud.kubernetes.discovery.enabled=true',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','spring.cloud.discovery.enabled=true',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A et B',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-CLD-032') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='spring_cloud' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-CLD-032',v_cert_id,v_theme_id,'Comment charger une ConfigMap ?','hard','SINGLE_CHOICE','Plusieurs façons de charger les ConfigMaps.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','spring.cloud.kubernetes.config.enabled=true',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','spring.cloud.kubernetes.config.name=my-config',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','@ConfigurationProperties',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-CLD-033') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='spring_cloud' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-CLD-033',v_cert_id,v_theme_id,'Qu''est-ce que Function Catalog ?','hard','SINGLE_CHOICE','Function Catalog permet de découvrir et d''invoquer des fonctions.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Registre de fonctions',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Message broker',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','API Gateway',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Service discovery',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-CLD-034') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='spring_cloud' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-CLD-034',v_cert_id,v_theme_id,'Qu''est-ce que Spring Cloud Deployer ?','hard','SINGLE_CHOICE','Deployer permet de déployer des applications sur différentes plateformes.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Déploiement d''applications',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Orchestration',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Service discovery',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Load balancing',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-CLD-035') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='spring_cloud' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-CLD-035',v_cert_id,v_theme_id,'Qu''est-ce que Spring Cloud Task ?','hard','SINGLE_CHOICE','Task permet de développer des applications batch qui s''exécutent et se terminent.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Applications batch',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Microservices',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','API Gateway',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Service discovery',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-CLD-036') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='spring_cloud' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-CLD-036',v_cert_id,v_theme_id,'Qu''est-ce que Spring Cloud Data Flow ?','hard','SINGLE_CHOICE','Data Flow orchestre des pipelines de données stream et batch.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Orchestration de pipelines de données',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Stream processing',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Batch processing',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-CLD-037') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='spring_cloud' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-CLD-037',v_cert_id,v_theme_id,'À quoi sert Spring Cloud Contract ?','hard','SINGLE_CHOICE','Contract permet de tester l''API des microservices via des contrats.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Consumer-driven contracts',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Tests de contrats',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','API versioning',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A et B',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-CLD-038') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='spring_cloud' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-CLD-038',v_cert_id,v_theme_id,'Que sont les stubs dans Contract ?','hard','SINGLE_CHOICE','Les stubs simulent le comportement du provider pour les tests.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Simulation du provider',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Simulation du consumer',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Données de test',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Configuration',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-CLD-039') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='spring_cloud' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-CLD-039',v_cert_id,v_theme_id,'À quoi sert Zookeeper dans Spring Cloud ?','hard','SINGLE_CHOICE','Zookeeper offre plusieurs services de coordination.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Service discovery',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Configuration distribuée',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Leadership election',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-CLD-040') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='spring_cloud' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-CLD-040',v_cert_id,v_theme_id,'À quoi sert Consul dans Spring Cloud ?','hard','SINGLE_CHOICE','Consul fournit discovery, config et health checks.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Service discovery',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Configuration',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Health checking',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-CLD-041') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='spring_cloud' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-CLD-041',v_cert_id,v_theme_id,'À quoi sert Nacos ?','hard','SINGLE_CHOICE','Nacos est une plateforme de discovery et config d''Alibaba.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Service discovery',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Configuration management',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Dynamic DNS',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-CLD-042') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='spring_cloud' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-CLD-042',v_cert_id,v_theme_id,'Quelle est la principale différence ?','hard','SINGLE_CHOICE','Gateway utilise WebFlux, Zuul utilise Servlet.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Gateway est non-bloquant (WebFlux)',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Zuul est bloquant (Servlet)',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Gateway est plus moderne',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-CLD-043') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='spring_cloud' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-CLD-043',v_cert_id,v_theme_id,'Hystrix est-il encore maintenu ?','hard','SINGLE_CHOICE','Hystrix est en mode maintenance, Resilience4j est recommandé.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Non, en maintenance mode',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Oui, activement',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Oui, mais déprécié',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Non, remplacé par Resilience4j',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-CLD-044') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='spring_cloud' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-CLD-044',v_cert_id,v_theme_id,'À quoi sert le bootstrap context ?','hard','SINGLE_CHOICE','Le bootstrap context charge la configuration externe (Config Server).','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Configuration externe',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Démarrage des services',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Logging initial',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Security',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-CLD-045') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='spring_cloud' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-CLD-045',v_cert_id,v_theme_id,'Dans quel fichier sont les propriétés bootstrap ?','hard','SINGLE_CHOICE','bootstrap.yml est chargé avant application.yml.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','bootstrap.yml / bootstrap.properties',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','application.yml',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','config.yml',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','cloud.yml',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-CLD-046') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='spring_cloud' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-CLD-046',v_cert_id,v_theme_id,'À quoi sert Spring Cloud CLI ?','hard','SINGLE_CHOICE','La CLI offre des commandes utiles pour Spring Cloud.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Ligne de commande pour Spring Cloud',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','Déploiement rapide',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Encryption/decryption',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-CLD-047') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='spring_cloud' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-CLD-047',v_cert_id,v_theme_id,'Comment chiffrer les propriétés dans Config Server ?','hard','SINGLE_CHOICE','Les propriétés chiffrées utilisent le préfixe {cipher}.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','{cipher}...',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','encrypt.key',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','@Encrypted',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A et B',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-CLD-048') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='spring_cloud' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-CLD-048',v_cert_id,v_theme_id,'Comment propager un refresh à tous les services ?','hard','SINGLE_CHOICE','busrefresh propage l''événement à tous les services.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','POST /actuator/busrefresh',TRUE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','POST /actuator/bus-refresh',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','POST /actuator/refresh/bus',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','POST /actuator/bus/refresh',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-CLD-049') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='spring_cloud' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-CLD-049',v_cert_id,v_theme_id,'Comment ajouter un circuit breaker à Gateway ?','hard','SINGLE_CHOICE','CircuitBreaker est un filtre Gateway.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','filters: - CircuitBreaker',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','spring.cloud.gateway.circuitbreaker',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','filters: - name: CircuitBreaker',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','A et C',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='SB3-CLD-050') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='spring_cloud' LIMIT 1;
        v_q_id := uuid_generate_v4();
        INSERT INTO questions (id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES (v_q_id,'SB3-CLD-050',v_cert_id,v_theme_id,'Quelle est une bonne pratique pour les microservices ?','hard','SINGLE_CHOICE','Les bonnes pratiques incluent isolation des données, gateway et résilience.','PENDING',TRUE);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'A','Separate data per service',FALSE,0);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'B','API Gateway',FALSE,1);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'C','Circuit Breakers',FALSE,2);
        INSERT INTO question_options (id,question_id,label,text,is_correct,display_order) VALUES (uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
END $$;
