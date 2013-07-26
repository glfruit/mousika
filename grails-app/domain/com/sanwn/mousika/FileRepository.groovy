package com.sanwn.mousika

class FileRepository {

    public static REPOSITORY_PATH = "repoPath"

    public static REPOSITORY_TYPE = "repoType"

    public static REPOSITORY_TYPE_FILE = "file"

    public static REPOSITORY_TYPE_COURSE = "course"

    User owner

    String location

    static constraints = {
        items nullable: true
    }

    static hasMany = [items: FileRepositoryItem]
}
