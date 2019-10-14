package global.sesoc.test303;

import java.text.ParseException;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import global.sesoc.test303.dao.DietRepository;
import global.sesoc.test303.vo.Diary1;
import global.sesoc.test303.vo.Diary2;
import global.sesoc.test303.vo.Diet_user;
import global.sesoc.test303.vo.Exercise;
import global.sesoc.test303.vo.Food;
import global.sesoc.test303.vo.Foodinfo;
import global.sesoc.test303.vo.Minigame;
import global.sesoc.test303.vo.Weight;
import global.sesoc.test303.util.SHA256Security;

@Controller
public class DietUserController {

	@Autowired
	DietRepository repo; 
	
	//로그인 함수 
	@RequestMapping("/userlogin")
	@ResponseBody
	public String login(Diet_user user,HttpSession session) {
		
		String salt = repo.getsaltId(user.getUserid());
		String password = user.getPassword(); 
	
		if(salt!=null){
			password = SHA256Security.getEncrypt(password, salt); 
			user.setPassword(password);
			Diet_user result = repo.loginUser(user);	
			
			if(result!=null){
				session.setAttribute("loginId", result.getUserid());
				return "success";
			}	
			else {
				return "fail";
			}
		}
		else{
			return "fail";
		}
		
	}
	
	//signup
	@RequestMapping("/sign")
	@ResponseBody
	public int sign(Diet_user user ,Minigame minigame ,HttpSession session){ 
		//비밀번호 SHA-256을 이용해서 암호화 
		String salt = SHA256Security.generateSalt();
		user.setSalt(salt);
		
		String password = user.getPassword(); 
		password = SHA256Security.getEncrypt(password, salt); 
		user.setPassword(password);
		//회원가입 부분에서 암호화 끝 
		int result = repo.insertuser(user);
		minigame.setUserid(user.getUserid());
		minigame.setScore(0);
		repo.insertscore(minigame); 
		
		return result;
	}

	//idcheck
	@RequestMapping("/idcheck")
	@ResponseBody
	public String idcheck(String userid ){
		String result = repo.checkid(userid);
		return result;
	}
	
	@RequestMapping("/homeinfo")
	@ResponseBody
	public Diet_user homeinfomation(String userid,HttpSession session, Model model) {
		userid = (String)session.getAttribute("loginId"); 
		Diet_user result = repo.homeinfo(userid); 
		double weight = result.getWeight(); 
		double height = result.getHeight(); 
		String gender = result.getGender(); 
		int age = result.getAge(); 
		
		double userresult = 0.0; 
		
		if(gender.equals("women")){
			userresult =  655 + (9.6*weight) + (1.8*height) - (4.7*age);
			int b = (int)userresult;
			result.setKcalresult(b);
		
		}
		else{
			userresult =  66 + (13.8*weight) + (5*height) - (6.8 *age);
			int a = (int)userresult;
			result.setKcalresult(a);
		}
		return result;
	}
		
	@RequestMapping("/showfood")
	@ResponseBody
	public List<Food> showfoodList(){
		List<Food> result = repo.showfood();
		return result;
	}
	
	@RequestMapping("/searchfood")
	@ResponseBody
	public List<Food> searchfood(String food_name){
		//System.out.println(food_name);
		List<Food> result = repo.searchfood(food_name); 
		return result;
	}
	
	@RequestMapping("/foodinsert")
	@ResponseBody
	public int foodinsert(Foodinfo foodinfo, Diary1 diary,HttpSession session){
		String userid = (String)session.getAttribute("loginId"); 
		diary.setUserid(userid);
		diary.setDay(null); //sysdate로 넣을 것임으로 null로 설정해줌
		diary.setFood_num(foodinfo.getFoodnum());
		
		if(foodinfo.getMorning()!=""){
			diary.setTodaytime(foodinfo.getMorning());
		}
		else if(foodinfo.getLunch()!=""){
			diary.setTodaytime(foodinfo.getLunch());
		}
		else if(foodinfo.getDinner()!=""){
			diary.setTodaytime(foodinfo.getDinner());
		}
		else{
			diary.setTodaytime(foodinfo.getSnack());
		}
		
		int result = repo.insertdiary1(diary);
		
		return result;
	}
	
