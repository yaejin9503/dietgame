package global.sesoc.test303.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import global.sesoc.test303.vo.Diary1;
import global.sesoc.test303.vo.Diary2;
import global.sesoc.test303.vo.Diet_user;
import global.sesoc.test303.vo.Exercise;
import global.sesoc.test303.vo.Food;
import global.sesoc.test303.vo.Minigame;
import global.sesoc.test303.vo.Weight;

@Repository
public class DietRepository {

	@Autowired
	SqlSession session;
	
	public Diet_user loginUser(Diet_user user) {
		DietMapper mapper = session.getMapper(DietMapper.class);
		Diet_user result = mapper.loginUser(user); 
		return result; 
	}
	
	public Diet_user homeinfo(String userid){
		DietMapper mapper = session.getMapper(DietMapper.class); 
		Diet_user result = mapper.homeinfo(userid); 
		return result; 
	}
	
	public List<Food> showfood(){
		DietMapper mapper = session.getMapper(DietMapper.class);
		List<Food>result = mapper.showfood(); 
		return result; 
	}
	
	public List<Food> searchfood(String food_name){
		DietMapper mapper = session.getMapper(DietMapper.class);
		List<Food> result = mapper.searchfood(food_name); 
		return result; 
	}
	
	public int insertdiary1(Diary1 diary){
		DietMapper mapper = session.getMapper(DietMapper.class);
		int result = mapper.insertdiary(diary); 
		return result; 
	}
	
	public List<Food> showmydiary(Diary1 diary){
		DietMapper mapper = session.getMapper(DietMapper.class);
		List<Food> result = mapper.showmydiary(diary); 
		return result; 
	}
	
	public int deletefood(Diary1 diary){
		DietMapper mapper = session.getMapper(DietMapper.class);
		int result = mapper.deletemyfood(diary);
		return result; 
	}
	
	public List<Food> todayfoodreport(String userid){
		DietMapper mapper = session.getMapper(DietMapper.class);
		List<Food> result = mapper.todayfoodreport(userid); 
		return result; 
	}

	public List<Exercise> showexercise() {
		DietMapper mapper = session.getMapper(DietMapper.class);
		List<Exercise>result = mapper.showexercise(); 
		return result;
	}

	public List<Exercise> searchexer(String exername) {
		DietMapper mapper = session.getMapper(DietMapper.class);
		List<Exercise> result = mapper.searchexer(exername); 
		return result; 
		
	}
	
	public int insertdiary2(Diary2 diary){
		DietMapper mapper = session.getMapper(DietMapper.class);
		int result = mapper.insertdiary2(diary); 
		return result; 
	}

	public List<Exercise> showmydiary2(String userid) {
		DietMapper mapper = session.getMapper(DietMapper.class);
		List<Exercise> result = mapper.showmydiary2(userid); 
		return result; 
	}

	public int updatetime(Diary2 diary) {
		DietMapper mapper = session.getMapper(DietMapper.class);
		int result = mapper.updatetime(diary); 
		return result;
	}
	
	public List<Exercise> showmydiary3(String userid) {
		DietMapper mapper = session.getMapper(DietMapper.class);
		List<Exercise> result = mapper.showmydiary3(userid); 
		return result; 
	}
	public List<Diary2> totalburnkcal(String userid) {
		DietMapper mapper = session.getMapper(DietMapper.class);
		List<Diary2> result = mapper.totalburnkcal(userid); 
		return result; 
	}

	public int deleteexercise(Diary2 diary) {
		DietMapper mapper = session.getMapper(DietMapper.class);
		int result = mapper.deleteexercise(diary);
		return result;
	}
	//signup
	public int insertuser(Diet_user user) {
		DietMapper mapper = session.getMapper(DietMapper.class);
		int result = mapper.insertuser(user);
		return result;
	}

	public String checkid(String userid) {
		DietMapper mapper = session.getMapper(DietMapper.class);
		String result = mapper.checkid(userid);
		return result;
	}
	
	public int insertweight(Weight weight) {
		DietMapper mapper = session.getMapper(DietMapper.class);
		int result = mapper.insertweight(weight);
		return result;
	}
	
	public List<Weight> todayweightreport(String userid) {
		DietMapper mapper = session.getMapper(DietMapper.class);
		List<Weight> result = mapper.todayweightreport(userid); 
		return result;
	}
	
	public List<Diary1> foodcheck(String userid) {
		DietMapper mapper = session.getMapper(DietMapper.class);
		List<Diary1> foodcheck = mapper.foodcheck(userid);
		return foodcheck;
	}

	public List<Food> oneday(Diary1 diary1) {
		DietMapper mapper = session.getMapper(DietMapper.class);
		List<Food> result = mapper.oneday(diary1);
		return result;
	}

	public List<Exercise> exerciseday(Diary2 diary2) {
		DietMapper mapper = session.getMapper(DietMapper.class);
		List<Exercise> result = mapper.exerciseday(diary2);
		return result;
	}
	public int updateweight(Diet_user user){
		DietMapper mapper = session.getMapper(DietMapper.class);
		int result = mapper.updateweight(user);
		return result;
	} 
	public Weight confirmweight(String userid) {
		DietMapper mapper = session.getMapper(DietMapper.class);
		Weight result = mapper.confirmweight(userid); 
		return result;
	}
	public String getsaltId(String userid){
		DietMapper mapper = session.getMapper(DietMapper.class);
		String result = mapper.getSaltById(userid); 
		return result; 
	}
	
	public int getBestScore(String userid){
		DietMapper mapper = session.getMapper(DietMapper.class);
		int result = mapper.getBestScore(userid); 
		return result; 
	}
	
	public int updateBestScore(Minigame minigame){
		DietMapper mapper = session.getMapper(DietMapper.class);
		int result = mapper.updateBestScore(minigame);  
		return result; 
	}

	public int insertscore(Minigame minigame){
		DietMapper mapper = session.getMapper(DietMapper.class);
		int result = mapper.insertscore(minigame);  
		return result; 
	}
}
