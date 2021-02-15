package com.fithe.member.service;

import java.util.List;

import com.fithe.member.vo.MemberVO;

public interface MemberService {

	// 관리자가 회원 전체 조회시
	public List<MemberVO> memberSelectAll(MemberVO mvo);
	// 회원 조회시
	public MemberVO memberSelect(MemberVO mvo);
	// 회원 가입시
	public int memberInsert(MemberVO mvo);
	// 회원 정보 수정시
	public int memberUpdate(MemberVO mvo);
	// 회원 탈퇴시
	public int memberDelete(MemberVO mvo);
	// id 중복 체크
	public int memberIdCheck(MemberVO mvo);

	
	// 로그인
	public MemberVO memberLogin(MemberVO mvo);

	
	// 인증번호 저장
	public int authInsert(MemberVO mvo);
}
