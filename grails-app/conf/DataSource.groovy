dataSource {
    pooled = true
    driverClassName = "org.postgresql.Driver"
    username = "mousika_dev"
    password = "mousika_dev"
}
hibernate {
    cache.use_second_level_cache = true
    cache.use_query_cache = false
    cache.region.factory_class = 'net.sf.ehcache.hibernate.EhCacheRegionFactory'
}
// environment specific settings
environments {
    development {
        dataSource {
            dbCreate = "update" // one of 'create', 'create-drop', 'update', 'validate', ''
            url = "jdbc:postgresql://localhost/mousika_dev"
            logSql = false
        }
    }
    test {
        dataSource {
            dbCreate = "create-drop"
            url = "jdbc:postgresql://localhost/mousika_test"
            username = "mousika_test"
            password = "mousika_test"
        }
    }
    production {
        dataSource {
            dbCreate = "update" // one of 'create', 'create-drop', 'update', 'validate', ''
            url = "jdbc:postgresql://localhost/mousika_dev"
            logSql = false
        }
    }
}
