
package co.pr.fi.controller;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import co.pr.fi.domain.CalendarList;
import co.pr.fi.domain.GComment;
import co.pr.fi.domain.GGroup;
import co.pr.fi.domain.GGroupBoard;
import co.pr.fi.domain.GGroupBoardList;
import co.pr.fi.domain.GGroupMember;
import co.pr.fi.domain.GLocation;
import co.pr.fi.domain.GUsers;
import co.pr.fi.domain.JoinQuest;
import co.pr.fi.domain.MemberList;
import co.pr.fi.domain.Post;
import co.pr.fi.domain.Shortschedule;
import co.pr.fi.domain.UserRegGroup;
import co.pr.fi.service.GroupBoardService;
import co.pr.fi.service.GroupMemberService;
import co.pr.fi.service.GroupService;
@Controller
public class GroupController {
	@Autowired
	private GroupService groupservice;
	
	@Autowired
	private GroupBoardService groupBoardService;
	
	@Autowired
	private GroupMemberService groupMemberService;
	
	//헤더를 통한 모임 랭킹 접근
	@GetMapping("/groupRank")
	public ModelAndView groupRank(ModelAndView mv) {
		int limit = 10;
		int page = 1;
		
		List<GGroup> groups = groupservice.getGroupRank(0, limit, page);
		mv.addObject("groups", groups);
		mv.setViewName("group/groupRank");
		return mv;
	}

	//더보기 버튼을 누른 모임 랭킹 접근
	@ResponseBody
	@PostMapping("/groupRank")
	public List<GGroup> groupRank(int page) {
		int limit = 10;

		List<GGroup> groups = groupservice.getGroupRank(0, limit, page);
		return groups;
	}
	
	// 모임 메인 페이지 
	@GetMapping("/group_main.net")
	public ModelAndView group_main(@RequestParam(value = "groupkey") int groupkey, @RequestParam(value = "upage", defaultValue = "1", required = false) int upage, ModelAndView mv,
			HttpSession session) {
		String id = "";
		int userkey = -1;
		if (session.getAttribute("id") != null) {
			id = session.getAttribute("id").toString();
			GUsers guser = groupservice.userkey(id);
			userkey = guser.getUserKey();
			mv.addObject("userkey", userkey);
		} else {
			mv.addObject("userkey", userkey);
		}
		Calendar c = Calendar.getInstance();
		int month = c.get(Calendar.MONTH) + 1;
		int year = c.get(Calendar.YEAR);
		int date = c.get(Calendar.DATE);
		//페이지네이션
		List<UserRegGroup> userreggroup = groupservice.userreggroup(userkey);
		mv.addObject("userreggroupcount", userreggroup.size());
		int ulimit = 3;
		int ulistcount = userreggroup.size();
		int umaxpage = (ulistcount + ulimit - 1) / ulimit;
		int ustartpage = ((upage - 1) / 10) * 10 + 1;
		int uendpage = ustartpage + 10 - 1;
		if (uendpage > umaxpage)
			uendpage = umaxpage;
		List<UserRegGroup> uuserreggroup = groupservice.userreggroupl(upage, ulimit, userkey);
		mv.addObject("upage", upage);
		mv.addObject("umaxpage", umaxpage);
		mv.addObject("ustartpage", ustartpage);
		mv.addObject("uendpage", uendpage);
		mv.addObject("ulistcount", ulistcount);
		mv.addObject("userreggroup", uuserreggroup);
		mv.addObject("ulimit", ulimit);
		
		mv.addObject("groupkey", groupkey);
		mv.setViewName("group/groupin_group_main");
		GGroupMember groupmember = groupservice.groupmember(userkey, groupkey);
		mv.addObject("userinfo", groupmember);
		GGroup group = groupservice.groupInfo(groupkey);
		mv.addObject("group", group);
		String groupmaster = groupservice.groupmaster(groupkey);
		mv.addObject("groupmaster", groupmaster);
		int groupmasterkey = groupservice.groupmasterkey(groupkey);
		mv.addObject("groupmasterkey", groupmasterkey);
		GLocation location = groupservice.groupwhere(group.getWhereKey());
		mv.addObject("groupswhere", location.getSWhere());
		mv.addObject("groupdwhere", location.getDWhere());
		int age = groupservice.groupage(group.getAgeKey());
		mv.addObject("groupage", age);
		String dcategory = groupservice.groupdcategory(groupkey);
		mv.addObject("groupdcategory", dcategory);
		String scategory = groupservice.groupscategory(groupkey);
		mv.addObject("groupscategory", scategory);
		int groupmembers = groupservice.groupmembers(groupkey);
		mv.addObject("groupmembers", groupmembers);
		List<GGroupBoard> groupboardlist = groupservice.groupboardlist(groupkey);
		mv.addObject("groupboardlist", groupboardlist);
		List<MemberList> groupmemberlist = groupservice.groupmemberlist(groupkey);
		mv.addObject("groupmemberlist", groupmemberlist);
		Post groupafterlist = groupservice.groupafterlist(groupkey);
		mv.addObject("post", groupafterlist);
		List<Post> groupmeetinglist = groupservice.groupmeetinglist(groupkey, userkey);
		mv.addObject("groupmeetinglist", groupmeetinglist);
		List<CalendarList> groupcalendarlist = groupservice.groupcalendarlist(userkey, month, year);
		mv.addObject("groupcalendarlist", groupcalendarlist);
		mv.addObject("groupcalendarlistCount", groupcalendarlist.size());
		
		for (int i = 0; i < groupcalendarlist.size(); i++) {
			if (Integer.parseInt(groupcalendarlist.get(i).getStartdate()) == date) {
				int d = Integer.parseInt(groupcalendarlist.get(i).getStartdate());
				List<Shortschedule> shortschedule = groupservice.shortschedule(userkey, d, year, month);
				mv.addObject("shortschedule", shortschedule);
			}
		}
		
		/*Map<String, Object> keys = new HashMap<String, Object>();
		Post post = new Post();	// 게시글 관련
		List<GComment> commentList = new ArrayList<GComment>();	// 댓글 관련
		int listcount = 0;	// 댓글수 변수
		keys.put("postkey", postkey);
		keys.put("groupkey", groupkey);
		keys.put("userkey", loginuser);
		
		listcount = groupBoardService.getCommentCount(keys); 	// 현재 게시글에 해당하는 댓글수
		post = groupBoardService.detailBoard(keys);				// 현재 게시글에 대한 데이터
		
		keys.put("page", page);
		keys.put("limit", limit);
		commentList = groupBoardService.getBoardComment(keys);	// 현재 게시글에 해당하는 댓글리스트
		
		int isLiked = groupBoardService.isLiked(keys);
		GGroupMember mem = groupMemberService.getPic(keys);
		
		keys = pagination(page, limit, listcount);
		
		if (post != null) {
			mv.addObject("post", post);				// 글쓴이와 게시글 관련 
			mv.addObject("comment", commentList);	// 댓쓴이와 댓글들 관련
			mv.addObject("isLiked", isLiked);		// 좋아요 여부 (1: 좋아요, 0: 좋아요 x)
			mv.addObject("postkey", postkey);
			mv.addObject("groupkey", groupkey);
			mv.addObject("page", keys.get("page"));
			mv.addObject("limit", keys.get("limit"));
			mv.addObject("listcount", keys.get("listcount"));
			mv.addObject("mem", mem);
			mv.addObject("loginuser", loginuser);	// 현재 로그인한 유저 키값
		}*/
		
		int isMem = groupservice.isMem(groupkey, userkey);
		mv.addObject("isMem", isMem);
		return mv;
	}

	@ResponseBody
	@RequestMapping(value = "/group_main_ajax.net")
	public Object ajaxMemberList(@RequestParam(value = "postkey") int postkey,
			@RequestParam(value = "groupkey") int groupkey) throws Exception {
		List<MemberList> groupcalendarmemberlist = groupservice.calendarmemberlist(postkey, groupkey);
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("groupcalendarmemberlist", groupcalendarmemberlist);
		return map;
	}

	@ResponseBody
	@RequestMapping(value = "/group_main_ajaxJoin.net")
	public Object ajaxJoin(@RequestParam(value = "postkey") int postkey, @RequestParam(value = "groupkey") int groupkey,
			@RequestParam(value = "userkey") int userkey, @RequestParam(value = "cmoneytype") String cmoneytype) throws Exception {
		groupservice.calendarmemberinsert(postkey, groupkey, userkey, cmoneytype);
		List<MemberList> groupcalendarmemberlist = groupservice.calendarmemberlist(postkey, groupkey);
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("groupcalendarmemberlist", groupcalendarmemberlist);
		map.put("currentperson", groupcalendarmemberlist.size());
		return map;
	}

	@ResponseBody
	@RequestMapping(value = "/group_main_ajaxJoinCancel.net")
	public Object ajaxJoinCancel(@RequestParam(value = "postkey") int postkey,
			@RequestParam(value = "groupkey") int groupkey, @RequestParam(value = "userkey") int userkey)
			throws Exception {
		groupservice.calendarmemberdelete(postkey, groupkey, userkey);
		List<MemberList> groupcalendarmemberlist = groupservice.calendarmemberlist(postkey, groupkey);
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("groupcalendarmemberlist", groupcalendarmemberlist);
		map.put("currentperson", groupcalendarmemberlist.size());
		return map;
	}

	@ResponseBody
	@RequestMapping(value = "/group_main_ajaxCalList.net")
	public Object ajaxCalList(@RequestParam(value = "userkey") int userkey, @RequestParam(value = "date") String date)
			throws Exception {
		String ym = date.replace("년", "");
		String ym1 = ym.replace("월", "");
		String ym2 = ym1.replace(" ", "");
		int year = Integer.parseInt(ym2.substring(0, 4));
		int month = 0;
		if (ym2.length() == 6) {
			month = Integer.parseInt(ym2.substring(ym2.length() - 2, ym2.length()));
		} else {
			month = Integer.parseInt(ym2.substring(ym2.length() - 1, ym2.length()));
		}
		System.out.println("!!!!!!!!!!!" + month);
		List<CalendarList> groupcalendarlist = groupservice.groupcalendarlist(userkey, month, year);
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("groupcalendarlist", groupcalendarlist);
		return map;
	}

