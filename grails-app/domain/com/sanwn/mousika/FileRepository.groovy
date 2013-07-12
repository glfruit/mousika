package com.sanwn.mousika

class FileRepository {

    User owner

    String location

    static constraints = {
        items nullable: true
    }

    static hasMany = [items: FileRepositoryItem]
}
