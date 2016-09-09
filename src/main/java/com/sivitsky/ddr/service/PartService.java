package com.sivitsky.ddr.service;

import com.sivitsky.ddr.model.Part;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.List;

public interface PartService {

    Part savePart(Part part);

    List<Part> listPart();

    List<Object[]> listPartWithDetail(Integer firstResult, Integer maxResult);

    List<Part> listPartWithManufactursFilter(Long[] mas_id);

    List<Part> listPartByManufactIdAndPrice(Long[] mas_id, Float price_from, Float price_to);

    void removePart(Long id);

    Part getPartById(Long id);

    Part getPartByName(String name);

    Integer getCountOfPart();

    void validateImage(MultipartFile image);

    void saveImage(String filename, MultipartFile image) throws RuntimeException, IOException;

}