	@ResponseBody
	@RequestMapping(value = "/group_main_shortschedule.net")
	public Object shortSchedule(@RequestParam(value = "userkey") int userkey, @RequestParam(value = "date") String date,
			@RequestParam(value = "day") String day) throws Exception {
		String ym = date.replace("년", "");
		String ym1 = ym.replace("월", "");
		String ym2 = ym1.replace(" ", "");
		String year = ym2.substring(0, 4) + "-";
		String month = "";
		if (ym2.length() == 6) {
			month = ym2.substring(ym2.length() - 2, ym2.length()) + "-";
		} else {
			month = "0" + ym2.substring(ym2.length() - 1, ym2.length()) + "-";
		}
		if (day.length() == 1) {
			day = "0" + day;
		}
		String fulldate = year + month + day + "%";
		List<Shortschedule> shortscheduleSelected = groupservice.shortscheduleSelected(userkey, fulldate);
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("shortscheduleSelected", shortscheduleSelected);
		return map;
	}

	@PostMapping("/group_mainImgUpdate.net")
	public String groupMainImg(@RequestParam(value = "groupkey") int groupKey, GGroup group, HttpServletRequest request)
			throws Exception {
		MultipartFile uploadfile = group.getGroupMainImgUpload();

		if (!uploadfile.isEmpty()) {
			String fileName = uploadfile.getOriginalFilename();// 占쏙옙占쏙옙 占쏙옙占싹몌옙
			group.setGroupIdOrigin(fileName);// 占쏙옙占쏙옙 占쏙옙占싹몌옙 占쏙옙占쏙옙
			group.setGroupKey(groupKey);
			// 占쏙옙占싸울옙 占쏙옙占쏙옙 占싱몌옙 : 占쏙옙占쏙옙 占쏙옙+占쏙옙+占쏙옙
			Calendar c = Calendar.getInstance();
			int year = c.get(Calendar.YEAR);// 占쏙옙占쏙옙 占썩도 占쏙옙占쌌니댐옙.
			int month = c.get(Calendar.MONTH) + 1;// 占쏙옙占쏙옙 占쏙옙 占쏙옙占쌌니댐옙.
			int date = c.get(Calendar.DATE);// 占쏙옙占쏙옙 占쏙옙 占쏙옙占쌌니댐옙.
			// String saveFolder =
			// request.getSession().getServletContext().getRealPath("resources") +
			// "/upload/";
			String saveFolder = "C:\\groupin/";
			String homedir = saveFolder + year + "-" + month + "-" + date;
			System.out.println("homedir = " + homedir);
			File path1 = new File(homedir);
			if (!(path1.exists())) {
				path1.mkdir();// 占쏙옙占싸울옙 占쏙옙占쏙옙 占쏙옙占쏙옙
			}
			// 占쏙옙占쏙옙占쏙옙 占쏙옙占쌌니댐옙.
			Random r = new Random();
			int random = r.nextInt(100000000);

			/*** 확占쏙옙占쏙옙 占쏙옙占싹깍옙 占쏙옙占쏙옙 ****/
			int index = fileName.lastIndexOf(".");
			// 占쏙옙占쌘울옙占쏙옙占쏙옙 특占쏙옙 占쏙옙占쌘울옙占쏙옙 占쏙옙치 占쏙옙(index)占쏙옙 占쏙옙환占싼댐옙.
			// indexOf占쏙옙 처占쏙옙 占쌩견되댐옙 占쏙옙占쌘울옙占쏙옙 占쏙옙占쏙옙 index占쏙옙 占쏙옙환占싹댐옙 占쌥몌옙,
			// lastIndexOf占쏙옙 占쏙옙占쏙옙占쏙옙占쏙옙占쏙옙 占쌩견되댐옙 占쏙옙占쌘울옙占쏙옙 index占쏙옙 占쏙옙환占쌌니댐옙.
			// (占쏙옙占싹몌옙 占쏙옙占쏙옙 占쏙옙占쏙옙占쏙옙 占쏙옙占쏙옙 占쏙옙占� 占쏙옙 占쏙옙占쏙옙占쏙옙占쏙옙 占쌩견되댐옙 占쏙옙占쌘울옙占쏙옙
			// 占쏙옙치占쏙옙 占쏙옙占쏙옙占쌌니댐옙.)
			System.out.println("index = " + index);
			String fileExtension = fileName.substring(index + 1);
			System.out.println("fileExtension = " + fileExtension);
			/*** 확占쏙옙占쏙옙 占쏙옙占싹깍옙 占쏙옙 ***/

			// 占쏙옙占싸울옙 占쏙옙占싹몌옙
			String refileName = "groupMainImg" + year + month + date + random + "." + fileExtension;
			System.out.println("refileName = " + refileName);

			// 占쏙옙占쏙옙클 占쏙옙占� 占쏙옙占쏙옙占� 占쏙옙占쏙옙 占쏙옙
			String fileDBName = "/" + year + "-" + month + "-" + date + "/" + refileName;
			System.out.println("fileDBName = " + fileDBName);

			// transferTo(File Path) : 占쏙옙占싸듸옙占쏙옙 占쏙옙占쏙옙占쏙옙 占신곤옙占쏙옙占쏙옙占쏙옙 占쏙옙恝占�
			// 占쏙옙占쏙옙占쌌니댐옙.
			uploadfile.transferTo(new File(saveFolder + fileDBName));

			// 占쌕뀐옙 占쏙옙占싹몌옙占쏙옙占쏙옙 占쏙옙占쏙옙
			group.setGroupCFile(fileDBName);
		}
		groupservice.groupMainImgUpdate(group);// 占쏙옙占쏙옙氷占쏙옙占� 호占쏙옙
		return "redirect:group_main.net?groupkey=" + groupKey;
	}

	@PostMapping("/group_ImgUpdate.net")
	public String groupImg(@RequestParam(value = "groupkey") int groupKey, GGroup group, HttpServletRequest request)
			throws Exception {
		MultipartFile uploadfile = group.getGroupImgUpload();

		if (!uploadfile.isEmpty()) {
			String fileName = uploadfile.getOriginalFilename();// 占쏙옙占쏙옙 占쏙옙占싹몌옙
			group.setGroupCOrigin(fileName);// 占쏙옙占쏙옙 占쏙옙占싹몌옙 占쏙옙占쏙옙
			group.setGroupKey(groupKey);
			// 占쏙옙占싸울옙 占쏙옙占쏙옙 占싱몌옙 : 占쏙옙占쏙옙 占쏙옙+占쏙옙+占쏙옙
			Calendar c = Calendar.getInstance();
			int year = c.get(Calendar.YEAR);// 占쏙옙占쏙옙 占썩도 占쏙옙占쌌니댐옙.
			int month = c.get(Calendar.MONTH) + 1;// 占쏙옙占쏙옙 占쏙옙 占쏙옙占쌌니댐옙.
			int date = c.get(Calendar.DATE);// 占쏙옙占쏙옙 占쏙옙 占쏙옙占쌌니댐옙.
			// String saveFolder =
			// request.getSession().getServletContext().getRealPath("resources") +
			// "/upload/";
			String saveFolder = "C:\\groupin/";
			String homedir = saveFolder + year + "-" + month + "-" + date;
			System.out.println("homedir = " + homedir);
			File path1 = new File(homedir);
			if (!(path1.exists())) {
				path1.mkdir();// 占쏙옙占싸울옙 占쏙옙占쏙옙 占쏙옙占쏙옙
			}
			// 占쏙옙占쏙옙占쏙옙 占쏙옙占쌌니댐옙.
			Random r = new Random();
			int random = r.nextInt(100000000);

			/*** 확占쏙옙占쏙옙 占쏙옙占싹깍옙 占쏙옙占쏙옙 ****/
			int index = fileName.lastIndexOf(".");
			// 占쏙옙占쌘울옙占쏙옙占쏙옙 특占쏙옙 占쏙옙占쌘울옙占쏙옙 占쏙옙치 占쏙옙(index)占쏙옙 占쏙옙환占싼댐옙.
			// indexOf占쏙옙 처占쏙옙 占쌩견되댐옙 占쏙옙占쌘울옙占쏙옙 占쏙옙占쏙옙 index占쏙옙 占쏙옙환占싹댐옙 占쌥몌옙,
			// lastIndexOf占쏙옙 占쏙옙占쏙옙占쏙옙占쏙옙占쏙옙 占쌩견되댐옙 占쏙옙占쌘울옙占쏙옙 index占쏙옙 占쏙옙환占쌌니댐옙.
			// (占쏙옙占싹몌옙 占쏙옙占쏙옙 占쏙옙占쏙옙占쏙옙 占쏙옙占쏙옙 占쏙옙占� 占쏙옙 占쏙옙占쏙옙占쏙옙占쏙옙 占쌩견되댐옙 占쏙옙占쌘울옙占쏙옙
			// 占쏙옙치占쏙옙 占쏙옙占쏙옙占쌌니댐옙.)
			System.out.println("index = " + index);
			String fileExtension = fileName.substring(index + 1);
			System.out.println("fileExtension = " + fileExtension);
			/*** 확占쏙옙占쏙옙 占쏙옙占싹깍옙 占쏙옙 ***/

			// 占쏙옙占싸울옙 占쏙옙占싹몌옙
			String refileName = "groupImg" + year + month + date + random + "." + fileExtension;
			System.out.println("refileName = " + refileName);

			// 占쏙옙占쏙옙클 占쏙옙占� 占쏙옙占쏙옙占� 占쏙옙占쏙옙 占쏙옙
			String fileDBName = "/" + year + "-" + month + "-" + date + "/" + refileName;
			System.out.println("fileDBName = " + fileDBName);

			// transferTo(File Path) : 占쏙옙占싸듸옙占쏙옙 占쏙옙占쏙옙占쏙옙 占신곤옙占쏙옙占쏙옙占쏙옙 占쏙옙恝占�
			// 占쏙옙占쏙옙占쌌니댐옙.
			uploadfile.transferTo(new File(saveFolder + fileDBName));

			// 占쌕뀐옙 占쏙옙占싹몌옙占쏙옙占쏙옙 占쏙옙占쏙옙

			group.setGroupDFile(fileDBName);
			System.out.println("!!!!!" + group.getGroupCFile());
		}
		groupservice.groupImgUpdate(group);// 占쏙옙占쏙옙氷占쏙옙占� 호占쏙옙
		return "redirect:group_main.net?groupkey=" + groupKey;
	}

