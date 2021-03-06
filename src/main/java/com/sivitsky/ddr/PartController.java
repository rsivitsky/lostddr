package com.sivitsky.ddr;

import com.sivitsky.ddr.model.Part;
import com.sivitsky.ddr.service.DescriptionService;
import com.sivitsky.ddr.service.ManufacturService;
import com.sivitsky.ddr.service.PartService;
import org.apache.commons.io.FileUtils;
import org.apache.commons.io.IOUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.PropertySource;
import org.springframework.core.env.Environment;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.context.ServletContextAware;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.Resource;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;

@Controller
@SessionAttributes({"part", "listPart"})
public class PartController {

    @Autowired
    private PartService partService;
    @Autowired
    private ManufacturService manufacturService;
    @Autowired
    private DescriptionService descriptionService;

    @RequestMapping(value = "/part/list", method = RequestMethod.GET)
    public String startPart(Model model) {
        model.addAttribute("part", new Part());
        model.addAttribute("listPart", partService.listPart());
        model.addAttribute("listManufactur", manufacturService.listManufactur());
        return "part";
    }

    @RequestMapping(value = "/part/add", method = RequestMethod.GET)
    public String addPartGet(Model model) {
        model.addAttribute("part", new Part());
        return "add_part";
    }

    @RequestMapping(value = "/part/add", method = RequestMethod.POST)
    public String addPartPost(@Valid Part part, BindingResult result, @RequestParam(value = "img_file", required = false) MultipartFile img_file) throws IOException {
        if (result.hasErrors()) {
            return "redirect:/part/list";
        } else {
            if (img_file.getSize() != 0) {
                try {
                    partService.validateImage(img_file);
                } catch (RuntimeException re) {
                    result.reject(re.getMessage());
                    return "redirect:/part/list";
                }
                String pathphoto = partService.saveImage(img_file.getOriginalFilename(), img_file);
                part.setPhotopath(pathphoto);
            }
            this.partService.savePart(part);
        }
        return "redirect:/part/list";
    }

    @RequestMapping("/part/remove/{part_id}")
    public String removePart(@PathVariable("part_id") Long part_id) {
        this.partService.removePart(part_id);
        return "redirect:/part/list";
    }

    @RequestMapping("/part/edit/{part_id}")
    public String editPart(@PathVariable("part_id") Long part_id, Model model) {
        model.addAttribute("part", this.partService.getPartById(part_id));
        model.addAttribute("listPart", partService.listPart());
        model.addAttribute("listManufactur", manufacturService.listManufactur());
        return "part";
    }

    @RequestMapping(value = "/part/description/{part_id}", method = RequestMethod.GET)
    public String partDescription(Model model, @PathVariable("part_id") Long part_id) {
        model.addAttribute("part", this.partService.getPartById(part_id));
        model.addAttribute("descriptions", this.descriptionService.listDescriptionByPartId(part_id));
        return "partDescription";
    }

    @RequestMapping(value = "/part/photo/{part_id}", method = RequestMethod.GET)
    @ResponseBody
    public byte[] downloadPhoto(@PathVariable("part_id") Long part_id, HttpServletResponse httpServletResponse) throws IOException {
        Part part = partService.getPartById(part_id);
        File serverFile = new File(part.getPhotopath());
        return Files.readAllBytes(serverFile.toPath());
    }
}