	@RequestMapping("/myfooddiary")
	@ResponseBody
	public List<Food> myfooddiary(Foodinfo foodinfo, Diary1 diary,HttpSession session){
		String userid = (String)session.getAttribute("loginId"); 
		diary.setUserid(userid);
		
		if(foodinfo.getMorning()!=""){
			diary.setTodaytime(foodinfo.getMorning());
		}
		else if(foodinfo.getLunch()!=""){
			diary.setTodaytime(foodinfo.getLunch());
		}
		else if(foodinfo.getDinner()!=""){
			diary.setTodaytime(foodinfo.getDinner());
		}
		else{
			diary.setTodaytime(foodinfo.getSnack());
		}
		List<Food> result = repo.showmydiary(diary);
	
		return result;
	}
	
	@RequestMapping("/fooddelete")
	@ResponseBody
	public int fooddelete(Foodinfo foodinfo, Diary1 diary,HttpSession session){
		String userid = (String)session.getAttribute("loginId"); 
		diary.setUserid(userid);
		diary.setFood_num(foodinfo.getFoodnum());
		
		if(foodinfo.getMorning()!=""){
			diary.setTodaytime(foodinfo.getMorning());
		}
		else if(foodinfo.getLunch()!=""){
			diary.setTodaytime(foodinfo.getLunch());
		}
		else if(foodinfo.getDinner()!=""){
			diary.setTodaytime(foodinfo.getDinner());
		}
		else{
			diary.setTodaytime(foodinfo.getSnack());
		}
	
		int result = repo.deletefood(diary);
		
		return result;
	}
	
	@RequestMapping("/todayfoodreport")
	@ResponseBody
	public Food foodreport(HttpSession session){
		String userid = (String)session.getAttribute("loginId");
		int kcal = 0;
		double protein = 0.0;
		double fat = 0.0; 
		double carb = 0.0; 
		
		List<Food> report = repo.todayfoodreport(userid);
		for(int i =0; i< report.size(); i++){
			kcal += report.get(i).getCal();
			protein += report.get(i).getPortein(); 
			fat += report.get(i).getFat(); 
			carb += report.get(i).getCarb(); 
		}
		
		kcal = Math.round(kcal*100)/100;
		protein = Math.round(protein*100)/100;
		fat = Math.round(fat*100)/100;
		carb = Math.round(carb*100)/100;
		
		Food result = new Food(0,"","",kcal,0,"","",protein,fat,carb,0.0,0.0,""); 	
		
		return result;
	}
	
	@RequestMapping("/todayreport")
	@ResponseBody
	public int todayreport(HttpSession session){
		String userid = (String)session.getAttribute("loginId");
		int kcal = 0;
		int kcal2= 0;
		int kcal3= 0; 
		
		List<Food> report = repo.todayfoodreport(userid); //오늘 먹은 칼로리 
		List<Diary2> mykcal = repo.totalburnkcal(userid); //오늘 운동으로 소모시킨 칼로리 
		if(report.size()!=0){
			for(int i =0; i< report.size(); i++){
				kcal += report.get(i).getCal();	
			}
			if(mykcal.size()!=0){ //운동을 했을 때 
				for(int i=0; i < mykcal.size();i++){ 
					kcal2 += ((mykcal.get(i).getWeight()*mykcal.get(i).getCalburn())/60)*mykcal.get(i).getTotaltime();
				}
				kcal3 = Math.round(kcal*100)/100 -kcal2; 	 
				return kcal3;
			}
			return kcal;
		}
		return 0; 
	}
	@RequestMapping("/showexercise")
	@ResponseBody
	public List<Exercise> showexerciseList(){
		List<Exercise> result = repo.showexercise();
		return result;
	}
	//searchexer
	@RequestMapping("/searchexer")
	@ResponseBody
	public List<Exercise> searchexer(String exername){
		System.out.println(exername);
		List<Exercise> result = repo.searchexer(exername); 
		return result;
	}
	//exerinsert
	@RequestMapping("/exerinsert")
	@ResponseBody
	public int exerinsert(int exernum, Diary2 diary,HttpSession session){
		String userid = (String)session.getAttribute("loginId"); 
		diary.setUserid(userid);
		diary.setExernum(exernum);
		diary.setExerdate(null);
		int result = repo.insertdiary2(diary);
		return result;
	}
	//myexercisediary
	@RequestMapping("/myexercisediary")
	@ResponseBody
	public List<Exercise> myexercisediary(HttpSession session){
		String userid = (String)session.getAttribute("loginId"); 
		List<Exercise> result = repo.showmydiary2(userid);
	
		return result;
	}
	//exertime
	@RequestMapping("/exertime")
	@ResponseBody
	public int exersujung(Diary2 diary,HttpSession session){
		String userid = (String)session.getAttribute("loginId"); 
		diary.setUserid(userid);
		int result = repo.updatetime(diary);
		return result;
	}
	
