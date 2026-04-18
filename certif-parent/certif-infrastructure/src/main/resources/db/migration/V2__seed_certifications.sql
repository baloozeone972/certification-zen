-- =============================================================================
-- certif-infrastructure/src/main/resources/db/migration/V2__seed_certifications.sql
-- CertifApp — Seed des 15 certifications et de leurs thèmes
-- =============================================================================

-- =============================================================================
-- CERTIFICATIONS
-- =============================================================================

INSERT INTO certifications (id, code, name, description, total_questions,
                            exam_question_count, exam_duration_min, passing_score, exam_type)
VALUES ('ocp21', '1Z0-830', 'Oracle Certified Professional Java SE 21 (1Z0-830)',
        'Certification professionnelle Java 21 LTS — virtual threads, pattern matching, records, sealed classes.',
        500, 80, 180, 68, 'MCQ'),

       ('ocp17', '1Z0-829', 'Oracle Certified Professional Java SE 17 (1Z0-829)',
        'Certification professionnelle Java 17 LTS — modules JPMS, lambda, streams, NIO.2, concurrence.',
        450, 80, 180, 68, 'MCQ'),

       ('spring6', 'VMW-SPRING6', 'Spring Professional 6 (VMware/Broadcom)',
        'Certification Spring Framework 6 — IoC, MVC, Data JPA, Security, Boot, Cloud.',
        350, 60, 120, 70, 'MCQ'),

       ('springboot3', 'VMW-SB3', 'Spring Boot 3 Professional',
        'Spring Boot 3 — auto-configuration, starters, actuators, testing, DevTools, Docker.',
        300, 50, 90, 70, 'MCQ'),

       ('aws_ccp', 'CLF-C02', 'AWS Certified Cloud Practitioner (CLF-C02)',
        'Fondamentaux du cloud AWS — services core, facturation, sécurité, architecture.',
        300, 65, 90, 70, 'MCQ'),

       ('aws_saa', 'SAA-C03', 'AWS Certified Solutions Architect – Associate (SAA-C03)',
        'Conception d architectures AWS — HA, scalabilité, sécurité, stockage, compute.',
        500, 65, 130, 72, 'MCQ'),

       ('aws_dev', 'DVA-C02', 'AWS Certified Developer – Associate (DVA-C02)',
        'Développement cloud-native AWS — Lambda, API Gateway, DynamoDB, CI/CD, sécurité.',
        400, 65, 130, 70, 'MCQ'),

       ('docker', 'DCA', 'Docker Certified Associate (DCA)',
        'Conteneurisation Docker — images, networking, volumes, Compose, Swarm.',
        350, 55, 90, 75, 'MCQ'),

       ('cka', 'CKA', 'Certified Kubernetes Administrator (CKA)',
        'Administration de clusters Kubernetes — CNCF, examen pratique.',
        300, 17, 120, 66, 'PRACTICAL'),

       ('ckad', 'CKAD', 'Certified Kubernetes Application Developer (CKAD)',
        'Développement d applications cloud-native sur Kubernetes — CNCF, examen pratique.',
        250, 19, 120, 66, 'PRACTICAL'),

       ('cks', 'CKS', 'Certified Kubernetes Security Specialist (CKS)',
        'Sécurité avancée des clusters Kubernetes — CNCF, examen pratique.',
        200, 16, 120, 67, 'PRACTICAL'),

       ('android', 'ANDROID-KOTLIN', 'Android Kotlin & Jetpack Compose Developer',
        'Développement Android moderne — Kotlin, Jetpack Compose, MVVM, Hilt, Room, Coroutines.',
        300, 60, 90, 70, 'MCQ'),

       ('terraform', 'TERRAFORM-003', 'HashiCorp Certified Terraform Associate (003)',
        'Infrastructure as Code Terraform — HCL, state management, providers, modules.',
        300, 57, 60, 70, 'MCQ'),

       ('gcp_dl', 'GCP-CDL', 'Google Cloud Digital Leader',
        'Concepts fondamentaux Google Cloud Platform — transformation numérique, services core.',
        250, 50, 90, 70, 'MCQ'),

       ('java21', '1Z0-830-GEN', 'Java 21 Developer Certification — Parcours Général',
        'Préparation généraliste Java 21 — fondamentaux, POO, collections, lambda, streams, modules.',
        500, 80, 180, 68, 'MCQ');

