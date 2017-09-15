$(top.hangge());
$(function() {
    $.fn.serializeObject = function() {
        var o = {};
        var a = this.serializeArray();
        $.each(a, function() {
            if (o[this.name]) {
                if (!o[this.name].push) {
                    o[this.name] = [ o[this.name] ];
                }
                o[this.name].push(this.value || '');
            } else {
                o[this.name] = this.value || '';
            }
        });
        return o;
    };

    $("#machineCode").focus();
    $("#machineCode")[0].oninput =function(){
        $.ajax({
            type: "POST",
            url:scanUrl+ 'scan/findByBarcode.do',
            data: $("#Form").serializeObject(),
            dataType:'json',
            cache: false,
            success: function(data){
                if(data.result == "success"){
                    var machine = data.data;
                    if(null!=machine && ""!=machine){
                        $("#name").val(machine.name);
                        $("#type").val(machine.typeName);
                        $("#code").val(machine.barcode);
                        $("#USERNAME").val(machine.chargeName+';'+machine.Day_Repairman+';'+machine.Night_Repairman)
                    }

                }
            }
        });
    };

});
function ScanRecord(scanType){

}
function machineCodeCheck(model){
    var machineCode = $("#machineCode").val()
    if(null == machineCode || machineCode == ""){
        $("#machineCode").tips({
            side : 1,
            msg : "请扫描机器",
            bg : '#FF5080',
            time : 15
        });
        $("#machineCode").focus();
        return;
    }else{
        $('#'+model).modal({
            keyboard: true
        })
    }

}
function xsbtn(){
    var machineCode = $("#machineCode").val()
    if(null == machineCode || machineCode == ""){
        $("#machineCode").tips({
            side : 1,
            msg : "请扫描机器",
            bg : '#FF5080',
            time : 15
        });
        $("#machineCode").focus();
        return;
    }else{
        $.ajax({
            type: "POST",
            url: scanUrl+'scan/xsScan.do',
            data: $("#Form").serializeObject(),
            dataType:'json',
            cache: false,
            success: function(data){
                if(data.result == "success"){
                    var machine = data.data;


                }
            }
        });
    }

}