package com.sanwn.mousika.hibernate;

import org.springframework.util.StringUtils;

import java.util.HashMap;
import java.util.Map;

/**
 * @author glix
 * @version 1.0
 */
public class HstoreHelper {

    private static final String K_V_SEPARATOR = "=>";

    public static String toString(Map<String, String> m) {
        if (m.isEmpty()) {
            return "";
        }
        StringBuilder sb = new StringBuilder();
        int n = m.size();
        for (String key : m.keySet()) {
            sb.append(key).append(K_V_SEPARATOR).append(m.get(key));
            sb.append(",");
        }
        return sb.substring(0, sb.length() - 1);
    }

    public static Map<String, String> toMap(String value) {
        Map<String, String> m = new HashMap<String, String>();
        if (!StringUtils.hasText(value)) {
            return m;
        }
        String[] pairs = value.split(",");
        for (String pair : pairs) {
            String[] kv = pair.split(K_V_SEPARATOR);
            String key = kv[0];
            key = key.trim().substring(1, key.length() - 2);
            String v = kv[1];
            v = v.trim().substring(1, v.length() - 2);
            m.put(key, v);
        }
        return m;
    }
}
