<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr">
	<head>
		<title></title>
		<script src="../script/jquery.min.js" type="text/javascript"></script>
		<script src='../script/qj2.js' type="text/javascript"></script>
		<script src='qset.js' type="text/javascript"></script>
		<script src='../script/qj_mess.js' type="text/javascript"></script>
		<script src='../script/mask.js' type="text/javascript"></script>
		<script src="../script/qbox.js" type="text/javascript"></script>
		<link href="../qbox.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript">
            this.errorHandler = null;
            function onPageError(error) {
                alert("An error occurred:\r\n" + error.Message);
            }

            var q_name = "caraccident";
            var q_readonly = ['txtNoa', 'txtWorker', 'txtWorker2','txtConciliatorymoney'];
            var bbmNum = [['txtClaimmoney', 10, 0, 1], ['txtConciliatorymoney', 10, 0, 1], ['txtSelfmoney', 10, 0, 1], ['txtReparationmoney', 10, 0, 1]];
            var bbmMask = [];
            q_sqlCount = 6;
            brwCount = 6;
            brwList = [];
            brwNowPage = 0;
            brwKey = 'noa';
            brwCount2 = 13;
            //ajaxPath = ""; //  execute in Root
            aPop = [['txtInsurerno', 'lblInsurer', 'insurer', 'noa,comp', 'txtInsurerno,txtInsurer', 'insurer_b.aspx']
	            ,['txtDriver', 'lblDriver', 'carowner', 'namea,idno,birthday', '0txtDriver,txtId,txtBirthday,txtId', 'carowner_b.aspx']
	            ,['txtCarno', 'lblCarno', 'car2', 'a.noa,a.cardealno,a.cardeal', 'txtCarno,cmbCardealno,txtCardeal', 'car2_b.aspx']
            ];

            $(document).ready(function() {
                if (location.href.indexOf('?') < 0)// debug
                {
                    location.href = location.href + "?;;;noa='001-M9'";
                    return;
                }
                bbmKey = ['noa'];
                q_brwCount();
                q_gt(q_name, q_content, q_sqlCount, 1);
            });
            function main() {
                if (dataErr) {
                    dataErr = false;
                    return;
                }
                mainForm(0);
            }///  end Main()

            function mainPost() {
                bbmMask = [['txtDatea', r_picd], ['txtClaimdate', r_picd], ['txtEnddate', r_picd], ['txtBirthday', r_picd], ['txtTimea', '99:99']];

                q_getFormat();
                q_mask(bbmMask);
                q_gt('cardeal', '', 0, 0, 0, "");
                
                $('#txtClaimmoney').change(function() {
                	q_tr('txtConciliatorymoney',q_add(q_add(q_float('txtClaimmoney'),q_float('txtSelfmoney')),q_float('txtReparationmoney')));
				});
				$('#txtSelfmoney').change(function() {
                	q_tr('txtConciliatorymoney',q_add(q_add(q_float('txtClaimmoney'),q_float('txtSelfmoney')),q_float('txtReparationmoney')));
				});
				$('#txtReparationmoney').change(function() {
                	q_tr('txtConciliatorymoney',q_add(q_add(q_float('txtClaimmoney'),q_float('txtSelfmoney')),q_float('txtReparationmoney')));
				});
				
				var t_i=0;
                $('#btnUpload').change(function() {
                    if(!(q_cur==1 || q_cur==2)){
                        return;
                    }
                    var files = document.getElementById('btnUpload').files;
                    var file ='';
                    var t_txt = '';
                    t_i=0;
                    for(var i = 0; i < files.length; i++){
                        file = files[i];
                        t_txt += ';'+file.name
                        if(file){
                            Lock(1);
                            var ext = '';
                            var extindex = file.name.lastIndexOf('.');
                            if(extindex>=0){
                                ext = file.name.substring(extindex,file.name.length);
                            }
                            $('#txtImages').val(file.name);
                            //$('#txtGtime').val(guid()+Date.now()+ext);
                            //106/05/22 不再使用亂數編碼
                            $('#txtGtime').val(file.name);
                            
                            fr = new FileReader();
                            fr.fileName = $('#txtGtime').val();
                            fr.readAsDataURL(file);
                            fr.onprogress = function(e){
                                if ( e.lengthComputable ) { 
                                    var per = Math.round( (e.loaded * 100) / e.total) ; 
                                    $('#FileList').children().last().find('progress').eq(0).attr('value',per);
                                }; 
                            }
                            fr.onloadstart = function(e){
                                $('#FileList').append('<div styly="width:100%;"><progress id="progress" max="100" value="0" ></progress><progress id="progress" max="100" value="0" ></progress><a>'+fr.fileName+'</a></div>');
                            }
                            //多檔案上傳
                            fr.onloadend = (function(file){
                                return function (e) {
                                    $('#FileList').children().last().find('progress').eq(0).attr('value',100);
                                    console.log(fr.fileName+':'+fr.result.length);
                                    console.log(e.target.result);
                                    var oReq = new XMLHttpRequest();
                                    oReq.upload.addEventListener("progress",function(e) {
                                        if (e.lengthComputable) {
                                            percentComplete = Math.round((e.loaded / e.total) * 100,0);
                                            $('#FileList').children().last().find('progress').eq(1).attr('value',percentComplete);
                                        }
                                    });
                                    oReq.upload.addEventListener("load",function(e) {
                                        Unlock(1);
                                    });
                                    oReq.upload.addEventListener("error",function(e) {
                                        alert("資料上傳發生錯誤!");
                                    });
                                        
                                    oReq.timeout = 360000;
                                    oReq.ontimeout = function () { alert("Timed out!!!"); }
                                    oReq.open("POST", 'caraccident_upload.aspx', true);
                                    oReq.setRequestHeader("Content-type", "text/plain");
                                    oReq.setRequestHeader("FileName", escape(file.name));
                                    oReq.send(e.target.result);//oReq.send(e.target.result);
                                }
                            })(file);
                        }
                    }
                    ShowDownlbl();
                    $('#txtImages').val(t_txt);
                            //$('#txtGtime').val(guid()+Date.now()+ext);
                            //106/05/22 不再使用亂數編碼
                    $('#txtGtime').val(t_txt);
                });
                $('#lblDownload').click(function(){
                    var t_images=$('#txtImages').val().substring(1,$('#txtImages').val().length).split(";");
                    var t_gtime=$('#txtGtime').val().substring(1,$('#txtGtime').val().length).split(";");
                    if($('#txtImages').val().length>0 && $('#txtGtime').val().length>0){
                            for(i=0;i<t_images.length;i++){
                                var iframe = document.createElement('iframe');
                                iframe.src='caraccident_download.aspx?FileName='+t_images[i]+'&TempName='+t_gtime[i];
                                iframe.style='display: none;'
                                document.body.appendChild(iframe);
                            }   
                    }else if($('#txtGtime').val().length>0){
                            for(i=0;i<t_gtime.length;i++){
                                var iframe = document.createElement('iframe');
                                iframe.src='caraccident_download.aspx?FileName='+t_gtime[i]+'&TempName='+t_gtime[i];
                                iframe.style='display: none;'
                                document.body.appendChild(iframe);
                            } 
                    }else{    
                        alert('無資料...!!');
                    }
                });
            }

            function q_boxClose(s2) {
                var ret;
                switch (b_pop) {
                    case q_name + '_s':
                        q_boxClose2(s2);
                        ///   q_boxClose 3/4
                        break;
                }/// end Switch
                b_pop = '';
            }

            function q_gtPost(t_name) {
                switch (t_name) {
                    case 'cardeal':
                        var as = _q_appendData("cardeal", "", true);
                        var t_item = " @ ";
                        for ( i = 0; i < as.length; i++) {
                            t_item = t_item + (t_item.length > 0 ? ',' : '') + as[i].noa + '@' + as[i].nick;
                        }
                        q_cmbParse("cmbCardealno", t_item);
                        if (abbm[q_recno])
                            $("#cmbCardealno").val(abbm[q_recno].cardealno);
                        break;
                    case q_name:
                        if (q_cur == 4)
                            q_Seek_gtPost();
                        break;
                }
            }

            function _btnSeek() {
                if (q_cur > 0 && q_cur < 4)// 1-3
                    return;
                q_box('caraccident_s.aspx', q_name + '_s', "500px", "340px", q_getMsg("popSeek"));
            }

            function btnIns() {
                if (q_getId()[3].length > 0) {
                    var t_carno = $.trim(q_getId()[3].replace(/[carno='*']/g, ""));
                    _btnIns();
                    if (t_carno.length > 0) {
                        $('#txtCarno').val(t_carno);
                        $('#txtDatea').focus();
                    } else {
                        $('#txtCarno').focus();
                    }
                    $('#txtNoa').val('AUTO');
                } else {
                    _btnIns();
                    $('#txtCarno').focus();
                    $('#txtNoa').val('AUTO');
                }
            }

            function btnModi() {
                if (emp($('#txtNoa').val()))
                    return;

                _btnModi();
                ShowDownlbl();
                $('#txtDatea').focus();
            }

            function btnPrint() {

            }

            function btnOk() {
                $('#txtDatea').val($.trim($('#txtDatea').val()));
                if (!q_cd($('#txtDatea').val())) {
                    alert(q_getMsg('lblDatea') + '錯誤。');
                    return;
                }
                $('#txtClaimdate').val($.trim($('#txtClaimdate').val()));
                if (!q_cd($('#txtClaimdate').val())) {
                    alert(q_getMsg('lblClaimdate') + '錯誤。');
                    return;
                }
                $('#txtEnddate').val($.trim($('#txtEnddate').val()));
                if (!q_cd($('#txtEnddate').val())) {
                    alert(q_getMsg('lblEnddate') + '錯誤。');
                    return;
                }

                if (q_cur == 1)
                    $('#txtWorker').val(r_name);
                if (q_cur == 2)
                    $('#txtWorker2').val(r_name);
                $('#txtCardeal').val($('#cmbCardealno').find(":selected").text());

                var t_noa = $('#txtNoa').val();
                var t_date = $('#txtDatea').val();
                if (t_noa.length == 0 || t_noa == "AUTO")
                    q_gtnoa(q_name, replaceAll(q_getPara('sys.key_caraccident') + (t_date.length == 0 ? q_date() : t_date), '/', ''));
                else
                    wrServer(t_noa);
            }

            function wrServer(key_value) {
                var i;
                $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
                _btnOk(key_value, bbmKey[0], '', '', 2);
            }

            function refresh(recno) {
                _refresh(recno);
                ShowDownlbl();
                $('#btnUpload').val('');

            }

            function readonly(t_para, empty) {
                _readonly(t_para, empty);
                if(t_para){
                    $('#btnUpload').attr('disabled', 'disabled');
                }else{
                    $('#btnUpload').removeAttr('disabled', 'disabled');
                }
            }

            function btnMinus(id) {
                _btnMinus(id);
            }

            function btnPlus(org_htm, dest_tag, afield) {
                _btnPlus(org_htm, dest_tag, afield);
            }

            function q_appendData(t_Table) {
                return _q_appendData(t_Table);
            }

            function btnSeek() {
                _btnSeek();
            }

            function btnTop() {
                _btnTop();
            }

            function btnPrev() {
                _btnPrev();
            }

            function btnPrevPage() {
                _btnPrevPage();
            }

            function btnNext() {
                _btnNext();
            }

            function btnNextPage() {
                _btnNextPage();
            }

            function btnBott() {
                _btnBott();
            }

            function q_brwAssign(s1) {
                _q_brwAssign(s1);
            }

            function btnDele() {
                _btnDele();
            }

            function btnCancel() {
                _btnCancel();
            }
			
			function q_popPost(s1) {
		    	switch (s1) {
		    		case 'txtCarno':
		    			if(!emp($('#txtCarno').val())){
			    			var t_where = "where=^^ a.noa ='"+$('#txtCarno').val()+"' ^^";
						    q_gt('car2', t_where , 0, 0, 0, "getcar2", r_accy,1);
						    var as = _q_appendData("car2", "", true);
						    if(as[0]!=undefined){
						    	//DC素娟
						    	if(as[0].driverno.length>0){
						    		//有司機
						    		$('#txtDriver').val(as[0].driver);
						    		var t_where = "where=^^ noa ='"+as[0].driverno+"' ^^";
						    		q_gt('driver', t_where , 0, 0, 0, "getdriver", r_accy,1);
						    		var asd = _q_appendData("driver", "", true);
						    		if(asd[0]!=undefined){
						    			$('#txtId').val(asd[0].idno);
						    			$('#txtBirthday').val(asd[0].birthday);
						    		}
						    	}else{
						    		//沒司機抓車主
						    		$('#txtDriver').val(as[0].carowner);
						    		var t_where = "where=^^ noa ='"+as[0].carownerno+"' ^^";
						    		q_gt('carowner', t_where , 0, 0, 0, "getcarowner", r_accy,1);
						    		var aso = _q_appendData("carowner", "", true);
						    		if(aso[0]!=undefined){
						    			$('#txtId').val(aso[0].idno);
						    			$('#txtBirthday').val(aso[0].birthday);
						    		}
						    	}
						    	
						    	//抓最後投保
						    	var t_where = "where=^^ noa='"+$('#txtCarno').val()+"' ^^";
						    	q_gt('carinsure', t_where , 0, 0, 0, "getcarinsure", r_accy,1);
						    	var asi = _q_appendData("carinsure", "", true);
						    	var maxmon='',t_insurerno='',t_insurer='';
						    	for(var i=0;i<asi.length;i++){
						    		if(maxmon<asi[i].inmon){
						    			t_insurerno=asi[i].insurerno;
						    			t_insurer=asi[i].insurer;
						    		}
						    	}
						    	$('#txtInsurerno').val(t_insurerno);
						    	$('#txtInsurer').val(t_insurer);
						    }else{
						    	alert('車牌不存在!!');
						    }
					    
					    }
			        	break;
		    	}
			}
			function ShowDownlbl() {             
                $('#lblDownload').text('').hide();
                if(!emp($('#txtGtime').val()))
                    $('#lblDownload').text('下載').show();
            }

			
		</script>
		<style type="text/css">
            #dmain {
                overflow: hidden;
            }
            .dview {
                float: left;
                width: 38%;
            }
            .tview {
                margin: 0;
                padding: 2px;
                border: 1px black double;
                border-spacing: 0;
                font-size: medium;
                background-color: #FFFF66;
                color: blue;
            }
            .tview td {
                padding: 2px;
                text-align: center;
                border: 1px black solid;
            }
            .dbbm {
                float: left;
                width: 38%;
                margin: -1px;
                border: 1px black solid;
                border-radius: 5px;
            }
            .tbbm {
                padding: 0px;
                border: 1px white double;
                border-spacing: 0;
                border-collapse: collapse;
                font-size: medium;
                color: blue;
                background: #cad3ff;
                width: 100%;
            }
            .tbbm tr {
                height: 35px;
            }
            .tbbm tr td {
                width: 9%;
            }
            .tbbm .tdZ {
                width: 2%;
            }
            .tbbm tr td span {
                float: right;
                display: block;
                width: 5px;
                height: 10px;
            }
            .tbbm tr td .lbl {
                float: right;
                color: blue;
                font-size: medium;
            }
            .tbbm tr td .lbl.btn {
                color: #4297D7;
                font-weight: bolder;
                font-size: medium;
            }
            .tbbm tr td .lbl.btn:hover {
                color: #FF8F19;
            }
            .txt.c1 {
                width: 98%;
                float: left;
            }
            .txt.c2 {
                width: 38%;
                float: left;
            }
            .txt.c3 {
                width: 60%;
                float: left;
            }
            .txt.c4 {
                width: 18%;
                float: left;
            }
            .txt.c5 {
                width: 80%;
                float: left;
            }
            .txt.c6 {
                width: 99%;
                float: left;
            }
            .txt.num {
                text-align: right;
            }
            .tbbm td {
                margin: 0 -1px;
                padding: 0;
            }
            .tbbm td input[type="text"] {
                border-width: 1px;
                padding: 0px;
                margin: -1px;
                float: left;
            }
            .tbbm select {
                border-width: 1px;
                padding: 0px;
                margin: -1px;
            }

            input[type="text"], input[type="button"] ,select{
                font-size: medium;
            }
		</style>
	</head>
	<body>
		<!--#include file="../inc/toolbar.inc"-->
		<div id='dmain' style="overflow:hidden;">
			<div class="dview" id="dview" style="float: left;  width:30%;"  >
				<table class="tview" id="tview"   border="1" cellpadding='2'  cellspacing='0' style="background-color: #FFFF66;">
					<tr>
						<td align="center" style="width:5%"><a id='vewChk'> </a></td>
						<td align="center" style="width:25%"><a id='vewCarno'> </a></td>
						<td align="center" style="width:25%"><a id='vewDatea'> </a></td>
						<td align="center" style="width:25%"><a id='vewDriver'> </a></td>
					</tr>
					<tr>
						<td ><input id="chkBrow.*" type="checkbox" style=''/></td>
						<td align="center" id='carno'>~carno</td>
						<td align="center" id='datea'>~datea</td>
						<td align="center" id='driver'>~driver</td>
					</tr>
				</table>
			</div>
			<div class='dbbm' style="width: 70%;float:left">
				<table class="tbbm"  id="tbbm"   border="0" cellpadding='2'  cellspacing='0'>
					<tr class="tr1">
						<td><span> </span><a id="lblCarno" class="lbl"> </a></td>
						<td><input id="txtCarno" type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblCardeal" class="lbl"> </a></td>
						<td>
							<select id="cmbCardealno" class="txt c1"> </select>
							<input id="txtCardeal" type="text"  style="display:none;"/>
						</td>
						<td><span> </span><a id="lblReparationno" class="lbl"> </a></td>
						<td><input id="txtReparationno" type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblNoa" class="lbl"> </a></td>
						<td><input id="txtNoa" type="text" class="txt c1"/></td>
					</tr>
					<tr class="tr2">
						<td><span> </span><a id="lblDatea" class="lbl"> </a></td>
						<td><input id="txtDatea" type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblTimea" class="lbl"> </a></td>
						<td><input id="txtTimea" type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblPlace" class="lbl"> </a></td>
						<td colspan="3"><input id="txtPlace" type="text" class="txt c1"/></td>
					</tr>
					<tr class="tr3">
						<td><span> </span><a id="lblDriver" class="lbl btn"> </a></td>
						<td>
							<!--<input id="txtDriverno" type="text" class="txt c2"/>-->
							<input id="txtDriver" type="text" class="txt c1"/>
						</td>
						<td><span> </span><a id="lblId" class="lbl"> </a></td>
						<td><input id="txtId" type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblBirthday" class="lbl"> </a></td>
						<td><input id="txtBirthday" type="text" class="txt c1"/></td>
					</tr>
					<tr class="tr4">
						<td><span> </span><a id="lblInsurer" class="lbl btn"> </a></td>
						<td colspan="3">
							<input id="txtInsurerno" type="text" class="txt c2"/>
							<input id="txtInsurer" type="text" class="txt c3"/>
						</td>
					</tr>
					<tr class="tr5">
						<td><span> </span><a id="lblClaimno" class="lbl"> </a></td>
						<td><input id="txtClaimno" type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblClaimdate" class="lbl"> </a></td>
						<td><input id="txtClaimdate" type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblAdversary" class="lbl"> </a></td>
						<td><input id="txtAdversary" type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblInsurertel" class="lbl"> </a></td>
						<td><input id="txtInsurertel" type="text" class="txt c1"/></td>
					</tr>
					<tr class="tr6">
						<td><span> </span><a id="lblPolice" class="lbl"> </a></td>
						<td colspan="3"><input id="txtPolice" type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblPolicetel" class="lbl"> </a></td>
						<td ><input id="txtPolicetel" type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblPolicename" class="lbl"> </a></td>
						<td ><input id="txtPolicename" type="text" class="txt c1"/></td>
					</tr>
					<tr class="tr7">
						<td><span> </span><a id="lblInjuredname" class="lbl"> </a></td>
						<td><input id="txtInjuredname" type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblInjuredid" class="lbl"> </a></td>
						<td><input id="txtInjuredid" type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblInjuredage" class="lbl"> </a></td>
						<td><input id="txtInjuredage" type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblInjuredtel" class="lbl"> </a></td>
						<td ><input id="txtInjuredtel" type="text" class="txt c1"/></td>
					</tr>
					<tr class="tr8">
						<td><span> </span><a id="lblClaimmoney" class="lbl"> </a></td>
						<td><input id="txtClaimmoney" type="text" class="txt num c1"/></td>
						<td><span> </span><a id="lblSelfmoney" class="lbl"> </a></td>
						<td><input id="txtSelfmoney" type="text" class="txt num c1"/></td>
						<td><span> </span><a id="lblReparationmoney" class="lbl"> </a></td>
						<td><input id="txtReparationmoney" type="text" class="txt num c1"/></td>
						<td><span> </span><a id="lblConciliatorymoney" class="lbl"> </a></td>
						<td><input id="txtConciliatorymoney" type="text" class="txt num c1"/></td>
					</tr>
					<tr class="tr9">
						<td><span> </span><a id="lblEnddate" class="lbl"> </a></td>
						<td><input id="txtEnddate" type="text" class="txt c1"/></td>
						<td> </td>
						<td> </td>
						<td><span> </span><a id="lblWorker" class="lbl"> </a></td>
						<td><input id="txtWorker" type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblWorker2" class="lbl"> </a></td>
						<td><input id="txtWorker2" type="text" class="txt c1"/></td>
					</tr>
					<tr class="tr10">
					    <td><span> </span><a  id="lblUpload" class="lbl">圖片上傳</a></td>
                        <td colspan="3">
                            <input type="file" multiple="multiple" id="btnUpload" value="選擇檔案" style="width: 70%;"/>
                            <input id="txtImages" type="hidden" class="txt c1"/><!--原檔名-->
                            <input id="txtGtime" type="hidden" class="txt c1"/><!--上傳檔名-->
                            <a id="lblDownload" class='lbl btn'> </a>
                        </td>
                        <td style="display: none;"><div style="width:100%;" id="FileList"> </div></td>
                    </tr>
					<tr class="tr11">
						<td><span> </span><a id="lblMemo2" class="lbl"> </a></td>
						<td colspan="3"><textarea id="txtMemo2" rows="5" cols="10" style="width:95%; height: 50px;"> </textarea></td>
						<td><span> </span><a id="lblMemo" class="lbl"> </a></td>
						<td colspan="3"><textarea id="txtMemo" rows="5" cols="10" style="width:95%; height: 50px;"> </textarea></td>
					</tr>
					<tr class="tr12">
                        <td><span> </span><a id="lblLitigant" class="lbl">(一)當事人</a></td>
                        <td><input id="txtLitigant" type="text" class="txt c1"/></td>
                        <td><span> </span><a id="lblLitel" class="lbl">電話</a></td>
                        <td><input id="txtLitel" type="text" class="txt c1"/></td>
                        <td><span> </span><a id="lblLicarno" class="lbl">車牌號碼</a></td>
                        <td><input id="txtLicarno" type="text" class="txt c1"/></td>
                    </tr>
                    <tr class="tr13">
                        <td><span> </span><a id="lblLitigant2" class="lbl">(二)當事人</a></td>
                        <td><input id="txtLitigant2" type="text" class="txt c1"/></td>
                        <td><span> </span><a id="lblLitel2" class="lbl">電話</a></td>
                        <td><input id="txtLitel2" type="text" class="txt c1"/></td>
                        <td><span> </span><a id="lblLicarno2" class="lbl">車牌號碼</a></td>
                        <td><input id="txtLicarno2" type="text" class="txt c1"/></td>
                    </tr>
                    <tr class="tr14">
                        <td><span> </span><a id="lblLitigant3" class="lbl">(三)當事人</a></td>
                        <td><input id="txtLitigant3" type="text" class="txt c1"/></td>
                        <td><span> </span><a id="lblLitel3" class="lbl">電話</a></td>
                        <td><input id="txtLitel3" type="text" class="txt c1"/></td>
                        <td><span> </span><a id="lblLicarno3" class="lbl">車牌號碼</a></td>
                        <td><input id="txtLicarno3" type="text" class="txt c1"/></td>
                    </tr>
                    <tr class="tr15">
                        <td><span> </span><a id="lblLitigant4" class="lbl">(四)當事人</a></td>
                        <td><input id="txtLitigant4" type="text" class="txt c1"/></td>
                        <td><span> </span><a id="lblLitel4" class="lbl">電話</a></td>
                        <td><input id="txtLitel4" type="text" class="txt c1"/></td>
                        <td><span> </span><a id="lblLicarno4" class="lbl">車牌號碼</a></td>
                        <td><input id="txtLicarno4" type="text" class="txt c1"/></td>
                    </tr>
				</table>
			</div>
		</div>
		<iframe id="xdownload" style="display:none;"> </iframe>
		<input id="q_sys" type="hidden" />
	</body>
</html>
