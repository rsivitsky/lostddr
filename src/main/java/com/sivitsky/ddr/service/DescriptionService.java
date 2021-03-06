package com.sivitsky.ddr.service;

import com.sivitsky.ddr.model.Description;

import java.util.List;

public interface DescriptionService {

    Description saveDescription(Description description);

    List<Description> listDescription();

    List<Description> listDescriptionByPartId(Long id);

    void removeDescription(Long id);

    Description getDescriptionById(Long id);
}
