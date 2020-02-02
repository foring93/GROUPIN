package co.pr.fi.service;

import java.util.List;

import co.pr.fi.domain.GGroupBoard;
import co.pr.fi.domain.GGroupMember;
import co.pr.fi.domain.CalendarList;
import co.pr.fi.domain.GGroup;
import co.pr.fi.domain.GLocation;
import co.pr.fi.domain.GUsers;
import co.pr.fi.domain.Post;
import co.pr.fi.domain.Shortschedule;
import co.pr.fi.domain.UserRegGroup;
import co.pr.fi.domain.MemberList;

public interface GroupService {
	public GGroup groupInfo(int groupKey);

	public int groupMainImgUpdate(GGroup group);

	public int groupImgUpdate(GGroup group);

	public GLocation groupwhere(int wherekey);

	public int groupage(int agekey);

	public String groupdcategory(int categorykey, int groupkey);

	public String groupscategory(int categorykey, int groupkey);

	public int groupmembers(int groupkey);

	public String groupmaster(int groupkey);

	public List<GGroupBoard> groupboardlist(int groupkey);

	public List<MemberList> groupmemberlist(int groupkey);

	public List<Post> groupmeetinglist(int groupkey, int userkey);

	public List<MemberList> calendarmemberlist(int postkey, int groupkey);

	public void calendarmemberinsert(int postkey, int groupkey, int userkey);

	public void calendarmemberdelete(int postkey, int groupkey, int userkey);

	public List<CalendarList> groupcalendarlist(int userkey, int month, int year);

	public List<Shortschedule> shortschedule(int userkey, int d, int year, int month);

	public List<Shortschedule> shortscheduleSelected(int userkey, String fulldate);

	public void groupboardupdate(int groupkey, String boardname, int boardkey, int seq, String boardtype);

	public void groupboardinsert(int groupkey, String boardname, int seq);

	public void groupboarddelete(int boardkey);

	public GUsers userkey(String id);

	public int groupmasterkey(int groupkey);

	public GGroupMember groupmember(int userkey);

	public List<UserRegGroup> userreggroup(int userkey);
}