-- =============================================================================
-- THÈMES PAR CERTIFICATION
-- =============================================================================

-- OCP Java 21 (1Z0-830)
INSERT INTO certification_themes (id, certification_id, code, label, question_count, display_order)
VALUES (uuid_generate_v4(), 'ocp21', 'virtual_threads', 'Virtual Threads', 60, 0),
       (uuid_generate_v4(), 'ocp21', 'pattern_matching', 'Pattern Matching avancé', 70, 1),
       (uuid_generate_v4(), 'ocp21', 'records_sealed', 'Records et Sealed Classes', 60, 2),
       (uuid_generate_v4(), 'ocp21', 'ffm_api', 'Foreign Function & Memory API', 50, 3),
       (uuid_generate_v4(), 'ocp21', 'vector_api', 'Vector API', 50, 4),
       (uuid_generate_v4(), 'ocp21', 'structured_concurrency', 'Structured Concurrency', 60, 5),
       (uuid_generate_v4(), 'ocp21', 'scoped_values', 'Scoped Values', 50, 6),
       (uuid_generate_v4(), 'ocp21', 'sequenced_collections', 'Sequenced Collections', 50, 7),
       (uuid_generate_v4(), 'ocp21', 'string_templates', 'String Templates', 50, 8);

-- OCP Java 17 (1Z0-829)
INSERT INTO certification_themes (id, certification_id, code, label, question_count, display_order)
VALUES (uuid_generate_v4(), 'ocp17', 'jpms', 'Java Modules (JPMS)', 50, 0),
       (uuid_generate_v4(), 'ocp17', 'collections', 'Collections et Génériques', 60, 1),
       (uuid_generate_v4(), 'ocp17', 'lambda_streams', 'Lambda et Streams API', 70, 2),
       (uuid_generate_v4(), 'ocp17', 'concurrence', 'Concurrence', 60, 3),
       (uuid_generate_v4(), 'ocp17', 'nio2', 'NIO.2 et I/O', 50, 4),
       (uuid_generate_v4(), 'ocp17', 'jdbc', 'JDBC et Bases de données', 50, 5),
       (uuid_generate_v4(), 'ocp17', 'pattern_matching', 'Pattern Matching (instanceof, switch)', 60, 6),
       (uuid_generate_v4(), 'ocp17', 'records_sealed', 'Records et Sealed Classes', 50, 7);

-- Spring Professional 6
INSERT INTO certification_themes (id, certification_id, code, label, question_count, display_order)
VALUES (uuid_generate_v4(), 'spring6', 'spring_core', 'Spring Core et IoC', 70, 0),
       (uuid_generate_v4(), 'spring6', 'spring_mvc', 'Spring MVC', 60, 1),
       (uuid_generate_v4(), 'spring6', 'spring_data', 'Spring Data et JPA', 60, 2),
       (uuid_generate_v4(), 'spring6', 'spring_security', 'Spring Security', 50, 3),
       (uuid_generate_v4(), 'spring6', 'spring_boot', 'Spring Boot', 70, 4),
       (uuid_generate_v4(), 'spring6', 'spring_cloud', 'Spring Cloud', 40, 5);

-- Spring Boot 3
INSERT INTO certification_themes (id, certification_id, code, label, question_count, display_order)
VALUES (uuid_generate_v4(), 'springboot3', 'auto_config', 'Spring Boot Auto-configuration', 60, 0),
       (uuid_generate_v4(), 'springboot3', 'starters', 'Spring Boot Starters', 50, 1),
       (uuid_generate_v4(), 'springboot3', 'actuator', 'Spring Boot Actuator', 50, 2),
       (uuid_generate_v4(), 'springboot3', 'testing', 'Spring Boot Testing', 50, 3),
       (uuid_generate_v4(), 'springboot3', 'devtools', 'Spring Boot DevTools', 40, 4),
       (uuid_generate_v4(), 'springboot3', 'docker', 'Spring Boot with Docker', 50, 5);

