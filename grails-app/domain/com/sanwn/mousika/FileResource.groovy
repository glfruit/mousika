package com.sanwn.mousika

class FileResource extends Content {

    String filePath

    String fileType

    public static FILE_TYPES = ['doc': 'application/msword', 'docx': 'application/msword',
            'xls': 'application/vnd.ms-excel', 'xlsx': 'application/vnd.ms-excel',
            'ppt': 'application/vnd.ms-powerpoint', 'pptx': 'application/vnd.ms-powerpoint',
            'exe': 'application/x-msdownload', 'pdf': 'application/pdf',
            'swf': 'application/x-shockwave-flash', 'jpg': 'image/jpeg', 'png': 'image/png', 'gif': 'image/gif',
            'mp3': 'audio/mp3',
            'avi': 'video/avi']

    static constraints = {
    }
}
