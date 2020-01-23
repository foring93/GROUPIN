package co.pr.fi.serviceImpl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import co.pr.fi.dao.GroupDAO;
import co.pr.fi.domain.GGroupBoard;
import co.pr.fi.domain.GGroup;
import co.pr.fi.domain.GLocation;
import co.pr.fi.domain.Post;
import co.pr.fi.service.GroupService;
import co.pr.fi.domain.MemberList;

@Service
public class GroupServiceImpl implements GroupService {
	
	@Autowired
	GroupDAO dao;
	
	@Override
	public GGroup groupInfo(int groupkey) {
		return dao.groupinfo(groupkey);
	}

	
	@Override
	public int groupMainImgUpdate(GGroup group) {
		return dao.groupMainImgUpdate(group);
	}

	@Override
	public int groupImgUpdate(GGroup group) {
		return dao.groupImgUpdate(group);
		
	}

	@Override
	public GLocation groupwhere(int wherekey) {
		return dao.groupwhere(wherekey);
	}

	@Override
	public int groupage(int agekey) {
		return dao.groupage(agekey);
	}

	@Override
	public String groupdcategory(int categorykey) {
		return dao.groupdcategory(categorykey);
	}

	@Override
	public String groupscategory(int categorykey) {
		return dao.groupscategory(categorykey);
	}

	@Override
	public int groupmembers(int groupkey) {
		return dao.groupmembers(groupkey);
	}

	@Override
	public String groupmaster(int groupkey) {
		return dao.groupmaster(groupkey);
	}

	@Override
	public List<GGroupBoard> groupboardlist(int groupkey) {
		return dao.groupboardlist(groupkey);
	}

	@Override
	public List<MemberList> groupmemberlist(int groupkey) {
		
		return dao.groupmemberlist(groupkey);
	}

	@Override
	public List<Post> groupmeetinglist(int groupkey) {
		List<Post> MeetingList = dao.groupmeetinglist(groupkey);
		for(int i = 0;i<MeetingList.size();i++) {
			String date = MeetingList.get(i).getCstartdate();

			String year = date.substring(0,4)+"년 ";  

			String month = date.substring(5,7)+"월 ";

			String day = date.substring(8,10)+"일 ";

			String time = date.substring(11,13)+"시 ";

			String minute = date.substring(14,16)+"분";
			if(minute.equals("00분"))
				minute="";
			MeetingList.get(i).setCstartdate(year+month+day+time+minute);
		}
		return MeetingList;
	}

	@Override
	public List<MemberList> calendarmemberlist(int postkey, int groupkey) {
		Map<String, Integer> map = new HashMap<String, Integer>();
		map.put("postkey", postkey);
		map.put("groupkey", groupkey);
		return dao.groupcalendarmemberlist(map);
	}


	
}