	//exertime
	@RequestMapping("/exertime1")
	@ResponseBody
	public int exertime1(Diary2 diary,HttpSession session){
		String userid = (String)session.getAttribute("loginId"); 
		List<Diary2> mykcal = repo.totalburnkcal(userid);
		int kcal =0; 
		//(4.84*60)/60
		if(mykcal.size()!=0){
			for(int i=0; i < mykcal.size();i++){
				kcal += ((mykcal.get(i).getWeight()*mykcal.get(i).getCalburn())/60)*mykcal.get(i).getTotaltime();
			}	
		}
		return kcal;
	}
	
	@RequestMapping("/exertime2")
	@ResponseBody
	public List<Exercise> exertime2(Diary2 diary,HttpSession session){
		String userid = (String)session.getAttribute("loginId"); 
		List<Exercise> result = repo.showmydiary3(userid);
		return result;
	}
	
	@RequestMapping("/exerdelete")
	@ResponseBody
	public int exerdelete(Diary2 diary,HttpSession session){
		String userid = (String)session.getAttribute("loginId"); 
		diary.setUserid(userid);	
		int result = repo.deleteexercise(diary);
		
		return result;
	}
	
	
	
	@RequestMapping("/insertweight")
	@ResponseBody
	public int insertweight(double weight,Diet_user user, HttpSession session){
		String userid = (String)session.getAttribute("loginId"); 
		Weight Wei = new Weight(userid,weight,null); 
		user.setUserid(userid);
		user.setWeight(weight);
		repo.updateweight(user); 
		int result = repo.insertweight(Wei);
		return result;
	}
	
	@RequestMapping("/todayweightreport")
	@ResponseBody
	public List<Weight> weightreport(HttpSession session){
		String userid = (String)session.getAttribute("loginId");
		List<Weight> report = repo.todayweightreport(userid); 
		return report;
	}
	
	// foodcheck
	@RequestMapping("/foodcheck")
	@ResponseBody
	public List<Diary1> foodcheck(HttpSession session) {
		String userid = (String)session.getAttribute("loginId"); 
		List<Diary1> foodcheck = repo.foodcheck(userid);
		return foodcheck;   
	}

	// daybyday   
	@RequestMapping("/daybyday")
	@ResponseBody
	public List<Food> oneday(HttpSession session, Diary1 diary1) {
		String userid = (String)session.getAttribute("loginId"); 
		diary1.setUserid(userid);
		List<Food> oneday = repo.oneday(diary1);    
		return oneday;
	}
	//
	@RequestMapping("/exerciseday")
	@ResponseBody
	public List<Exercise> exerciseday(HttpSession session, Diary2 diary2,String day) {
		String userid = (String)session.getAttribute("loginId"); 
		diary2.setUserid(userid);
		diary2.setExerdate(day);
		List<Exercise> oneday = repo.exerciseday(diary2);    
		return oneday;
	}
	
	//
	@RequestMapping("/confirmdata")
	@ResponseBody
	public String confirmdata(HttpSession session) {
		String userid = (String)session.getAttribute("loginId"); 
		Weight result = repo.confirmweight(userid);
		if(result !=null){
			return "false"; //오늘 등록한 몸무게가 있음 
		}
		else{ //오늘 등록한 몸무게가 없음
			return "success"; 
		}  			
	}
	
	@RequestMapping("/bestscore")
	@ResponseBody
	public String bestscore(HttpSession session, Minigame minigame) {
		String userid = (String)session.getAttribute("loginId");
		int originalScore = repo.getBestScore(userid); 
		
		System.out.println(minigame.getScore());
		//minigame.getScore()가 현재 받은 점수, 
		if(minigame.getScore()>originalScore){
			minigame.setUserid(userid);
			repo.updateBestScore(minigame); 
			return "success";
		}else{
			return "false";
		}
	}
	
	@RequestMapping("/getBestScore")
	@ResponseBody
	public int getBestScore(HttpSession session, Minigame minigame) {
		String userid = (String)session.getAttribute("loginId");
		int BestScore = repo.getBestScore(userid);
		return BestScore;
	}
}
