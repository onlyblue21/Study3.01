package Controller;

import java.util.ArrayList;
import java.util.Locale;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import vo.TestVo;


/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public String home(TestVo vo, Locale locale, Model model) {
		if( vo != null &&  !"".equals(vo.getClassName())) {
			if(vo.getClassName().endsWith("組")) {
				System.out.println(vo.getClassName().substring(0,  (vo.getClassName().length() -1) ));
			}else {
				System.out.println(vo.getClassName());
			}
		}
		int count = 10;
		ArrayList<String> voList = new ArrayList<String>();
		for(int i=1; count > i; i++) {
			String str ="組";
			voList.add(i+str);
		}
		voList.add("total");
	    model.addAttribute("voList", voList);
	    model.addAttribute("voflg", true);
		return "home";
	}
}