	@GetMapping("groupin_group_admin_board.net")
	public ModelAndView group_admin_board(@RequestParam(value = "groupkey") int groupkey,@RequestParam(value = "upage", defaultValue = "1", required = false) int upage, ModelAndView mv,
			HttpSession session) {
		String id = "";
		int userkey = -1;
		if (session.getAttribute("id") != null) {
			id = session.getAttribute("id").toString();
			GUsers guser = groupservice.userkey(id);
			userkey = guser.getUserKey();
			mv.addObject("userkey", userkey);
		} else {
			mv.addObject("userkey", userkey);
		}
		Calendar c = Calendar.getInstance();
		int month = c.get(Calendar.MONTH) + 1;
		int year = c.get(Calendar.YEAR);
		int date = c.get(Calendar.DATE);
		mv.setViewName("group/groupin_group_admin_board");
		mv.addObject("groupkey", groupkey);
		GGroupMember groupmember = groupservice.groupmember(userkey, groupkey);
		mv.addObject("userinfo", groupmember);
		GGroup group = groupservice.groupInfo(groupkey);
		mv.addObject("group", group);
		String groupmaster = groupservice.groupmaster(groupkey);
		mv.addObject("groupmaster", groupmaster);
		int groupmasterkey = groupservice.groupmasterkey(groupkey);
		mv.addObject("groupmasterkey", groupmasterkey);
		GLocation location = groupservice.groupwhere(group.getWhereKey());
		mv.addObject("groupswhere", location.getSWhere());
		mv.addObject("groupdwhere", location.getDWhere());
		int age = groupservice.groupage(group.getAgeKey());
		mv.addObject("groupage", age);
		String dcategory = groupservice.groupdcategory(groupkey);
		mv.addObject("groupdcategory", dcategory);
		String scategory = groupservice.groupscategory(groupkey);
		mv.addObject("groupscategory", scategory);
		int groupmembers = groupservice.groupmembers(groupkey);
		mv.addObject("groupmembers", groupmembers);
		List<GGroupBoard> groupboardlist = groupservice.groupboardlist(groupkey);
		mv.addObject("groupboardlist", groupboardlist);
		mv.addObject("groupboardlistcount", groupboardlist.size());
		List<MemberList> groupmemberlist = groupservice.groupmemberlist(groupkey);
		mv.addObject("groupmemberlist", groupmemberlist);
		List<Post> groupmeetinglist = groupservice.groupmeetinglist(groupkey, userkey);
		mv.addObject("groupmeetinglist", groupmeetinglist);
		List<CalendarList> groupcalendarlist = groupservice.groupcalendarlist(userkey, month, year);
		mv.addObject("groupcalendarlist", groupcalendarlist);
		mv.addObject("groupcalendarlistCount", groupcalendarlist.size());
		List<UserRegGroup> userreggroup = groupservice.userreggroup(userkey);
		mv.addObject("userreggroupcount", userreggroup.size());
		int ulimit = 3;
		int ulistcount = userreggroup.size();
		int umaxpage = (ulistcount + ulimit - 1) / ulimit;
		int ustartpage = ((upage - 1) / 10) * 10 + 1;
		int uendpage = ustartpage + 10 - 1;
		if (uendpage > umaxpage)
			uendpage = umaxpage;
		List<UserRegGroup> uuserreggroup = groupservice.userreggroupl(upage, ulimit, userkey);
		mv.addObject("upage", upage);
		mv.addObject("umaxpage", umaxpage);
		mv.addObject("ustartpage", ustartpage);
		mv.addObject("uendpage", uendpage);
		mv.addObject("ulistcount", ulistcount);
		mv.addObject("userreggroup", uuserreggroup);
		mv.addObject("ulimit", ulimit);
		for (int i = 0; i < groupcalendarlist.size(); i++) {
			if (Integer.parseInt(groupcalendarlist.get(i).getStartdate()) == date) {
				int d = Integer.parseInt(groupcalendarlist.get(i).getStartdate());
				List<Shortschedule> shortschedule = groupservice.shortschedule(userkey, d, year, month);
				mv.addObject("shortschedule", shortschedule);
			}
		}
		return mv;
	}

	@PostMapping("/boardSetting.net")
	public String boardSetting(@RequestParam(value = "groupkey") int groupkey, GGroupBoardList list) {
		for (int i = 0; i < list.getGgroupboardlist().size(); i++) {
			if (list.getGgroupboardlist().get(i).getBoardKey() != -1) {
				String boardname = list.getGgroupboardlist().get(i).getBoardName();
				int boardkey = list.getGgroupboardlist().get(i).getBoardKey();
				int seq = list.getGgroupboardlist().get(i).getBoardSeq();
				String boardtype = list.getGgroupboardlist().get(i).getBoardType();
				groupservice.groupboardupdate(groupkey, boardname, boardkey, seq, boardtype);
			} else {
				String boardname = list.getGgroupboardlist().get(i).getBoardName();
				int seq = list.getGgroupboardlist().get(i).getBoardSeq();
				groupservice.groupboardinsert(groupkey, boardname, seq);
			}
		}
		return "redirect:groupin_group_admin_board.net?groupkey=" + groupkey;
	}

	@GetMapping("/boardDelete.net")
	public String boardDelete(@RequestParam(value = "boardkey") int boardkey,
			@RequestParam(value = "groupkey") int groupkey) {
		groupservice.groupboarddelete(boardkey);
		return "redirect:groupin_group_admin_board.net?groupkey=" + groupkey;
	}

	
	@GetMapping("/groupin_group_board_transfer.net")
	public ModelAndView group_board_transfer(@RequestParam(value = "groupkey") int groupkey,
			@RequestParam(value = "boardkey") int boardkey, @RequestParam(value = "boardtype") String boardtype,
			@RequestParam(value = "page", defaultValue = "1", required = false) int page, @RequestParam(value = "upage", defaultValue = "1", required = false) int upage, ModelAndView mv,
			HttpSession session) {
		int userkey = -1;
		String id = "";
		if (session.getAttribute("id") != null) {
			id = session.getAttribute("id").toString();
			GUsers guser = groupservice.userkey(id);
			userkey = guser.getUserKey();
			mv.addObject("userkey", userkey);
		} else {
			mv.addObject("userkey", userkey);
		}
		if (boardtype.equals("N")) {
			mv.setViewName("group/groupin_group_schedulelist");
			mv.addObject("boardtype", boardtype);
			int limit = 7;
			int listcount = groupservice.getScheduleListCount(groupkey);;
			int maxpage = (listcount + limit - 1) / limit;
			int startpage = ((page - 1) / 10) * 10 + 1;
			int endpage = startpage + 10 - 1;
			if (endpage > maxpage)
				endpage = maxpage;
			List<Post> postlist = groupservice.getBoardList(page, limit, groupkey, userkey);
			mv.addObject("groupkey", groupkey);
			mv.addObject("boardkey", boardkey);
			mv.addObject("page", page);
			mv.addObject("maxpage", maxpage);
			mv.addObject("startpage", startpage);
			mv.addObject("endpage", endpage);
			mv.addObject("listcount", listcount);
			mv.addObject("postlist", postlist);
			mv.addObject("limit", limit);
		} else if (boardtype.equals("Y")) {
			mv.setViewName("group/groupin_group_boardlist");
			mv.addObject("boardtype",boardtype);
			int limit = 10;
			int listcount = groupservice.boardListCount(boardkey);
			int maxpage = (listcount + limit - 1) / limit;
			int startpage = ((page - 1) / 10) * 10 + 1;
			int endpage = startpage + 10 - 1;
			if (endpage > maxpage)
				endpage = maxpage;
			List<Post> postlist = groupservice.getBoardListY(page, limit, boardkey, groupkey);
			mv.addObject("groupkey", groupkey);
			mv.addObject("boardkey", boardkey);
			mv.addObject("page", page);
			mv.addObject("maxpage", maxpage);
			mv.addObject("startpage", startpage);
			mv.addObject("endpage", endpage);
			mv.addObject("listcount", listcount);
			mv.addObject("postlist", postlist);
			mv.addObject("limit", limit);
		}else {
			mv.setViewName("group/groupin_group_boardlist");
			mv.addObject("boardtype",boardtype);
			int limit = 10;
			int listcount = groupservice.boardListCount(boardkey);
			int maxpage = (listcount + limit - 1) / limit;
			int startpage = ((page - 1) / 10) * 10 + 1;
			int endpage = startpage + 10 - 1;
			if (endpage > maxpage)
				endpage = maxpage;
			List<Post> postlist = groupservice.getBoardListY(page, limit, boardkey, groupkey);
			mv.addObject("groupkey", groupkey);
			mv.addObject("boardkey", boardkey);
			mv.addObject("page", page);
			mv.addObject("maxpage", maxpage);
			mv.addObject("startpage", startpage);
			mv.addObject("endpage", endpage);
			mv.addObject("listcount", listcount);
			mv.addObject("postlist", postlist);
			mv.addObject("limit", limit);
		}
		String boardname = groupservice.getboardname(boardkey);
		mv.addObject("boardname", boardname);
		Calendar c = Calendar.getInstance();
		int month = c.get(Calendar.MONTH) + 1;
		int year = c.get(Calendar.YEAR);
		int date = c.get(Calendar.DATE);
		GGroupMember groupmember = groupservice.groupmember(userkey, groupkey);
		mv.addObject("userinfo", groupmember);
		GGroup group = groupservice.groupInfo(groupkey);
		mv.addObject("group", group);
		String groupmaster = groupservice.groupmaster(groupkey);
		mv.addObject("groupmaster", groupmaster);
		int groupmasterkey = groupservice.groupmasterkey(groupkey);
		mv.addObject("groupmasterkey", groupmasterkey);
		GLocation location = groupservice.groupwhere(group.getWhereKey());
		mv.addObject("groupswhere", location.getSWhere());
		mv.addObject("groupdwhere", location.getDWhere());
		int age = groupservice.groupage(group.getAgeKey());
		mv.addObject("groupage", age);
		String dcategory = groupservice.groupdcategory( groupkey);
		mv.addObject("groupdcategory", dcategory);
		String scategory = groupservice.groupscategory( groupkey);
		mv.addObject("groupscategory", scategory);
		int groupmembers = groupservice.groupmembers(groupkey);
		mv.addObject("groupmembers", groupmembers);
		List<GGroupBoard> groupboardlist = groupservice.groupboardlist(groupkey);
		mv.addObject("groupboardlist", groupboardlist);
		List<MemberList> groupmemberlist = groupservice.groupmemberlist(groupkey);
		mv.addObject("groupmemberlist", groupmemberlist);
		List<Post> groupmeetinglist = groupservice.groupmeetinglist(groupkey, userkey);
		mv.addObject("groupmeetinglist", groupmeetinglist);
		List<CalendarList> groupcalendarlist = groupservice.groupcalendarlist(userkey, month, year);
		mv.addObject("groupcalendarlist", groupcalendarlist);
		mv.addObject("groupcalendarlistCount", groupcalendarlist.size());
		List<UserRegGroup> userreggroup = groupservice.userreggroup(userkey);
		
		mv.addObject("userreggroupcount", userreggroup.size());
		int ulimit = 3;
		int ulistcount = userreggroup.size();
		int umaxpage = (ulistcount + ulimit - 1) / ulimit;
		int ustartpage = ((upage - 1) / 10) * 10 + 1;
		int uendpage = ustartpage + 10 - 1;
		if (uendpage > umaxpage)
			uendpage = umaxpage;
		List<UserRegGroup> uuserreggroup = groupservice.userreggroupl(upage, ulimit, userkey);
		mv.addObject("upage", upage);
		mv.addObject("umaxpage", umaxpage);
		mv.addObject("ustartpage", ustartpage);
		mv.addObject("uendpage", uendpage);
		mv.addObject("ulistcount", ulistcount);
		mv.addObject("userreggroup", uuserreggroup);
		mv.addObject("ulimit", ulimit);
		for (int i = 0; i < groupcalendarlist.size(); i++) {
			if (Integer.parseInt(groupcalendarlist.get(i).getStartdate()) == date) {
				int d = Integer.parseInt(groupcalendarlist.get(i).getStartdate());
				List<Shortschedule> shortschedule = groupservice.shortschedule(userkey, d, year, month);
				mv.addObject("shortschedule", shortschedule);
			}
		}
		return mv;
	}

