package co.pr.fi.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import co.pr.fi.domain.GGroupBoard;
import co.pr.fi.domain.GGroupMember;
import co.pr.fi.domain.CalendarList;
import co.pr.fi.domain.CalendarMember;
import co.pr.fi.domain.GGroup;
import co.pr.fi.domain.GLocation;
import co.pr.fi.domain.GUsers;
import co.pr.fi.domain.Post;
import co.pr.fi.domain.Shortschedule;
import co.pr.fi.domain.UserRegGroup;
import co.pr.fi.domain.MemberList;

@Repository
public class GroupDAO {
	@Autowired
	private SqlSessionTemplate sqlSession;

	public GGroup groupinfo(int groupkey) {
		return sqlSession.selectOne("group.groupinfo", groupkey);
	}

	public int groupMainImgUpdate(GGroup group) {
		return sqlSession.update("group.groupMainImgUpdate", group);
	}

	public int groupImgUpdate(GGroup group) {
		return sqlSession.update("group.groupImgUpdate", group);
	}

	public GLocation groupwhere(int wherekey) {
		return sqlSession.selectOne("group.groupwhere", wherekey);
	}

	public int groupage(int agekey) {
		return sqlSession.selectOne("group.groupage", agekey);
	}

	public String groupdcategory(int categorykey) {
		return sqlSession.selectOne("group.groupdcategory", categorykey);
	}

	public String groupscategory(int categorykey) {
		return sqlSession.selectOne("group.groupscategory", categorykey);
	}

	public int groupmembers(int groupkey) {
		return sqlSession.selectOne("group.groupmembers", groupkey);
	}

	public String groupmaster(int groupkey) {
		return sqlSession.selectOne("group.groupmaster", groupkey);
	}

	public List<GGroupBoard> groupboardlist(int groupkey) {
		return sqlSession.selectList("group.groupboardlist", groupkey);
	}

	
	public List<MemberList> groupmemberlist(int groupkey) {
		return sqlSession.selectList("group.groupmemberlist", groupkey);
	}

	public List<Post> groupmeetinglist(int groupkey) {
		return sqlSession.selectList("group.groupmeetinglist", groupkey);
	}

	public List<MemberList> groupcalendarmemberlist(Map<String, Integer> map) {
		return sqlSession.selectList("group.groupcalendarmemberlist", map);
	}

	public void groupcalendarmemberinsert(Map<String, Integer> map) {
		sqlSession.insert("group.groupcalendarmemberinsert", map);

	}

	public List<CalendarMember> calendarmemberjoinbtn(Map<String, Integer> map) {
		return sqlSession.selectList("group.calendarmemberjoinbtn", map);
	}

	public void groupcalendarmemberdelete(Map<String, Integer> map) {
		sqlSession.delete("group.groupcalendarmemberdelete", map);

	}

	public List<CalendarList> groupcalendarlist(Map<String, Object> map) {
		return sqlSession.selectList("group.groupcalendarlist", map);
	}

	public List<Shortschedule> shortschedule(Map<String, Object> map) {
		return sqlSession.selectList("group.shortschedule", map);
	}

	public List<Shortschedule> shortscheduleselected(Map<String, Object> map) {
		return sqlSession.selectList("group.shortscheduleselected", map);
	}

	
	public void groupboardupdate(Map<String, Object> map) {
		sqlSession.update("group.groupboardupdate", map);
	}

	public void groupboardinsert(Map<String, Object> map) {
		sqlSession.insert("group.groupboardinsert", map);

	}

	public void groupboarddelete(int boardkey) {
		sqlSession.delete("group.groupboarddelete", boardkey);
	}

	public GUsers userkey(String id) {
		return sqlSession.selectOne("group.userkey", id);
	}

	public int groupmasterkey(int groupkey) {
		return sqlSession.selectOne("group.groupmasterkey", groupkey);
	}

	public GGroupMember groupmember(int userkey) {
		return sqlSession.selectOne("group.groupmember", userkey);
	}

	public List<UserRegGroup> userreggroup(int userkey) {
		return sqlSession.selectList("group.userreggroup", userkey);
	}
}
