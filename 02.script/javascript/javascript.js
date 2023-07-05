
//---------------------------------------------------#
// 1시간에 한번씩 주기적으로 ClassName으로 찾은 Elements의 배열의 첫번째 항목 클릭하는 역할

setInterval(()=>{
    document.getElementsByClassName('virtualized-table-csv-export-button')[0].click()
}, 1000*60*60);

//---------------------------------------------------#