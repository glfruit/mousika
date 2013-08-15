package com.sanwn.mousika

import org.apache.commons.io.FileUtils

/**
 * 代表一个课程单元里的一项内容
 */
class UnitItem {

    String title

    int sequence

    Content content

    boolean visible = true

    static searchable = true

    static belongsTo = [unit: CourseUnit]

    static mapping = {
        sort sequence: 'asc'
    }

    def copy() {
        def c = content
        if (c instanceof Assignment) {
            c = (c as Assignment).copy()
        }
        if (c instanceof FileResource) {
            def course = unit.course
            File destDir = new File("courseFiles/${course.courseToken}")
            if (!destDir.exists()) {
                FileUtils.forceMkdir(destDir)
            }
            try {
                def srcFile = new File(c.filePath)
                FileUtils.copyFileToDirectory(srcFile, destDir)
                def filePath = new File(destDir, srcFile.getName()).getCanonicalPath()
                c = new FileResource(filePath: filePath, fileType: c.fileType, title: c.title, description: c.description)
            } catch (IOException e) {
                log.warn("复制文件${c.filePath}到目录${destDir}失败：${e}")
            }
        }
        new UnitItem(title: title, sequence: sequence, content: c)
    }
}
