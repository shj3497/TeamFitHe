const toggleBtn = document.querySelector('.navbar_toggleBtn');
const menu = document.querySelector('.navbar_menu');
const icons = document.querySelector('.navbar_icons');
const userid = document.querySelector('.userid');
const navbar_icons = document.getElementById("user_info");

// 햄버거 btn 클릭시 메뉴/아이콘 펼침
toggleBtn.addEventListener('click', () => {
    //active속성 활용하여 토글 이벤트 적용
    menu.classList.toggle('active');
    icons.classList.toggle('active');
});

userid.addEventListener('click', () => {
    alert("hello");

});


/*
const toggleBtn = document.querySelector('.navbar_toggleBtn');
const menu = document.querySelector('.navbar_menu');
const icons = document.querySelector('.navbar_icons');
const loginM = document.querySelector('.navbar_icons2');

toggleBtn.addEventListener('click', () => {
    //active속성 활용하여 토글 이벤트 적용
    menu.classList.toggle('active');
    icons.classList.toggle('active');
    loginM.classList.toggle('active');
});

*/