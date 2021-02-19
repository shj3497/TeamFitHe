package com.fithe.member.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fithe.common.commons.encryption.PasswordEncoding;
import com.fithe.member.service.MemberService;
import com.fithe.member.vo.MemberVO;

@Controller
public class MypageController {

	private Logger logger = Logger.getLogger(MypageController.class);
	@Autowired(required=false)
	private MemberService memberService;
	
	@Autowired(required=false)
	public MypageController(MemberService memberService) {
		this.memberService=memberService;
	}
	
	
//	#################### !MyPage! ####################
	
	@RequestMapping(value="mypage", method=RequestMethod.GET)
	public String mypage(Model model, MemberVO mvo, HttpServletRequest request) {
		// 로그인 후 마이페이지 이동 버튼 클릭시 동작
		logger.info("mypage() 진입");
		
		// 로그인 이후에 클릭할 페이지 이므로 세션으로 정보를 가져온다.
		HttpSession session = request.getSession();
		// 세션을 아이디로 설정했으니까 getAttribute("mid")이다.
		String mid = (String)session.getAttribute("mid");
		logger.info("현재 로그인되어있는 id >>> : " + mid);
		
		// 로그인 되어있는 id를 vo에 세팅
		mvo.setMid(mid);
		
		// 로그인 되어있는 id를 VO에 세팅해줬으므로 select문으로 회원 정보를 조회한다.
		MemberVO _mvo = memberService.memberSelect(mvo);
		
		// 모델객체로 view에 조회한 회원 정보를 전달한다.
		model.addAttribute("memberVO", _mvo);
		
		return "mypage/mypage";
	}
	
	
	@RequestMapping(value="memberupdateForm", method=RequestMethod.GET)
	public String memberUpdateForm(Model model, HttpServletRequest request, MemberVO mvo) {
		// 회원 정보 수정 페이지로 이동
		logger.info("memberUpdateForm() 진입");
		
		// 세션 번호로 정보 가져오기
		HttpSession session = request.getSession();
		String mid = (String)session.getAttribute("mid");
		logger.info("세션 mid >>> : " + mid);

		// 세션으로 정보 가져오기
		mvo.setMid(mid);
		
		// 세션으로 불러온 mid에 따른 멤버 정보조회
		MemberVO _mvo = memberService.memberSelect(mvo); // >>?? 이거만 해줘도 자동으로 세션이 불러오는데?
		// 잘 불러오나 확인
		// logger.info("_mvo.mname >>> : " + _mvo.getMname());
		
		model.addAttribute("memberVO", _mvo);
		
		return "mypage/myinfoupdate";
	}
	
	// db업데이트가 이루어지는 회원 정보 업데이트 메소드
	@RequestMapping(value="memberUpdate", method=RequestMethod.POST)
	public String memberUpdate(Model model, MemberVO mvo, HttpServletRequest request) {
		// 회원 정보 수정
		logger.info("memberUpdate() 진입");
		
		// 이메일을 합쳐야한다.
		String memail_a = request.getParameter("memail_a");
		String memail_b = request.getParameter("memail_b");
		String memail = memail_a.concat(memail_b);

		// 데이터 잘 넘어와서 합쳐졌나 확인
		logger.info("memail >>> : " + memail);
		
		// VO에 세팅해준다.
		mvo.setMemail(memail);
		
		// 업데이트 쿼리 실행결과가 담긴다.
		int nCnt = memberService.memberUpdate(mvo);
		logger.info("nCnt >>> : " + nCnt);
		if(nCnt==1){
			logger.info("회원 정보 수정 성공");
			
			return "mypage/mypage";
		}
		else {
			logger.info("회원 정보 수정 실패");
			return "member/error";
		}
	}
	
//	#################### !MySecPage! ####################
	
	@RequestMapping(value="mySecpage", method=RequestMethod.GET)
	public String mySecpage(Model model, MemberVO mvo, HttpServletRequest request) {
		logger.info("MySecPage() 진입");
		// 단순히 페이지 이동임
	
		return "mypage/mySecpage";
	}
	
	@RequestMapping(value="changePwFormgo", method=RequestMethod.GET)
	public String changePwFormgo() {
		// 단순히 패스워드 업데이트 하는 페이지로 이동
		logger.info("memberPwUpdateForm() 진입");
		
		return "mypage/changePwForm";
	}
	
	@RequestMapping(value="changePw", method=RequestMethod.POST)
	@ResponseBody
	public String changePw(Model model, MemberVO mvo, HttpServletRequest request) {
		// pw변경버튼 누르면 동작
		logger.info("changePw() 진입");
		
		String result = "";
		
		// 세션으로 로그인 되어있는 아이디 불러오기
		HttpSession session = request.getSession();
		String mid = (String)session.getAttribute("mid");
		logger.info("로그인된 아이디 >>> : " + mid);
		mvo.setMid(mid); // 아이디를 mvo에 세팅해준다.
		
		// changePwForm.jsp에서 입력한 현재 비밀번호 mpw_c
		String mpw_c = request.getParameter("mpw_c");
		logger.info("mpw_c >>> : " + mpw_c); // 잘 넘어왔나 로그 찍어보기
		
		// mpw_c와 db에 저장되어있는 pw를 비교해줘야한다.
		// 우선 로그인 되어있는 id를 가지고 db에서 조회를 한다.
		MemberVO _mvo = null;
		_mvo = memberService.memberSelect(mvo); // 조회된 결과가 _mvo 객체에 담겼다.
		
		String mpw_db = _mvo.getMpw(); // 조회된 결과에서 pw를 변수로 지정해줬다.
		logger.info("mpw_db >>> : " + mpw_db); // 잘 불러왔나 찍어보기
		
		// 이제 db에서 조회된 mpw_db 와 changePwForm.jsp에서 입력한 현재 비밀번호 mpw_c를 비교해주자.
		boolean bool = PasswordEncoding.matches(mpw_c, mpw_db);
		logger.info("mpw_c와 암호화된 mpw_db의 값 비교 >>> : " + bool);
		
		if(bool) {
		
			// VO에 세팅된 PW 불러와서 암호화 실시
			String mpw = PasswordEncoding.encode(mvo.getMpw());

			// 세션으로 불러온 id를 VO에 세팅
			mvo.setMid(mid);
			logger.info("VO에 세팅된 mid >>> : " + mvo.getMid());
			
			mvo.setMpw(mpw);
			logger.info("VO에 세팅된 mpw >>> : " + mvo.getMpw());
			
			// 업데이트에 성공하면 1, 실패하면 0 리턴된다.
			int nCnt = memberService.pwUpdate(mvo);
			logger.info("nCnt >>> : " + nCnt);
			
			if(nCnt == 1) {
				// 패스워드 업데이트에 성공하면
				result = "1";
			}else {
				// 패스워드 업데이트에 실패하면
				result = "0";
			}
			
			return result;
		}else {
			// 현재패스워드라고 입력한 mpw_와 디비에서 가져온 패스워드 mpw_db와의 비교가 실패한다면
			result = "2";
			
			return result;
		}  
	}
	
	// 탈퇴하기 버튼을 클릭하여 폼 이동후
	// 현재 패스워드를 입력받아 처리할 것이다.
	
	
	
	
	
	
}
