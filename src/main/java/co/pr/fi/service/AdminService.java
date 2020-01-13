package co.pr.fi.service;

import java.util.List;

import co.pr.fi.domain.GUserCategory;
import co.pr.fi.domain.GUsers;
import co.pr.fi.domain.StatisticsAge;
import co.pr.fi.domain.StatisticsCategory;
import co.pr.fi.domain.StatisticsJoinDate;
import co.pr.fi.domain.StatisticsLocation;

//관리자 처리 
public interface AdminService {

	List<StatisticsAge> statisticsAge();

	List<StatisticsLocation> statisticsLocation();

	List<StatisticsJoinDate> StatisticsJoinDate();

	List<StatisticsCategory> statisticsCategory();

	List<GUsers> getAllUserList(int type, int page, int limit);

	int getListCount(int type);

	List<String> getAdminusercategory(String id);

	int AdmindeleteUser(String id);

	List<GUsers> AdminSearchUser(String keyword);



}
