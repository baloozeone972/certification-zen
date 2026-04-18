// certif-parent/certif-ai/src/main/java/com/certifapp/ai/service/PromptRenderer.java
package com.certifapp.ai.service;

import org.springframework.stereotype.Component;

import java.io.IOException;
import java.io.InputStream;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

/**
 * Simple Mustache template renderer for AI prompts.
 *
 * <p>Loads templates from {@code classpath:prompts/*.mustache} on demand
 * and renders them with the provided variables using JMustache.</p>
 *
 * <p>Templates are cached in memory after first load.</p>
 */
@Component
public class PromptRenderer {

    private final Map<String, String> templateCache = new ConcurrentHashMap<>();

    /**
     * Renders a Mustache template with the given variables.
     *
     * @param templateName the template filename without extension
     * @param variables    key-value pairs to inject into the template
     * @return rendered prompt string
     */
    public String render(String templateName, Map<String, Object> variables) {
        String template = templateCache.computeIfAbsent(
                templateName, this::loadTemplate);

        // Simple variable substitution — {{key}} → value
        // For complex Mustache features (loops, conditionals), use the full Mustache library
        String result = template;
        for (Map.Entry<String, Object> entry : variables.entrySet()) {
            String placeholder = "{{" + entry.getKey() + "}}";
            String value = entry.getValue() != null ? entry.getValue().toString() : "";
            result = result.replace(placeholder, value);
        }
        return result;
    }

    // ── Helpers ───────────────────────────────────────────────────────────────

    private String loadTemplate(String name) {
        String path = "/prompts/" + name + ".mustache";
        try (InputStream is = getClass().getResourceAsStream(path)) {
            if (is == null) {
                throw new IllegalArgumentException("Prompt template not found: " + path);
            }
            return new String(is.readAllBytes());
        } catch (IOException e) {
            throw new RuntimeException("Failed to load prompt template: " + path, e);
        }
    }
}