	@GetMapping("/groupin_group_admin_scheduleList.net")
	public ModelAndView group_admin_scheduleList(
			@RequestParam(value = "page", defaultValue = "1", required = false) int page, @RequestParam(value = "upage", defaultValue = "1", required = false) int upage,
			@RequestParam(value = "groupkey") int groupkey, ModelAndView mv, HttpSession session) {
		String id = "";
		int userkey = -1;
		if (session.getAttribute("id") != null) {
			id = session.getAttribute("id").toString();
			GUsers guser = groupservice.userkey(id);
			userkey = guser.getUserKey();
			mv.addObject("userkey", userkey);
		} else {
			mv.addObject("userkey", userkey);
		}
		Calendar c = Calendar.getInstance();
		int month = c.get(Calendar.MONTH) + 1;
		int year = c.get(Calendar.YEAR);
		int date = c.get(Calendar.DATE);
		mv.setViewName("group/groupin_group_admin_scheduleList");
		int limit = 7;
		int listcount = groupservice.getScheduleListCount(groupkey);
		int maxpage = (listcount + limit - 1) / limit;
		int startpage = ((page - 1) / 10) * 10 + 1;
		int endpage = startpage + 10 - 1;
		if (endpage > maxpage)
			endpage = maxpage;
		List<Post> postlist = groupservice.getBoardList(page, limit, groupkey, userkey);
		mv.addObject("groupkey",groupkey);
		mv.addObject("page", page);
		mv.addObject("maxpage", maxpage);
		mv.addObject("startpage", startpage);
		mv.addObject("endpage", endpage);
		mv.addObject("listcount", listcount);
		mv.addObject("postlist", postlist);
		mv.addObject("limit", limit);
		GGroupMember groupmember = groupservice.groupmember(userkey, groupkey);
		mv.addObject("userinfo", groupmember);
		GGroup group = groupservice.groupInfo(groupkey);
		mv.addObject("group", group);
		String groupmaster = groupservice.groupmaster(groupkey);
		mv.addObject("groupmaster", groupmaster);
		int groupmasterkey = groupservice.groupmasterkey(groupkey);
		mv.addObject("groupmasterkey", groupmasterkey);
		GLocation location = groupservice.groupwhere(group.getWhereKey());
		mv.addObject("groupswhere", location.getSWhere());
		mv.addObject("groupdwhere", location.getDWhere());
		int age = groupservice.groupage(group.getAgeKey());
		mv.addObject("groupage", age);
		String dcategory = groupservice.groupdcategory( groupkey);
		mv.addObject("groupdcategory", dcategory);
		String scategory = groupservice.groupscategory( groupkey);
		mv.addObject("groupscategory", scategory);
		int groupmembers = groupservice.groupmembers(groupkey);
		mv.addObject("groupmembers", groupmembers);
		List<GGroupBoard> groupboardlist = groupservice.groupboardlist(groupkey);
		mv.addObject("groupboardlist", groupboardlist);
		List<MemberList> groupmemberlist = groupservice.groupmemberlist(groupkey);
		mv.addObject("groupmemberlist", groupmemberlist);
		// List<Post> groupmeetinglist =
		// groupservice.groupmeetinglist(groupkey,userkey);
		// mv.addObject("groupmeetinglist", groupmeetinglist);
		List<Post> groupmeetinglist = groupservice.groupmeetinglist(groupkey, userkey);
		mv.addObject("groupmeetinglist", groupmeetinglist);
		List<CalendarList> groupcalendarlist = groupservice.groupcalendarlist(userkey, month, year);
		mv.addObject("groupcalendarlist", groupcalendarlist);
		mv.addObject("groupcalendarlistCount", groupcalendarlist.size());
		List<UserRegGroup> userreggroup = groupservice.userreggroup(userkey);
		mv.addObject("userreggroupcount", userreggroup.size());
		int ulimit = 3;
		int ulistcount = userreggroup.size();
		int umaxpage = (ulistcount + ulimit - 1) / ulimit;
		int ustartpage = ((upage - 1) / 10) * 10 + 1;
		int uendpage = ustartpage + 10 - 1;
		if (uendpage > umaxpage)
			uendpage = umaxpage;
		List<UserRegGroup> uuserreggroup = groupservice.userreggroupl(upage, ulimit, userkey);
		mv.addObject("upage", upage);
		mv.addObject("umaxpage", umaxpage);
		mv.addObject("ustartpage", ustartpage);
		mv.addObject("uendpage", uendpage);
		mv.addObject("ulistcount", ulistcount);
		mv.addObject("userreggroup", uuserreggroup);
		mv.addObject("ulimit", ulimit);
		for (int i = 0; i < groupcalendarlist.size(); i++) {
			if (Integer.parseInt(groupcalendarlist.get(i).getStartdate()) == date) {
				int d = Integer.parseInt(groupcalendarlist.get(i).getStartdate());
				List<Shortschedule> shortschedule = groupservice.shortschedule(userkey, d, year, month);
				mv.addObject("shortschedule", shortschedule);
			}
		}
		return mv;
	}

	@GetMapping("/groupin_group_admin_addSchedule.net")
	public ModelAndView group_admin_addSchedule(@RequestParam(value = "groupkey") int groupkey, ModelAndView mv,
			HttpSession session) {
		String id = "";
		int userkey = -1;
		if (session.getAttribute("id") != null) {
			id = session.getAttribute("id").toString();
			GUsers guser = groupservice.userkey(id);
			userkey = guser.getUserKey();
			mv.addObject("userkey", userkey);
		} else {
			mv.addObject("userkey", userkey);
		}
	
		Calendar c = Calendar.getInstance();
		int month = c.get(Calendar.MONTH) + 1;
		int year = c.get(Calendar.YEAR);
		int date = c.get(Calendar.DATE);
		mv.addObject("groupkey", groupkey);
		mv.setViewName("group/groupin_group_admin_addSchedule");
		GGroupMember groupmember = groupservice.groupmember(userkey, groupkey);
		mv.addObject("userinfo", groupmember);
		GGroup group = groupservice.groupInfo(groupkey);
		mv.addObject("group", group);
		String groupmaster = groupservice.groupmaster(groupkey);
		mv.addObject("groupmaster", groupmaster);
		int groupmasterkey = groupservice.groupmasterkey(groupkey);
		mv.addObject("groupmasterkey", groupmasterkey);
		GLocation location = groupservice.groupwhere(group.getWhereKey());
		mv.addObject("groupswhere", location.getSWhere());
		mv.addObject("groupdwhere", location.getDWhere());
		int age = groupservice.groupage(group.getAgeKey());
		mv.addObject("groupage", age);
		String dcategory = groupservice.groupdcategory( groupkey);
		mv.addObject("groupdcategory", dcategory);
		String scategory = groupservice.groupscategory( groupkey);
		mv.addObject("groupscategory", scategory);
		int groupmembers = groupservice.groupmembers(groupkey);
		mv.addObject("groupmembers", groupmembers);
		List<GGroupBoard> groupboardlist = groupservice.groupboardlist(groupkey);
		mv.addObject("groupboardlist", groupboardlist);
		List<MemberList> groupmemberlist = groupservice.groupmemberlist(groupkey);
		mv.addObject("groupmemberlist", groupmemberlist);
		List<Post> groupmeetinglist = groupservice.groupmeetinglist(groupkey, userkey);
		mv.addObject("groupmeetinglist", groupmeetinglist);
		List<CalendarList> groupcalendarlist = groupservice.groupcalendarlist(userkey, month, year);
		mv.addObject("groupcalendarlist", groupcalendarlist);
		mv.addObject("groupcalendarlistCount", groupcalendarlist.size());
		List<UserRegGroup> userreggroup = groupservice.userreggroup(userkey);
		mv.addObject("userreggroup", userreggroup);
		mv.addObject("userreggroupcount", userreggroup.size());
		for (int i = 0; i < groupcalendarlist.size(); i++) {
			if (Integer.parseInt(groupcalendarlist.get(i).getStartdate()) == date) {
				int d = Integer.parseInt(groupcalendarlist.get(i).getStartdate());
				List<Shortschedule> shortschedule = groupservice.shortschedule(userkey, d, year, month);
				mv.addObject("shortschedule", shortschedule);
			}
		}
		return mv;
	}

