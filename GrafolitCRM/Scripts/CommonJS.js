function isNumberKey_int(evt) {
    var charCode = (evt.which) ? evt.which : event.keyCode;
    if (charCode > 31 && (charCode < 48 || charCode > 57))
        return false;

    return true;
}

function isNumberKey_decimal(evt) {
    var charCode = (evt.which) ? evt.which : event.keyCode;
    if (charCode != 44 && charCode != 46 && charCode > 31
      && (charCode < 48 || charCode > 57))
        return false;

    return true;
}



ShowErrorPopUp = function (message, popup, title) {
    
    if(title === undefined || title == "") title = "Opozorilo";

    $('body').append('<div class="toggler popUpWrap"><div id="effect" class="ui-widget-content ui-corner-all popUpElement">' +
        '<h3 class="ui-widget-header ui-corner-all titleCenterAlign">' + title + '</h3>' +
    '<p>' +
      message +
    '</p>' +
  '<button type="button" id="btnClosePopUp">Zapri</button></div>' +
'</div>');

    if (popup === 1) {
        $("#effect").addClass("popUpElementWidth");
    }
    else {
        $("#effect").removeClass("popUpElementWidth");
    }

    //$("#effect").toggle('slow', 'swing');

    $("#btnClosePopUp").click(function () {
        //$("#effect").hide('blind', 'fast');
        //$(".toggler").hide('fade', 'slow');
        $(".toggler").remove();
    });
};

ShowSuccessPopUp = function (message, popup, title) {
    if (title == "") title = 'Bravo!';
    $('body').append('<div class="successToggler popUpWrap"><div id="effect" class="ui-widget-content ui-corner-all popUpElement">' +
        '<h3 class="ui-widget-header ui-corner-all titleCenterAlign">' + title + '</h3>' +
    '<p class="messagePopUp">' +
      message +
    '</p>' +
  '<button type="button" class="closeButton" id="btnCloseSuccessPopUp">Zapri</button></div>' +
'</div>');

    if (popup === 1) {
        $("#effect").addClass("popUpElementWidth");
    }
    else {
        $("#effect").removeClass("popUpElementWidth");
    }

    //$("#effect").toggle('slow', 'swing');

    $("#btnCloseSuccessPopUp").click(function () {
        //$("#effect").hide('blind', 'fast');
        //$(".toggler").hide('fade', 'slow');
        $(".successToggler").remove();
    });
};

function callback() {
    setTimeout(function () {
        $("#effect").removeAttr("style").hide().fadeIn();
    }, 1000);
};

HandleUserActionsOnTabs = function (gridView, btnAdd, btnEdit, btnDelete, objSender) {
    var elementName = objSender.name.substring(objSender.name.lastIndexOf('_') + 1, objSender.name.length);
    var parameter = "";

    switch (elementName) {
        case gridView.name.substring(gridView.name.lastIndexOf('_') + 1, gridView.name.length):
            parameter = "2";//row double click Edit
            break;
        case btnAdd.name.substring(btnAdd.name.lastIndexOf('_') + 1, btnAdd.name.length):
            parameter = "1";//Add
            break;
        case btnEdit.name.substring(btnEdit.name.lastIndexOf('_') + 1, btnEdit.name.length):
            parameter = "2";//Edit
            break;
        case btnDelete.name.substring(btnDelete.name.lastIndexOf('_') + 1, btnDelete.name.length):
            parameter = "3";//Delete
            break;
    }

    return parameter;

};


ShowTest = function () {
    alert("lalal");
};

CheckForSpecialCharacters = function (code) {
    for (var i = 0; i < code.length; i++) {
        if (code[i] >= 65 && code[i] <= 90) {
            continue;
        }
        else if (code.charCodeAt(i) == 352)//Š
            code = code.substr(0, i) + 'S' + code.substr(i + 1);
        else if (code.charCodeAt(i) == 268)//Č
            code = code.substr(0, i) + 'C' + code.substr(i + 1);
        else if (code.charCodeAt(i) == 381)//Ž
            code = code.substr(0, i) + 'Z' + code.substr(i + 1);
        else if (code.charCodeAt(i) == 262)//Ć
            code = code.substr(0, i) + 'C' + code.substr(i + 1);
    }
    return code;
};

