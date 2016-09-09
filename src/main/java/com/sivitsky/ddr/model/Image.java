package com.sivitsky.ddr.model;

import javax.persistence.*;

@Entity
@Table(name = "image")
public class Image {

    private long id;
    private String path;
    private long partid;

    @Id
    @Column(name = "id")
    @GeneratedValue(strategy = GenerationType.AUTO)
    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    @Column(name = "path")
    public String getPath() {
        return path;
    }

    public void setPath(String path) {
        this.path = path;
    }

    @Column(name = "partid")
    public long getPartid() {
        return partid;
    }

    public void setPartid(long partid) {
        this.partid = partid;
    }
}