	@ResponseBody
	@RequestMapping(value = "/addSchedule.net")
	public Object addSchedule(Post post, HttpSession session)
			throws Exception {
		String id = session.getAttribute("id").toString();
		GUsers guser = groupservice.userkey(id);
		int userkey = guser.getUserKey();
		post.setUserKey(userkey);
		int gboardkey = groupservice.getgroupboardkey(post.getGroupKey());
		post.setBoardKey(gboardkey);
		groupservice.addschedule(post);
		int postkey = post.getPostKey();
		groupservice.addschedulecalendar(post);
		HashMap<String, Integer> map = new HashMap<String, Integer>();
	    map.put("postkey", postkey);
	    return map;
	}

	@PostMapping("/modifySchedule.net")
	public String modfiySchedule(Post post, HttpSession session)
			throws Exception {
		String id = session.getAttribute("id").toString();
		GUsers guser = groupservice.userkey(id);
		int groupkey = post.getGroupKey();
		int userkey = guser.getUserKey();
		post.setUserKey(userkey);
		int gboardkey = groupservice.getgroupboardkey(post.getGroupKey());
		post.setBoardKey(gboardkey);
		groupservice.updateschedule(post);
		groupservice.updateschedulecalendar(post);
		return "redirect:groupin_group_admin_scheduleList.net?groupkey=" + groupkey;
	}

	@GetMapping("/groupin_group_admin_modifySchedule.net")
	public ModelAndView group_admin_modifySchedule(@RequestParam(value = "groupkey") int groupkey,
			@RequestParam(value = "postkey") int postkey, ModelAndView mv, HttpSession session) {
		String id = "";
		int userkey = -1;
		if (session.getAttribute("id") != null) {
			id = session.getAttribute("id").toString();
			GUsers guser = groupservice.userkey(id);
			userkey = guser.getUserKey();
			mv.addObject("userkey", userkey);
		} else {
			mv.addObject("userkey", userkey);
		}
		Calendar c = Calendar.getInstance();
		int month = c.get(Calendar.MONTH) + 1;
		int year = c.get(Calendar.YEAR);
		int date = c.get(Calendar.DATE);
		mv.setViewName("group/groupin_group_admin_modifySchedule");
		GGroupMember groupmember = groupservice.groupmember(userkey, groupkey);
		mv.addObject("userinfo", groupmember);
		GGroup group = groupservice.groupInfo(groupkey);
		mv.addObject("group", group);
		String groupmaster = groupservice.groupmaster(groupkey);
		mv.addObject("groupmaster", groupmaster);
		int groupmasterkey = groupservice.groupmasterkey(groupkey);
		mv.addObject("groupmasterkey", groupmasterkey);
		GLocation location = groupservice.groupwhere(group.getWhereKey());
		mv.addObject("groupswhere", location.getSWhere());
		mv.addObject("groupdwhere", location.getDWhere());
		int age = groupservice.groupage(group.getAgeKey());
		mv.addObject("groupage", age);
		String dcategory = groupservice.groupdcategory( groupkey);
		mv.addObject("groupdcategory", dcategory);
		String scategory = groupservice.groupscategory( groupkey);
		mv.addObject("groupscategory", scategory);
		int groupmembers = groupservice.groupmembers(groupkey);
		mv.addObject("groupmembers", groupmembers);
		List<GGroupBoard> groupboardlist = groupservice.groupboardlist(groupkey);
		mv.addObject("groupboardlist", groupboardlist);
		List<MemberList> groupmemberlist = groupservice.groupmemberlist(groupkey);
		mv.addObject("groupmemberlist", groupmemberlist);
		List<Post> groupmeetinglist = groupservice.groupmeetinglist(groupkey, userkey);
		mv.addObject("groupmeetinglist", groupmeetinglist);
		List<CalendarList> groupcalendarlist = groupservice.groupcalendarlist(userkey, month, year);
		mv.addObject("groupcalendarlist", groupcalendarlist);
		mv.addObject("groupcalendarlistCount", groupcalendarlist.size());
		List<UserRegGroup> userreggroup = groupservice.userreggroup(userkey);
		mv.addObject("userreggroup", userreggroup);
		mv.addObject("userreggroupcount", userreggroup.size());
		for (int i = 0; i < groupcalendarlist.size(); i++) {
			if (Integer.parseInt(groupcalendarlist.get(i).getStartdate()) == date) {
				int d = Integer.parseInt(groupcalendarlist.get(i).getStartdate());
				List<Shortschedule> shortschedule = groupservice.shortschedule(userkey, d, year, month);
				mv.addObject("shortschedule", shortschedule);
			}
		}
		Post modifypost = groupservice.modifypost(postkey);
		mv.addObject("modifypost", modifypost);
		CalendarList modifycalendar = groupservice.modifycalendar(postkey);
		mv.addObject("modifycalendar", modifycalendar);
		List<MemberList> smodifymember = groupservice.smodifymember(postkey,groupkey);
		List<MemberList> smodifymemberm = groupservice.smodifymemberm(postkey,groupkey);
		mv.addObject("smodifymember", smodifymember);
		mv.addObject("smodifymembercount", smodifymember.size());
		mv.addObject("smodifymemberm", smodifymemberm);
		mv.addObject("smodifymembercountm", smodifymemberm.size());
		return mv;
	}

	@ResponseBody
	@RequestMapping(value = "/slistajax.net")
	public Object ajaxSlist(@RequestParam(value = "Array[]") List<Integer> list,
			@RequestParam(value = "postkey") int postkey) throws Exception {
		for (int i = 0; i < list.size(); i++) {
			groupservice.calendardeleteajax(list.get(i), postkey);
		}
		List<MemberList> modifymember = groupservice.modifymember(postkey);
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("modifymember", modifymember);
		map.put("modifymembercount", modifymember.size());
		return map;
	}

	@ResponseBody
	@RequestMapping(value = "/slistajaxlist.net")
	public Object ajaxSlistlist(@RequestParam(value = "postkey") int postkey) throws Exception {
		List<MemberList> modifymember = groupservice.modifymember(postkey);
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("modifymember", modifymember);
		map.put("modifymembercount", modifymember.size());
		return map;
	}

	@ResponseBody
	@RequestMapping(value = "/mlistajax.net")
	public Object ajaxMlist(@RequestParam(value = "Array[]") List<Integer> list,
			@RequestParam(value = "postkey") int postkey) throws Exception {
		for (int i = 0; i < list.size(); i++) {
			groupservice.calendardeleteajax(list.get(i), postkey);
		}
		List<MemberList> modifymemberm = groupservice.modifymemberm(postkey);
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("modifymemberm", modifymemberm);
		map.put("modifymembercountm", modifymemberm.size());
		return map;
	}

	@ResponseBody
	@RequestMapping(value = "/mlistajaxlist.net")
	public Object ajaxMlistlist(@RequestParam(value = "postkey") int postkey) throws Exception {
		List<MemberList> modifymemberm = groupservice.modifymemberm(postkey);
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("modifymemberm", modifymemberm);
		map.put("modifymembercountm", modifymemberm.size());
		return map;
	}

	@ResponseBody
	@RequestMapping(value = "/stomlistajax.net")
	public Object ajaxStomlist(@RequestParam(value = "Array[]") List<Integer> list,
			@RequestParam(value = "postkey") int postkey) throws Exception {
		for (int i = 0; i < list.size(); i++) {
			groupservice.calendarstomajax(list.get(i), postkey);
		}
		List<MemberList> modifymember = groupservice.modifymember(postkey);
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("modifymember", modifymember);
		map.put("modifymembercount", modifymember.size());
		return map;
	}

	@ResponseBody
	@RequestMapping(value = "/mtoslistajax.net")
	public Object ajaxMtoslist(@RequestParam(value = "Array[]") List<Integer> list,
			@RequestParam(value = "postkey") int postkey) throws Exception {
		for (int i = 0; i < list.size(); i++) {
			groupservice.calendarmtosajax(list.get(i), postkey);
			
		}
		List<MemberList> modifymemberm = groupservice.modifymemberm(postkey);
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("modifymemberm", modifymemberm);
		map.put("modifymembercountm", modifymemberm.size());
		return map;
	}

	@GetMapping("/map")
	public String group_freeBoard() {
		return "exampleMap";
	}

