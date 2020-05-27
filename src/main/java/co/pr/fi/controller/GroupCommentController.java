package co.pr.fi.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import co.pr.fi.domain.GComment;
import co.pr.fi.domain.GGroupMember;
import co.pr.fi.service.GroupBoardService;
import co.pr.fi.service.GroupCommentService;
import co.pr.fi.service.GroupMemberService;

@Controller
public class GroupCommentController {

	@Autowired
	GroupCommentService groupCommentService;
	
	@Autowired
	GroupMemberService groupMemberService;
	
	@Autowired
	GroupBoardService groupBoardService;
	
	/* status : -1(login 페이지로 이동), 0(댓글 등록 실패), 1(댓글 등록) */
	
	// # 댓글에 답댓 달기
	@ResponseBody
	@PostMapping("commentReply")
	public Object commentReply(@RequestParam(required = false, defaultValue = "-1") int postKey,
							   @RequestParam(required = false, defaultValue = "-1") int groupKey,
							   @RequestParam(required = false, defaultValue = "") String content,
							   @RequestParam(required = false, defaultValue = "-1") int commentnum,
							   @RequestParam(required = false, defaultValue = "0") int commentshow,
							   HttpSession session) {
		
		System.out.println("답글 controller");
		
		Map<String, Object> data = new HashMap<String, Object>();
		
		if (session.getAttribute("id") == null)
			return data.put("status", -1);
		
		// 현재 로그인한 회원 유저키 구하기
		int userkey = groupMemberService.getUser((String)session.getAttribute("id"));
		
		// commentnum = 답글이 달리는 원댓
		GComment co = groupCommentService.getCommentInfo(commentnum);
		data.put("postkey", postKey);
		data.put("userkey", userkey);
		data.put("groupkey", groupKey);
		data.put("content", content);
		data.put("commentnum", commentnum);
		data.put("commentshow", commentshow);
		
		int result = groupCommentService.commentReply(data, co);
		
		if (result == -1 || result == 0) {
			// 실패 코드 전송
			data.clear();
			data.put("status", -1);
			return data;
		}
		
		return commentLoad(userkey, postKey, groupKey);
	}
	
	/**** 글에 댓글 달기 ****/
	@ResponseBody
	@PostMapping("postReply")
	public Object postReply(@RequestParam(required = false, defaultValue = "-1") int postKey,
							@RequestParam(required = false, defaultValue = "-1") int groupKey,
							@RequestParam(required = false, defaultValue = "") String content,
							@RequestParam(required = false, defaultValue = "0") int commentshow,
							HttpSession session) {
		System.out.println("### 글에 댓글 달기 ###");
		
		Map<String, Object> data = new HashMap<String, Object>();
		
		// 로그인 안 된 상태일 때
		if (session.getAttribute("id") == null) {
			data.put("status", -1);	
			return data;
		}
		
		// 현재 로그인한 회원 유저키 구하기
		int userkey = groupMemberService.getUser((String)session.getAttribute("id"));
		
		data.put("postkey", postKey);
		data.put("groupkey", groupKey);
		data.put("userkey", userkey);
		data.put("content", content);
		data.put("commentReLev", 0);	// 일반 댓글은 답변 깊이가 0
		data.put("commentReSeq", 0);	// 일반 댓글은 답변 순서가 0
		data.put("commentshow", commentshow);
		
		// 글에 댓글 달기 
		int result = groupCommentService.postReply(data);
		
		// 댓글 등록 실패 
		if (result != 1) {
			data.put("status", result);
			return data;
		}
		
		return commentLoad(userkey, postKey, groupKey);
	}
	
	// # 댓글 삭제
	@ResponseBody
	@PostMapping("deleteReply")
	public Object deleteReply (@RequestParam(required = true, defaultValue = "-1") int commentnum,
								@RequestParam(required = false, defaultValue = "-1") int postkey,
								@RequestParam(required = false, defaultValue = "-1") int groupkey,
							   HttpSession session) {
		
		Map<String, Object> data = new HashMap<String, Object>();
		
		int userkey = groupMemberService.getUser((String)session.getAttribute("id"));
		
		int result = groupCommentService.commentDelete(commentnum);
		if (result == 0) {	// 삭제 실패
			data.put("result", result);
			return data;
		}
		
		return commentLoad(userkey, postkey, groupkey);
	}
	
	/**** 댓글 수정 ****/
	@ResponseBody
	@PostMapping("updateReply")
	public Object updateReply (@RequestParam(required = false, defaultValue = "-1") int commentnum,
							   @RequestParam(required = false, defaultValue = "-1") int postkey,
							   @RequestParam(required = false, defaultValue = "-1") int groupkey,
							   @RequestParam(required = false, defaultValue = "") String content,
							   HttpSession session) {
		System.out.println("댓글 내용 수정");
		
		Map<String, Object> data = new HashMap<String, Object>();
		
		int userkey = groupMemberService.getUser((String)session.getAttribute("id"));
		
		data.put("commentnum", commentnum);
		data.put("content", content);
		
		int result = groupCommentService.update(data);
		
		if (result != 1) {
			data.clear();
			data.put("result", result);	// 실패
			return data;
		}
		
		return commentLoad(userkey, postkey, groupkey);
	}
	
	/**** 수정을 위한 기존 댓글 가져오기 ****/
	@ResponseBody
	@RequestMapping(value = "getOriginReply", method = RequestMethod.POST, produces = "application/text; charset=utf8")
	public String getOriginReply (@RequestParam(required = false, defaultValue = "-1") int commentNo,
								  HttpSession session) {
		System.out.println("댓글 수정을 위해 댓글 내용 가져오기");
		String content = "";
		content = groupCommentService.getContent(commentNo);
		System.out.println("content = " + content);
		return content;
	}
	
	public Map<String, Object> commentLoad (int userkey, int postkey, int groupkey) {
		System.out.println("############### 댓글 로드하기 ###############");
		Map<String, Object> map = new HashMap<String, Object>();
		List<GComment> commentList = new ArrayList<GComment>();
		int listcount = 0, page = 1, limit = 10;
		
		map.put("postkey", postkey);
		map.put("groupkey", groupkey);
		map.put("userkey", userkey);
		map.put("page", page);
		map.put("limit", limit);
		
		System.out.println("postkey = " + map.get("postkey"));
		System.out.println("groupkey = " + map.get("groupkey"));
		System.out.println("userkey = " + map.get("userkey"));
		
		commentList = groupBoardService.getBoardComment(map);		// 현재 게시글에 해당하는 댓글리스트
		GGroupMember mem = groupMemberService.getPic(map);			// 현 유저의 프사 가져오기
		listcount = groupCommentService.getCommentCount(map); 		// 현재 게시글에 해당하는 댓글수
		
		map = pagination(page, limit, listcount);
		map.put("comment", commentList);	// 댓글리스트
		map.put("listcount", listcount);	// 댓글 개수
		map.put("page", page);				// 페이지
		map.put("limit", limit);			// 최대 개수
		map.put("loginuser", userkey);		// 유저키
		map.put("profileFile", mem.getProfileFile());
		return map;
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
