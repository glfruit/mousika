grails.servlet.version = "2.5" // Change depending on target container compliance (2.5 or 3.0)
grails.project.class.dir = "target/classes"
grails.project.test.class.dir = "target/test-classes"
grails.project.test.reports.dir = "target/test-reports"
grails.project.target.level = 1.6
grails.project.source.level = 1.6
//grails.project.war.file = "target/${appName}-${appVersion}.war"

// uncomment (and adjust settings) to fork the JVM to isolate classpaths
//grails.project.fork = [
//   run: [maxMemory:1024, minMemory:64, debug:false, maxPerm:256]
//]

grails.project.dependency.resolution = {
    // inherit Grails' default dependencies
    inherits("global") {
        // specify dependency exclusions here; for example, uncomment this to disable ehcache:
        // excludes 'ehcache'
    }
    log "error" // log level of Ivy resolver, either 'error', 'warn', 'info', 'debug' or 'verbose'
    checksums true // Whether to verify checksums on resolve
    legacyResolve false // whether to do a secondary resolve on plugin installation, not advised and here for backwards compatibility

    repositories {
        inherits true // Whether to inherit repository definitions from plugins

        grailsPlugins()
        grailsHome()
        grailsCentral()

        mavenLocal()
        mavenCentral()

        // uncomment these (or add new ones) to enable remote dependency resolution from public Maven repositories
        //mavenRepo "http://snapshots.repository.codehaus.org"
        //mavenRepo "http://repository.codehaus.org"
        //mavenRepo "http://download.java.net/maven/2/"
        //mavenRepo "http://repository.jboss.com/maven2/"
    }

    def gebVersion = "0.9.0"
    def seleniumVersion = "2.31.0"

    dependencies {
        // specify dependencies here under either 'build', 'compile', 'runtime', 'test' or 'provided' scopes e.g.

        // runtime 'mysql:mysql-connector-java:5.1.20'
        test("org.gebish:geb-junit4:$gebVersion")
        test("org.seleniumhq.selenium:selenium-chrome-driver:$seleniumVersion")
        test("org.seleniumhq.selenium:selenium-support:$seleniumVersion")
        runtime 'postgresql:postgresql:9.1-901-1.jdbc4'

        test("org.spockframework:spock-grails-support:0.7-groovy-2.0")
        compile "net.sourceforge.jexcelapi:jxl:2.6.10"
    }

    plugins {
        runtime ":hibernate:$grailsVersion"
        runtime ":jquery:1.9.1"
        runtime ":resources:1.2.RC2"

        // Uncomment these (or add new ones) to enable additional resources capabilities
        //runtime ":zipped-resources:1.0"
        //runtime ":cached-resources:1.0"
        //runtime ":yui-minify-resources:0.1.4"
//        compile ":dojo:1.7.2.0"
        compile ':gson:1.1.4'
        compile ":twitter-bootstrap:2.3.2"
        compile ":searchable:0.6.4"
        compile ":taggable:1.0.1"
//        compile ":platform-core:1.0.RC5"
        compile ":fields:1.3"
        compile ":ckeditor:3.6.3.0"

        compile ':heroku:1.0.1'
        compile ':cloud-support:1.0.8'

        build ':jetty:2.0.3'
//        build ":tomcat:$grailsVersion"

        runtime ":database-migration:1.3.3"
        compile ':cache:1.0.1'
        compile ":shiro:1.2.0-SNAPSHOT"
        compile ":codenarc:0.18.1"

        test(":spock:0.7") {
            exclude "spock-grails-support"
        }
        test ":geb:$gebVersion"
        test ":cucumber:0.8.0"
        test ":code-coverage:1.2.6"
        test ":build-test-data:2.0.5"
        compile ":fixtures:1.2"
    }
}