	@GetMapping("/upmap")
	public String group_freeBoarsd() {
		return "uploadMap";
	}
	@GetMapping("/groupin_group_admin.net")
	public ModelAndView group_admin(@RequestParam(value = "groupkey") int groupkey,@RequestParam(value = "upage", defaultValue = "1", required = false) int upage, ModelAndView mv,
			HttpSession session) {
		String id = "";
		int userkey = -1;
		if (session.getAttribute("id") != null) {
			id = session.getAttribute("id").toString();
			GUsers guser = groupservice.userkey(id);
			userkey = guser.getUserKey();
			mv.addObject("userkey", userkey);
		} else {
			mv.addObject("userkey", userkey);
		}
		Calendar c = Calendar.getInstance();
		int month = c.get(Calendar.MONTH) + 1;
		int year = c.get(Calendar.YEAR);
		int date = c.get(Calendar.DATE);
		mv.setViewName("group/groupin_group_admin");
		mv.addObject("groupkey", groupkey);
		GGroupMember groupmember = groupservice.groupmember(userkey, groupkey);
		mv.addObject("userinfo", groupmember);
		GGroup group = groupservice.groupInfo(groupkey);
		mv.addObject("group", group);
		String groupmaster = groupservice.groupmaster(groupkey);
		mv.addObject("groupmaster", groupmaster);
		int groupmasterkey = groupservice.groupmasterkey(groupkey);
		mv.addObject("groupmasterkey", groupmasterkey);
		GLocation location = groupservice.groupwhere(group.getWhereKey());
		mv.addObject("groupswhere", location.getSWhere());
		mv.addObject("groupdwhere", location.getDWhere());
		int age = groupservice.groupage(group.getAgeKey());
		mv.addObject("groupage", age);
		String dcategory = groupservice.groupdcategory( groupkey);
		mv.addObject("groupdcategory", dcategory);
		String scategory = groupservice.groupscategory( groupkey);
		mv.addObject("groupscategory", scategory);
		int groupmembers = groupservice.groupmembers(groupkey);
		mv.addObject("groupmembers", groupmembers);
		List<GGroupBoard> groupboardlist = groupservice.groupboardlist(groupkey);
		mv.addObject("groupboardlist", groupboardlist);
		List<MemberList> groupmemberlist = groupservice.groupmemberlist(groupkey);
		mv.addObject("groupmemberlist", groupmemberlist);
		List<Post> groupmeetinglist = groupservice.groupmeetinglist(groupkey, userkey);
		mv.addObject("groupmeetinglist", groupmeetinglist);
		List<CalendarList> groupcalendarlist = groupservice.groupcalendarlist(userkey, month, year);
		mv.addObject("groupcalendarlist", groupcalendarlist);
		mv.addObject("groupcalendarlistCount", groupcalendarlist.size());
		List<UserRegGroup> userreggroup = groupservice.userreggroup(userkey);
		mv.addObject("userreggroupcount", userreggroup.size());
		int ulimit = 3;
		int ulistcount = userreggroup.size();
		int umaxpage = (ulistcount + ulimit - 1) / ulimit;
		int ustartpage = ((upage - 1) / 10) * 10 + 1;
		int uendpage = ustartpage + 10 - 1;
		if (uendpage > umaxpage)
			uendpage = umaxpage;
		List<UserRegGroup> uuserreggroup = groupservice.userreggroupl(upage, ulimit, userkey);
		mv.addObject("upage", upage);
		mv.addObject("umaxpage", umaxpage);
		mv.addObject("ustartpage", ustartpage);
		mv.addObject("uendpage", uendpage);
		mv.addObject("ulistcount", ulistcount);
		mv.addObject("userreggroup", uuserreggroup);
		mv.addObject("ulimit", ulimit);
		for (int i = 0; i < groupcalendarlist.size(); i++) {
			if (Integer.parseInt(groupcalendarlist.get(i).getStartdate()) == date) {
				int d = Integer.parseInt(groupcalendarlist.get(i).getStartdate());
				List<Shortschedule> shortschedule = groupservice.shortschedule(userkey, d, year, month);
				mv.addObject("shortschedule", shortschedule);
			}
		}
		return mv;
	}

	@GetMapping("/groupin_group_admin_deleteSchedule.net")
	public String scheduleDelete(@RequestParam(value = "postkey") int postkey,
			@RequestParam(value = "groupkey") int groupkey) {
		groupservice.scheduledelete(postkey);
		return "redirect:groupin_group_admin_scheduleList.net?groupkey=" + groupkey;
	}

	@PostMapping("/basicsetting.net")
	public String basicsetting(@RequestParam(value = "groupkey") int groupkey, GGroup group, HttpServletRequest request)
			throws Exception {
		groupservice.groupbasicupdate(group, groupkey);
		return "redirect:groupin_group_admin.net?groupkey=" + groupkey;
	}
	
	
	@GetMapping("/groupin_group_writeBoard.net")
	public ModelAndView groupin_group_writeBoard(@RequestParam(value = "groupkey") int groupkey,@RequestParam(value = "boardname") String boardname,@RequestParam(value = "boardkey") int boardkey,@RequestParam(value = "boardtype") String boardtype, ModelAndView mv,
			HttpSession session) {
		String id = "";
		int userkey = -1;
		if (session.getAttribute("id") != null) {
			id = session.getAttribute("id").toString();
			GUsers guser = groupservice.userkey(id);
			userkey = guser.getUserKey();
			mv.addObject("userkey", userkey);
		} else {
			mv.addObject("userkey", userkey);
		}
		Calendar c = Calendar.getInstance();
		int month = c.get(Calendar.MONTH) + 1;
		int year = c.get(Calendar.YEAR);
		int date = c.get(Calendar.DATE);
		mv.addObject("groupkey", groupkey);
		mv.addObject("boardname", boardname);
		mv.addObject("boardkey", boardkey);
		mv.addObject("boardtype", boardtype);
		mv.setViewName("group/groupin_group_writeBoard");
		GGroupMember groupmember = groupservice.groupmember(userkey, groupkey);
		mv.addObject("userinfo", groupmember);
		GGroup group = groupservice.groupInfo(groupkey);
		mv.addObject("group", group);
		String groupmaster = groupservice.groupmaster(groupkey);
		mv.addObject("groupmaster", groupmaster);
		int groupmasterkey = groupservice.groupmasterkey(groupkey);
		mv.addObject("groupmasterkey", groupmasterkey);
		GLocation location = groupservice.groupwhere(group.getWhereKey());
		mv.addObject("groupswhere", location.getSWhere());
		mv.addObject("groupdwhere", location.getDWhere());
		int age = groupservice.groupage(group.getAgeKey());
		mv.addObject("groupage", age);
		String dcategory = groupservice.groupdcategory(groupkey);
		mv.addObject("groupdcategory", dcategory);
		String scategory = groupservice.groupscategory(groupkey);
		mv.addObject("groupscategory", scategory);
		int groupmembers = groupservice.groupmembers(groupkey);
		mv.addObject("groupmembers", groupmembers);
		List<GGroupBoard> groupboardlist = groupservice.groupboardlist(groupkey);
		mv.addObject("groupboardlist", groupboardlist);
		List<MemberList> groupmemberlist = groupservice.groupmemberlist(groupkey);
		mv.addObject("groupmemberlist", groupmemberlist);
		Post groupafterlist = groupservice.groupafterlist(groupkey);
		mv.addObject("groupafterlist", groupafterlist);
		List<Post> groupmeetinglist = groupservice.groupmeetinglist(groupkey, userkey);
		mv.addObject("groupmeetinglist", groupmeetinglist);
		List<CalendarList> groupcalendarlist = groupservice.groupcalendarlist(userkey, month, year);
		mv.addObject("groupcalendarlist", groupcalendarlist);
		mv.addObject("groupcalendarlistCount", groupcalendarlist.size());
		List<UserRegGroup> userreggroup = groupservice.userreggroup(userkey);
		mv.addObject("userreggroup", userreggroup);
		mv.addObject("userreggroupcount", userreggroup.size());
		for (int i = 0; i < groupcalendarlist.size(); i++) {
			if (Integer.parseInt(groupcalendarlist.get(i).getStartdate()) == date) {
				int d = Integer.parseInt(groupcalendarlist.get(i).getStartdate());
				List<Shortschedule> shortschedule = groupservice.shortschedule(userkey, d, year, month);
				mv.addObject("shortschedule", shortschedule);
			}
		}
		return mv;
	}
	
	@GetMapping("/groupin_group_updateBoard.net")
	public ModelAndView groupin_group_updateBoard(@RequestParam(value = "groupkey") int groupkey,@RequestParam(value = "postkey") int postkey,@RequestParam(value = "boardkey") int boardkey,@RequestParam(value = "boardtype") String boardtype, ModelAndView mv,
			HttpSession session) {
		String id = "";
		int userkey = -1;
		if (session.getAttribute("id") != null) {
			id = session.getAttribute("id").toString();
			GUsers guser = groupservice.userkey(id);
			userkey = guser.getUserKey();
			mv.addObject("userkey", userkey);
		} else {
			mv.addObject("userkey", userkey);
		}
		Calendar c = Calendar.getInstance();
		int month = c.get(Calendar.MONTH) + 1;
		int year = c.get(Calendar.YEAR);
		int date = c.get(Calendar.DATE);
		mv.addObject("groupkey", groupkey);
		mv.addObject("boardkey", boardkey);
		mv.addObject("boardtype", boardtype);
		mv.setViewName("group/groupin_group_updateBoard");
		GGroupMember groupmember = groupservice.groupmember(userkey, groupkey);
		mv.addObject("userinfo", groupmember);
		GGroup group = groupservice.groupInfo(groupkey);
		mv.addObject("group", group);
		String groupmaster = groupservice.groupmaster(groupkey);
		mv.addObject("groupmaster", groupmaster);
		int groupmasterkey = groupservice.groupmasterkey(groupkey);
		mv.addObject("groupmasterkey", groupmasterkey);
		GLocation location = groupservice.groupwhere(group.getWhereKey());
		mv.addObject("groupswhere", location.getSWhere());
		mv.addObject("groupdwhere", location.getDWhere());
		int age = groupservice.groupage(group.getAgeKey());
		mv.addObject("groupage", age);
		String dcategory = groupservice.groupdcategory(groupkey);
		mv.addObject("groupdcategory", dcategory);
		String scategory = groupservice.groupscategory(groupkey);
		mv.addObject("groupscategory", scategory);
		int groupmembers = groupservice.groupmembers(groupkey);
		mv.addObject("groupmembers", groupmembers);
		List<GGroupBoard> groupboardlist = groupservice.groupboardlist(groupkey);
		mv.addObject("groupboardlist", groupboardlist);
		List<MemberList> groupmemberlist = groupservice.groupmemberlist(groupkey);
		mv.addObject("groupmemberlist", groupmemberlist);
		Post post = groupservice.detailpost(postkey,groupkey);
		mv.addObject("post", post);
		List<Post> groupmeetinglist = groupservice.groupmeetinglist(groupkey, userkey);
		mv.addObject("groupmeetinglist", groupmeetinglist);
		List<CalendarList> groupcalendarlist = groupservice.groupcalendarlist(userkey, month, year);
		mv.addObject("groupcalendarlist", groupcalendarlist);
		mv.addObject("groupcalendarlistCount", groupcalendarlist.size());
		List<UserRegGroup> userreggroup = groupservice.userreggroup(userkey);
		mv.addObject("userreggroup", userreggroup);
		mv.addObject("userreggroupcount", userreggroup.size());
		for (int i = 0; i < groupcalendarlist.size(); i++) {
			if (Integer.parseInt(groupcalendarlist.get(i).getStartdate()) == date) {
				int d = Integer.parseInt(groupcalendarlist.get(i).getStartdate());
				List<Shortschedule> shortschedule = groupservice.shortschedule(userkey, d, year, month);
				mv.addObject("shortschedule", shortschedule);
			}
		}
		return mv;
	}
	
