
$(document).ready(function () {
    
    $("#ticket").off("close.bs.alert", ".ticket_bet");
    $("#ticket").on("close.bs.alert", ".ticket_bet", function () {
        var strId = $(this).prop("id");
        var oddId = strId.substr(1);
        
        $("#chk" + oddId).prop("checked", false);

        var value = $("#oddselection").prop("value");
        value = value.replace(" " + oddId + " ", "");

        $("#oddselection").prop("value", value);

        var nOdds = parseInt($("#nOdds").text());
        nOdds = nOdds - 1;
        $("#nOdds").text(nOdds);
        var vRisk = $("#risk").prop("value");
        if (vRisk !== null && vRisk !== "") {
            $("#btn_risk").click();
        }
    });

    $("#btn_risk").click(function () {
        var vOddselection = $("#oddselection").prop("value");
        
        var vBet = $("#risk").prop("value");
        var risk = parseFloat(vBet);
        
        if (isNaN(risk) || risk <= 0) {
            $("#risk").prop("value", "");
            $("#profit").prop("value", "");
            return;
        }
        $.post("parlay",
                {do: "getprofit",
                    p25: vOddselection,
                    p26: risk},
        function (data) {
            $("#profit").val(data);
        }
        );
    });

    $("#btn_profit").click(function () {
        var vOddselection = $("#oddselection").prop("value");
        
        var vProfit = $("#profit").prop("value");
        var profit = parseFloat(vProfit);
        
        if (isNaN(profit) || profit < 0) {
            $("#risk").prop("value", "");
            $("#profit").prop("value", "");
            return;
        }
        
        var vMaxProfit = $("#maxProfit").text();
        var maxProfit = parseFloat(vMaxProfit);
        if (profit > maxProfit) {
            profit = maxProfit;
            $("#profit").prop("value", profit);
        }
        $.get("parlay",
                {do: "getrisk",
                    p25: vOddselection,
                    p27: profit},
        function (data) {
            $("#risk").val(data);
        }
        );
    });

    $("#betform").submit(function (event) {
        
        var ok = true;
        var output = "";
        
        var nOdds = parseInt($("#nOdds").text());
        var minOdds = parseInt($("#minOddsLimit").text());
        var maxOdds = parseInt($("#maxOddsLimit").text());
        if (nOdds < minOdds || nOdds > maxOdds) {
            ok = false;
            output += "* Seleccione entre "+minOdds+" y "+maxOdds+" logros.<br/>";
        }
        var vBet = $("#risk").prop("value");
        var risk = parseInt(vBet);
        var name = $("#name").prop("value");
        
        if (risk <= 0) {
            ok = false;
            output += "* El riesgo debe ser positivo: "+risk+"<br/>";
        }
        if (isNaN(risk)) {
            ok = false;
            output += "* Riesgo inválido: "+"NaN"+"<br/>";
        }
        if (name === null || name.length === 0) {
            ok = false;
            output += "* Por favor ingrese su nombre. <br/>";
        }
        if (!ok) {
            $("#infoModalContent").html(output);
            $('#infoModalLocal').modal('show');
            return false;
        }
        return true;
    });
    
    $('.collapse .tournament').off('show.bs.collapse');
    $('.collapse .tournament').on('show.bs.collapse', function () {
        var strId = $(this).prop("id");
        var id = strId.substr(2);
        var loaded = $('#st'+id).text();
        if (loaded === "1") {
            return true;
        }
        $('#st'+id).text("1");
        $.post("client",
                {to: "matches",
                 p38: id},
        function (data) {
            $("#lg"+id).append(data);
        }
        );
    });
});