-- AWS Cloud Practitioner (CLF-C02)
INSERT INTO certification_themes (id, certification_id, code, label, question_count, display_order)
VALUES (uuid_generate_v4(), 'aws_ccp', 'cloud_concepts', 'Cloud Concepts', 60, 0),
       (uuid_generate_v4(), 'aws_ccp', 'core_services', 'Core Services', 120, 1),
       (uuid_generate_v4(), 'aws_ccp', 'security', 'Security', 60, 2),
       (uuid_generate_v4(), 'aws_ccp', 'billing', 'Billing & Support', 30, 3),
       (uuid_generate_v4(), 'aws_ccp', 'architecture', 'Well-Architected', 30, 4);

-- AWS Solutions Architect Associate (SAA-C03)
INSERT INTO certification_themes (id, certification_id, code, label, question_count, display_order)
VALUES (uuid_generate_v4(), 'aws_saa', 'compute', 'Compute (EC2, Lambda, ECS)', 80, 0),
       (uuid_generate_v4(), 'aws_saa', 'storage', 'Storage (S3, EBS, EFS)', 70, 1),
       (uuid_generate_v4(), 'aws_saa', 'database', 'Database (RDS, DynamoDB)', 60, 2),
       (uuid_generate_v4(), 'aws_saa', 'networking', 'Networking (VPC, Route53)', 80, 3),
       (uuid_generate_v4(), 'aws_saa', 'security_iam', 'Security & IAM', 70, 4),
       (uuid_generate_v4(), 'aws_saa', 'ha_scalability', 'High Availability & Scalability', 60, 5),
       (uuid_generate_v4(), 'aws_saa', 'monitoring', 'Monitoring & Logging', 40, 6),
       (uuid_generate_v4(), 'aws_saa', 'pricing', 'Pricing & Support', 40, 7);

-- AWS Developer Associate (DVA-C02)
INSERT INTO certification_themes (id, certification_id, code, label, question_count, display_order)
VALUES (uuid_generate_v4(), 'aws_dev', 'lambda', 'Lambda & Serverless', 80, 0),
       (uuid_generate_v4(), 'aws_dev', 'api_gateway', 'API Gateway', 60, 1),
       (uuid_generate_v4(), 'aws_dev', 'dynamodb', 'DynamoDB', 70, 2),
       (uuid_generate_v4(), 'aws_dev', 'storage', 'S3 & Storage', 60, 3),
       (uuid_generate_v4(), 'aws_dev', 'cicd', 'CI/CD (CodeSuite)', 70, 4),
       (uuid_generate_v4(), 'aws_dev', 'security_iam', 'Security & IAM', 60, 5);

-- Docker DCA
INSERT INTO certification_themes (id, certification_id, code, label, question_count, display_order)
VALUES (uuid_generate_v4(), 'docker', 'basics', 'Docker Basics', 60, 0),
       (uuid_generate_v4(), 'docker', 'images', 'Images et Dockerfiles', 70, 1),
       (uuid_generate_v4(), 'docker', 'networking', 'Networking Docker', 50, 2),
       (uuid_generate_v4(), 'docker', 'volumes', 'Volumes et Stockage', 50, 3),
       (uuid_generate_v4(), 'docker', 'compose', 'Docker Compose', 60, 4),
       (uuid_generate_v4(), 'docker', 'swarm', 'Docker Swarm', 60, 5);

-- CKA
INSERT INTO certification_themes (id, certification_id, code, label, question_count, display_order)
VALUES (uuid_generate_v4(), 'cka', 'cluster_arch', 'Cluster Architecture', 40, 0),
       (uuid_generate_v4(), 'cka', 'workloads', 'Workloads & Scheduling', 50, 1),
       (uuid_generate_v4(), 'cka', 'services_net', 'Services & Networking', 50, 2),
       (uuid_generate_v4(), 'cka', 'storage', 'Storage', 40, 3),
       (uuid_generate_v4(), 'cka', 'troubleshooting', 'Troubleshooting', 50, 4),
       (uuid_generate_v4(), 'cka', 'security', 'Security', 40, 5),
       (uuid_generate_v4(), 'cka', 'helm_operators', 'Helm & Operators', 30, 6);

-- CKAD
INSERT INTO certification_themes (id, certification_id, code, label, question_count, display_order)
VALUES (uuid_generate_v4(), 'ckad', 'app_design', 'Application Design', 40, 0),
       (uuid_generate_v4(), 'ckad', 'deployment', 'Deployment Configuration', 60, 1),
       (uuid_generate_v4(), 'ckad', 'observability', 'Observability', 40, 2),
       (uuid_generate_v4(), 'ckad', 'services_net', 'Services & Networking', 60, 3),
       (uuid_generate_v4(), 'ckad', 'state', 'State Persistence', 50, 4);