/*Spinner Loader*/
ShowSpinnerLoader = function () {
    $('body').append('<div class="toggler popUpWrap"><button type="button" id="btnClosePopUp">Close</button></div><div id="effect" class="loader">' + '</div>');

    /*if (popup === 1) {
        $("#effect").addClass("popUpElementWidth");
    }
    else {
        $("#effect").removeClass("popUpElementWidth");
    }

    $("#effect").effect('bounce', 'slow');*/

    $("#btnClosePopUp").click(function () {
        $(".loader").hide('blind', 'fast');
        $(".toggler").hide('fade', 'slow');
    });
};

HideSpinnerLoader = function () {
    $(".loader").hide('blind', 'fast');
    $(".toggler").hide('fade', 'slow');
};

HamburgerMenu = function (show) {
    
    var effect = 'slide';
    var options = { direction: 'left' };
    var duration = 250;

    if (show) {
        $('.hamburger-wrap-close').removeClass('initial-hide-block');
        $('.hamburger-wrap').addClass('initial-hide-block');
        $('.main-menu-section').toggle(effect, options, duration);
    }
    else {
        $('.hamburger-wrap-close').addClass('initial-hide-block');
        $('.hamburger-wrap').removeClass('initial-hide-block');

        $('.main-menu-section').toggle(effect, options, duration, function () {
            $('.main-menu-section').css('display', '');
        });
    }
};

HamburgerMenuCloseOutsideClick = function (eventArg, container, hamburgerMenuBtn, closeMenuBtn) {

    if (hamburgerMenuBtn.is(':visible') || closeMenuBtn.is(':visible')) {
        // if the target of the click isn't the container nor a descendant of the container
        if ((!container.is(eventArg.target) && container.has(eventArg.target).length === 0) &&
            (!closeMenuBtn.is(eventArg.target) && closeMenuBtn.has(eventArg.target).length === 0)) {
            container.hide(400, function () {
                $('.main-menu-section').css('display', '');
            });
            $('.hamburger-wrap-close').addClass('initial-hide-block');
            $('.hamburger-wrap').removeClass('initial-hide-block');
        }
    }
};

ShowRemoveDropdownOutsideClick = function (eventArg, container, hamburgerMenuBtn, closeMenuBtn) {

    if (hamburgerMenuBtn.is(':visible')) {
        // if the target of the click isn't the container nor a descendant of the container
        if ((!container.is(eventArg.target) && container.has(eventArg.target).length === 0)) {
            $('#myDropDown').removeClass('show');
        }
    }
};

SetFocus = function (s, e) {
    try {
        var sender = s;
        sender.Focus();
    }
    catch (err)
    { }
};

InputFieldsValidation = function (gridLookupItems, inputFields, dateFields, memoFields) {
    var procees = true;
    
    if (gridLookupItems != null) {
        for (var i = 0; i < gridLookupItems.length; i++) {

            var item = gridLookupItems[i];
            if (item.GetValue() == null || item.GetValue() == "Izberi... ") {
                $(item.GetInputElement()).parent().parent().addClass("focus-text-box-input-error");
                procees = false;
            }
        }
    }

    if (inputFields != null) {
        for (var i = 0; i < inputFields.length; i++) {

            var item = inputFields[i];
            if (item.GetText() == "") {
                $(item.GetInputElement()).parent().parent().parent().addClass("focus-text-box-input-error");
                procees = false;
            }
        }
    }

    if (dateFields != null) {
        for (var i = 0; i < dateFields.length; i++) {

            var item = dateFields[i];
            if (item.GetValue() == null) {
                $(item.GetInputElement()).parent().parent().addClass("focus-text-box-input-error");
                procees = false;
            }
        }
    }

    if (memoFields != null) {
        for (var i = 0; i < memoFields.length; i++) {

            var item = memoFields[i];
            if (item.GetText() == "") {
                $(item.GetInputElement()).parent().addClass("focus-text-box-input-error");
                procees = false;
            }
        }
    }

    return procees;
};

getCookie = function (cname) {
    var name = cname + "=";
    var decodedCookie = decodeURIComponent(document.cookie);
    var ca = decodedCookie.split(';');
    for (var i = 0; i < ca.length; i++) {
        var c = ca[i];
        while (c.charAt(0) == ' ') {
            c = c.substring(1);
        }
        if (c.indexOf(name) == 0) {
            return c.substring(name.length, c.length);
        }
    }
    return "";
};

EndCallbackValidation = function (s,e) {
    var value = s.cpCallbackError;

    if (value != null)
    {
        ShowErrorPopUp(value);
    }
}