	@PostMapping("/boardwritesubmit.net")
	public String writesubmit(Post post, HttpServletRequest request)
			throws Exception {
		int groupkey = post.getGroupKey();
		int boardkey = post.getBoardKey();
		String boardtype = post.getBoardtype();
		groupservice.boardwriteinsert(post);
		return "redirect:groupin_group_board_transfer.net?groupkey=" + groupkey +"&boardkey="+ boardkey + "&boardtype="+boardtype;
	}
	
	@PostMapping("/boardupdatesubmit.net")
	public String updatesubmit(Post post, HttpServletRequest request)
			throws Exception {
		int groupkey = post.getGroupKey();
		int boardkey = post.getBoardKey();
		String boardtype = post.getBoardtype();
		groupservice.boardupdate(post);
		return "redirect:groupin_group_board_transfer.net?groupkey=" + groupkey +"&boardkey="+ boardkey + "&boardtype="+boardtype;
	}
	
	@GetMapping("/groupin_group_deleteBoard.net")
	public String deletesubmit(@RequestParam(value = "groupkey") int groupkey,
			@RequestParam(value = "boardkey") int boardkey, @RequestParam(value = "boardtype") String boardtype, @RequestParam(value = "postkey") int postkey, Post post, HttpServletRequest request)
			throws Exception {

		groupservice.boarddelete(postkey);
		return "redirect:groupin_group_board_transfer.net?groupkey=" + groupkey +"&boardkey="+ boardkey + "&boardtype="+boardtype;
	}
	
	/**** 게시글 상세보기 ****/
	@GetMapping("/group_boarddetail.net")
	public ModelAndView group_boarddetail(@RequestParam(value = "groupkey") int groupkey,
										  @RequestParam(value = "postkey") int postkey,
										  @RequestParam(value = "boardkey") int boardkey,
										  @RequestParam(value = "boardtype") String boardtype, 
										  @RequestParam(required = false, defaultValue = "1") int page,
										  @RequestParam(required = false, defaultValue = "10") int limit, 
										  ModelAndView mv, HttpServletResponse response, HttpSession session) throws IOException {
		String id = "";
		int userkey = -1;
		int loginuser = -1;
		
		if (session.getAttribute("id") != null) {
			id = session.getAttribute("id").toString();
			GUsers guser = groupservice.userkey(id);
			userkey = guser.getUserKey();
			mv.addObject("userkey", userkey);
			
			loginuser = groupMemberService.getUser((String)session.getAttribute("id"));
		} else {
			response.setContentType("text/html; charset=utf-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('로그인 후 이용해주세요.');");
			out.println("location.href = 'login'");
			out.println("</script>");
			out.close();
			return null;
		}
		
		mv.addObject("loginuser", loginuser);

		// 현재 모임에서 가입 승인된 일반 회원인지 판단 (-1만 아니면 됨)
		int ggroupmem = groupMemberService.isGroupMem(loginuser, groupkey);
		if (ggroupmem == 0) {
			response.setContentType("text/html; charset=utf-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('일반회원만 조회할 수 있습니다.');");
			out.println("history.back();");
			out.println("</script>");
			out.close();
		}
		
		Map<String, Object> keys = new HashMap<String, Object>();
		Post post = new Post();	// 게시글 관련
		List<GComment> commentList = new ArrayList<GComment>();	// 댓글 관련
		int listcount = 0;	// 댓글수 변수
		keys.put("postkey", postkey);
		keys.put("groupkey", groupkey);
		keys.put("userkey", loginuser);
		
		listcount = groupBoardService.getCommentCount(keys); 	// 현재 게시글에 해당하는 댓글수
		post = groupBoardService.detailBoard(keys);				// 현재 게시글에 대한 데이터
		
		keys.put("page", page);
		keys.put("limit", limit);
		commentList = groupBoardService.getBoardComment(keys);	// 현재 게시글에 해당하는 댓글리스트
		
		int isLiked = groupBoardService.isLiked(keys);
		GGroupMember mem = groupMemberService.getPic(keys);
		
		keys = pagination(page, limit, listcount);
		
		if (post != null) {
			mv.addObject("post", post);				// 글쓴이와 게시글 관련 
			mv.addObject("comment", commentList);	// 댓쓴이와 댓글들 관련
			mv.addObject("isLiked", isLiked);		// 좋아요 여부 (1: 좋아요, 0: 좋아요 x)
			mv.addObject("postkey", postkey);
			mv.addObject("groupkey", groupkey);
			mv.addObject("page", page);
			mv.addObject("limit", limit);
			mv.addObject("listcount", listcount);
			mv.addObject("mem", mem);
			mv.addObject("loginuser", loginuser);	// 현재 로그인한 유저 키값
		}
		
		Calendar c = Calendar.getInstance();
		int month = c.get(Calendar.MONTH) + 1;
		int year = c.get(Calendar.YEAR);
		int date = c.get(Calendar.DATE);
		
		mv.addObject("groupkey", groupkey);
		mv.addObject("boardkey", boardkey);
		mv.addObject("boardtype", boardtype);
		mv.setViewName("group/groupin_group_boarddetail");
		
		GGroupMember groupmember = groupservice.groupmember(userkey, groupkey);
		mv.addObject("userinfo", groupmember);
		
		GGroup group = groupservice.groupInfo(groupkey);
		mv.addObject("group", group);
		
		String groupmaster = groupservice.groupmaster(groupkey);
		mv.addObject("groupmaster", groupmaster);
		
		int groupmasterkey = groupservice.groupmasterkey(groupkey);
		mv.addObject("groupmasterkey", groupmasterkey);
		
		GLocation location = groupservice.groupwhere(group.getWhereKey());
		mv.addObject("groupswhere", location.getSWhere());
		mv.addObject("groupdwhere", location.getDWhere());
		
		int age = groupservice.groupage(group.getAgeKey());
		mv.addObject("groupage", age);
		
		String dcategory = groupservice.groupdcategory(groupkey);
		mv.addObject("groupdcategory", dcategory);
		
		String scategory = groupservice.groupscategory(groupkey);
		mv.addObject("groupscategory", scategory);
		
		int groupmembers = groupservice.groupmembers(groupkey);
		mv.addObject("groupmembers", groupmembers);
		
		List<GGroupBoard> groupboardlist = groupservice.groupboardlist(groupkey);
		mv.addObject("groupboardlist", groupboardlist);
		
		List<MemberList> groupmemberlist = groupservice.groupmemberlist(groupkey);
		mv.addObject("groupmemberlist", groupmemberlist);
		
		//Post post = groupservice.detailpost(postkey,groupkey);
		//mv.addObject("post", post);
		
		List<Post> groupmeetinglist = groupservice.groupmeetinglist(groupkey, userkey);
		mv.addObject("groupmeetinglist", groupmeetinglist);
		
		List<CalendarList> groupcalendarlist = groupservice.groupcalendarlist(userkey, month, year);
		mv.addObject("groupcalendarlist", groupcalendarlist);
		mv.addObject("groupcalendarlistCount", groupcalendarlist.size());
		
		List<UserRegGroup> userreggroup = groupservice.userreggroup(userkey);
		mv.addObject("userreggroup", userreggroup);
		mv.addObject("userreggroupcount", userreggroup.size());
		
		for (int i = 0; i < groupcalendarlist.size(); i++) {
			if (Integer.parseInt(groupcalendarlist.get(i).getStartdate()) == date) {
				int d = Integer.parseInt(groupcalendarlist.get(i).getStartdate());
				List<Shortschedule> shortschedule = groupservice.shortschedule(userkey, d, year, month);
				mv.addObject("shortschedule", shortschedule);
			}
		}
		return mv;
	}
	
	@GetMapping("/schedulemaps.net")
    public ModelAndView schedulemaps(@RequestParam(value="groupkey") int groupkey, @RequestParam(value="postkey") int postkey, ModelAndView mv, HttpSession session) {
		String id = "";
		int userkey = -1;
		if (session.getAttribute("id") != null) {
			id = session.getAttribute("id").toString();
			GUsers guser = groupservice.userkey(id);
			userkey = guser.getUserKey();
			mv.addObject("userkey", userkey);
		} else {
			mv.addObject("userkey", userkey);
		}
		Calendar c = Calendar.getInstance();
		int month = c.get(Calendar.MONTH) + 1;
		int year = c.get(Calendar.YEAR);
		int date = c.get(Calendar.DATE);
		mv.addObject("groupkey", groupkey);
		mv.addObject("postkey", postkey);
		mv.setViewName("group/groupin_group_scheduleMap");
		GGroupMember groupmember = groupservice.groupmember(userkey, groupkey);
		mv.addObject("userinfo", groupmember);
		GGroup group = groupservice.groupInfo(groupkey);
		mv.addObject("group", group);
		String groupmaster = groupservice.groupmaster(groupkey);
		mv.addObject("groupmaster", groupmaster);
		int groupmasterkey = groupservice.groupmasterkey(groupkey);
		mv.addObject("groupmasterkey", groupmasterkey);
		GLocation location = groupservice.groupwhere(group.getWhereKey());
		mv.addObject("groupswhere", location.getSWhere());
		mv.addObject("groupdwhere", location.getDWhere());
		int age = groupservice.groupage(group.getAgeKey());
		mv.addObject("groupage", age);
		String dcategory = groupservice.groupdcategory(groupkey);
		mv.addObject("groupdcategory", dcategory);
		String scategory = groupservice.groupscategory(groupkey);
		mv.addObject("groupscategory", scategory);
		int groupmembers = groupservice.groupmembers(groupkey);
		mv.addObject("groupmembers", groupmembers);
		List<GGroupBoard> groupboardlist = groupservice.groupboardlist(groupkey);
		mv.addObject("groupboardlist", groupboardlist);
		List<MemberList> groupmemberlist = groupservice.groupmemberlist(groupkey);
		mv.addObject("groupmemberlist", groupmemberlist);
		Post groupafterlist = groupservice.groupafterlist(groupkey);
		mv.addObject("groupafterlist", groupafterlist);
		List<Post> groupmeetinglist = groupservice.groupmeetinglist(groupkey, userkey);
		mv.addObject("groupmeetinglist", groupmeetinglist);
		List<CalendarList> groupcalendarlist = groupservice.groupcalendarlist(userkey, month, year);
		mv.addObject("groupcalendarlist", groupcalendarlist);
		mv.addObject("groupcalendarlistCount", groupcalendarlist.size());
		List<UserRegGroup> userreggroup = groupservice.userreggroup(userkey);
		mv.addObject("userreggroup", userreggroup);
		mv.addObject("userreggroupcount", userreggroup.size());
		for (int i = 0; i < groupcalendarlist.size(); i++) {
			if (Integer.parseInt(groupcalendarlist.get(i).getStartdate()) == date) {
				int d = Integer.parseInt(groupcalendarlist.get(i).getStartdate());
				List<Shortschedule> shortschedule = groupservice.shortschedule(userkey, d, year, month);
				mv.addObject("shortschedule", shortschedule);
			}
		}
		
		int isMem = groupservice.isMem(groupkey, userkey);
		mv.addObject("isMem", isMem);
		return mv;
    }
	
