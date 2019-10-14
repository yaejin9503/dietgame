package global.sesoc.test303.dao;

import java.util.List;

import global.sesoc.test303.vo.Diary1;
import global.sesoc.test303.vo.Diary2;
import global.sesoc.test303.vo.Diet_user;
import global.sesoc.test303.vo.Exercise;
import global.sesoc.test303.vo.Food;
import global.sesoc.test303.vo.Minigame;
import global.sesoc.test303.vo.Weight;

public interface DietMapper {
	public Diet_user loginUser(Diet_user user);
	public Diet_user homeinfo(String userid); 
	public List<Food> showfood();
	public List<Food> searchfood(String food_name); 
	public int insertdiary(Diary1 diary);
	public List<Food>showmydiary(Diary1 diary);
	public int deletemyfood(Diary1 diary);
	public List<Food> todayfoodreport(String userid);
	public List<Exercise> showexercise();
	public List<Exercise> searchexer(String exername); 
	public int insertdiary2(Diary2 diary);
	public List<Exercise> showmydiary2(String userid);
	public int updatetime(Diary2 diary);
	public List<Exercise> showmydiary3(String userid);
	public List<Diary2> totalburnkcal(String userid);
	public int deleteexercise(Diary2 diary);
	public int insertuser(Diet_user user);
	public String checkid(String userid);
	public int insertweight(Weight weight);
	public List<Weight> todayweightreport(String userid);
	public List<Diary1> foodcheck(String userid);
	public List<Food> oneday(Diary1 diary1);
	public List<Exercise> exerciseday(Diary2 diary2);
	public int updateweight(Diet_user user); 
	public Weight confirmweight(String userid);
	public String getSaltById (String userid); 
	public int getBestScore(String userid);
	public int updateBestScore(Minigame minigame);
	public int insertscore(Minigame minigame);
}