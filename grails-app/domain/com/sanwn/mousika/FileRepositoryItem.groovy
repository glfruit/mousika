package com.sanwn.mousika

import javax.persistence.MappedSuperclass

@MappedSuperclass
class FileRepositoryItem {

    String title

    static constraints = {
        title blank: false
    }

    static belongsTo = [fileRepository: FileRepository]
}