	@ResponseBody
	@RequestMapping(value = "/grouplistajax.net")
	public Object grouplistajax(@RequestParam(value = "page", defaultValue = "1", required = false) int page,HttpSession session)
			throws Exception {
		System.err.println("!!!!!!!!!!!!!!!!!!"+page);
		String id = "";
		int userkey = -1;
		HashMap<String, Object> map = new HashMap<String, Object>();
		if (session.getAttribute("id") != null) {
			id = session.getAttribute("id").toString();
			GUsers guser = groupservice.userkey(id);
			userkey = guser.getUserKey();
			map.put("userkey", userkey);
		} else {
			map.put("userkey", userkey);
		}
		List<UserRegGroup> userreggroupc = groupservice.userreggroup(userkey);
		map.put("userreggroupcount", userreggroupc.size());
		int limit = 3;
		int listcount = userreggroupc.size();
		int maxpage = (listcount + limit - 1) / limit;
		int startpage = ((page - 1) / 10) * 10 + 1;
		int endpage = startpage + 10 - 1;
		if (endpage > maxpage)
			endpage = maxpage;
		List<UserRegGroup> userreggroup = groupservice.userreggroupl(page, limit,userkey);
		map.put("page", page);
		map.put("maxpage", maxpage);
		map.put("startpage", startpage);
		map.put("endpage", endpage);
		map.put("listcount", listcount);
		map.put("userreggroup", userreggroup);
		map.put("limit", limit);
		return map;
	}
	
	@RequestMapping(value = "/group_admin_modifySchedule.net", method = RequestMethod.GET)
	public String group_admin_modifySchedule() {
		return "member/groupin_group_admin_modifySchedule";
	}

	@RequestMapping(value = "/group_admin_members.net", method = RequestMethod.GET)
	public String group_admin_members() {
		return "member/groupin_group_admin_members";
	}

	@RequestMapping(value = "/group_boardWrite.net", method = RequestMethod.GET)
	public String group_boardWrite() {
		return "member/groupin_group_boardWrite";
	}
	
	@RequestMapping(value = "/group_admin_signup.net")
	public ModelAndView group_admin_signup(@RequestParam(value = "groupkey") int groupkey, 
											HttpServletResponse response, ModelAndView mv, HttpSession session) throws IOException {
		int userkey = -1;
		if (session.getAttribute("id") == null) {
			response.setContentType("text/html; charset=utf-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('로그인 후 이용해주세요.');");
			out.println("location.href = 'login'");
			out.println("</script>");
			out.close();
			return null;
		} else {
			userkey = groupMemberService.getUser((String) session.getAttribute("id"));
		}
		
		// 기존에 입력한 가입양식이 있으면 그거 가져가야 되고 없으면 새로 입력해 달라고 해야함
		List<JoinQuest> list = groupMemberService.getJoinSample(groupkey);	// 현재 모임의 가입 양식 가져오기
		if (!list.isEmpty()) {
			mv.addObject("quest1", list.get(0).getQuest1());
			mv.addObject("quest2", list.get(0).getQuest2());
			mv.addObject("quest3", list.get(0).getQuest3());
			mv.addObject("quest4", list.get(0).getQuest4());
			mv.addObject("quest5", list.get(0).getQuest5());
			mv.addObject("introduce", list.get(0).getIntroduce());
		}
		
		Calendar c = Calendar.getInstance();
		int month = c.get(Calendar.MONTH) + 1;
		int year = c.get(Calendar.YEAR);
		int date = c.get(Calendar.DATE);
		
		mv.addObject("groupkey", groupkey);
		
		GGroupMember groupmember = groupservice.groupmember(userkey, groupkey);
		mv.addObject("userinfo", groupmember);
		
		GGroup group = groupservice.groupInfo(groupkey); // 모임 정보
		mv.addObject("group", group);
		
		String groupmaster = groupservice.groupmaster(groupkey);
		mv.addObject("groupmaster", groupmaster);
		
		int groupmasterkey = groupservice.groupmasterkey(groupkey);	// 모임장키
		mv.addObject("groupmasterkey", groupmasterkey);
		
		GLocation location = groupservice.groupwhere(group.getWhereKey());	// 지역
		mv.addObject("groupswhere", location.getSWhere());
		mv.addObject("groupdwhere", location.getDWhere());
		
		int age = groupservice.groupage(group.getAgeKey());	// 연령대
		mv.addObject("groupage", age);
		
		String dcategory = groupservice.groupdcategory(groupkey);	// 카테고리 대분류
		mv.addObject("groupdcategory", dcategory);
		
		String scategory = groupservice.groupscategory(groupkey);	// 카테고리 소분류
		mv.addObject("groupscategory", scategory);
		
		int groupmembers = groupservice.groupmembers(groupkey);
		mv.addObject("groupmembers", groupmembers);
		
		List<GGroupBoard> groupboardlist = groupservice.groupboardlist(groupkey);
		mv.addObject("groupboardlist", groupboardlist);
		
		List<MemberList> groupmemberlist = groupservice.groupmemberlist(groupkey);
		mv.addObject("groupmemberlist", groupmemberlist);
		
		List<Post> groupmeetinglist = groupservice.groupmeetinglist(groupkey, userkey);
		mv.addObject("groupmeetinglist", groupmeetinglist);
		
		List<CalendarList> groupcalendarlist = groupservice.groupcalendarlist(userkey, month, year);
		mv.addObject("groupcalendarlist", groupcalendarlist);
		mv.addObject("groupcalendarlistCount", groupcalendarlist.size());
		
		List<UserRegGroup> userreggroup = groupservice.userreggroup(userkey);
		mv.addObject("userreggroup", userreggroup);
		mv.addObject("userreggroupcount", userreggroup.size());
		
		for (int i = 0; i < groupcalendarlist.size(); i++) {
			if (Integer.parseInt(groupcalendarlist.get(i).getStartdate()) == date) {
				int d = Integer.parseInt(groupcalendarlist.get(i).getStartdate());
				List<Shortschedule> shortschedule = groupservice.shortschedule(userkey, d, year, month);
				mv.addObject("shortschedule", shortschedule);
			}
		}
		
		mv.setViewName("group/groupin_group_admin_signup");;
		return mv;
	}
	
	@ResponseBody
	@PostMapping("groupSignupSetting")
	public Object signupSetting(JoinQuest quest, String groupkey) {
		Map<String, Object> map = new HashMap<String, Object>();
		System.out.println("=====================================================");
		System.out.println("자기소개 = " + quest.getIntroduce());
		System.out.println("quest1 = " + quest.getQuest1());
		System.out.println("=====================================================");
		
		int result = -1;
		
		if (quest.getIntroduce() == null || quest.getIntroduce().equals("")) {
			quest.setIntroduce("자기소개를 입력해주세요.");
		}
		
		// 일단 해당 모임이 만들어놓은 가입양식이 있는지 (select)
		result = groupservice.getSignupSample(Integer.parseInt(groupkey));
		
		switch(result) {
		case 0:
			// 가입양식 추가
			map.put("quest", quest);
			map.put("groupkey", groupkey);
			result = groupservice.addSignupSample(map);	
			
			if (result == 1) 
				map = getJoinSample(Integer.parseInt(groupkey));
			
			map.put("result", result);
			break;
		case 1:
			// 가입양식 수정
			map.put("quest", quest);
			map.put("groupkey", groupkey);
			result = groupservice.updateSignupSample(map);
			
			if (result == 1)
				map = getJoinSample(Integer.parseInt(groupkey));
			
			map.put("result", result);
			break;
		}
		return map;
	}
	
	// 현재 모임의 가입 양식 가져오기
	public Map<String, Object> getJoinSample (int groupkey) {
		Map<String, Object> data = new HashMap<String, Object>();
		List<JoinQuest> list = groupMemberService.getJoinSample(groupkey);	
		if (!list.isEmpty()) {
			data.put("quest1", list.get(0).getQuest1());
			data.put("quest2", list.get(0).getQuest2());
			data.put("quest3", list.get(0).getQuest3());
			data.put("quest4", list.get(0).getQuest4());
			data.put("quest5", list.get(0).getQuest5());
			data.put("introduce", list.get(0).getIntroduce());
		}
		return data;
	}
	
	public Map<String, Object> pagination (int page, int limit, int listcount) {
		Map<String, Object> map = new HashMap<String, Object>();
		
		int maxpage = (listcount + limit - 1) / limit;	// 총 페이지 수
		int startpage = ((page - 1) / 10) * 10 + 1;		// 현재 페이지에 보여줄 시작 페이지 수
		int endpage = startpage + 10 - 1;				// 현재 페이지에 보여줄 마지막 페이지 수
		
		if (endpage > maxpage) endpage = maxpage;
		
		map.put("maxpage", maxpage);
		map.put("startpage", startpage);
		map.put("endpage", endpage);
		return map;
	}
}