-- CKS
INSERT INTO certification_themes (id, certification_id, code, label, question_count, display_order)
VALUES (uuid_generate_v4(), 'cks', 'cluster_hardening', 'Cluster Hardening', 30, 0),
       (uuid_generate_v4(), 'cks', 'system_hardening', 'System Hardening', 30, 1),
       (uuid_generate_v4(), 'cks', 'supply_chain', 'Supply Chain Security', 30, 2),
       (uuid_generate_v4(), 'cks', 'monitoring', 'Monitoring & Logging', 30, 3),
       (uuid_generate_v4(), 'cks', 'runtime_security', 'Runtime Security', 30, 4),
       (uuid_generate_v4(), 'cks', 'compliance', 'Compliance', 50, 5);

-- Android Kotlin
INSERT INTO certification_themes (id, certification_id, code, label, question_count, display_order)
VALUES (uuid_generate_v4(), 'android', 'compose', 'Jetpack Compose', 70, 0),
       (uuid_generate_v4(), 'android', 'architecture', 'Architecture (MVVM, ViewModel)', 60, 1),
       (uuid_generate_v4(), 'android', 'data_storage', 'Data Storage (Room, DataStore)', 60, 2),
       (uuid_generate_v4(), 'android', 'coroutines', 'Kotlin Coroutines & Flow', 60, 3),
       (uuid_generate_v4(), 'android', 'hilt', 'Dependency Injection (Hilt)', 50, 4);

-- Terraform
INSERT INTO certification_themes (id, certification_id, code, label, question_count, display_order)
VALUES (uuid_generate_v4(), 'terraform', 'basics', 'Terraform Basics', 50, 0),
       (uuid_generate_v4(), 'terraform', 'hcl', 'Configuration Language', 70, 1),
       (uuid_generate_v4(), 'terraform', 'state', 'State Management', 50, 2),
       (uuid_generate_v4(), 'terraform', 'providers', 'Providers & Modules', 50, 3),
       (uuid_generate_v4(), 'terraform', 'cli', 'CLI Commands', 40, 4),
       (uuid_generate_v4(), 'terraform', 'best_practices', 'Best Practices', 40, 5);

-- GCP Digital Leader
INSERT INTO certification_themes (id, certification_id, code, label, question_count, display_order)
VALUES (uuid_generate_v4(), 'gcp_dl', 'digital_transform', 'Digital Transformation', 50, 0),
       (uuid_generate_v4(), 'gcp_dl', 'core_services', 'GCP Core Services', 80, 1),
       (uuid_generate_v4(), 'gcp_dl', 'data_analytics', 'Data & Analytics', 60, 2),
       (uuid_generate_v4(), 'gcp_dl', 'security', 'Security & Compliance', 60, 3);

-- Java 21 Général
INSERT INTO certification_themes (id, certification_id, code, label, question_count, display_order)
VALUES (uuid_generate_v4(), 'java21', 'fondamentaux', 'Fondamentaux du Langage', 50, 0),
       (uuid_generate_v4(), 'java21', 'types_donnees', 'Types de données et Wrappers', 50, 1),
       (uuid_generate_v4(), 'java21', 'poo', 'POO - Classes, Héritage, Polymorphisme', 60, 2),
       (uuid_generate_v4(), 'java21', 'collections', 'Collections et Génériques', 60, 3),
       (uuid_generate_v4(), 'java21', 'exceptions', 'Exceptions et Gestion d erreurs', 50, 4),
       (uuid_generate_v4(), 'java21', 'io_nio', 'Flux I/O et NIO', 40, 5),
       (uuid_generate_v4(), 'java21', 'multithreading', 'Multithreading et Concurrence', 50, 6),
       (uuid_generate_v4(), 'java21', 'lambda_streams', 'Lambda, Streams et API fonctionnelle', 60, 7),
       (uuid_generate_v4(), 'java21', 'modules', 'Modules JPMS', 30, 8),
       (uuid_generate_v4(), 'java21', 'nouveautes', 'Nouveautés Java 17-21', 50, 9);
