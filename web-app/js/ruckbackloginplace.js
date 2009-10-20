var ruckBacklogInPlace = function(elementName, href) {
    if (!($(elementName)))
        return;
    href.hide();
    var id = null;
    var splitName = elementName.split("_");
    for (var i = 0; i < splitName.length; i++) {
        if (splitName[i] * 1)
            id = splitName[i];
    }
    var splitText = $(elementName).innerHTML.split("(");
    var points = (splitText[1].split(")")[0]);
    var stories = (splitText[1].split(")")[1]).substring(1);
    var pointsInput = new Element('input', {
        type: 'text',
        name: 'points',
        maxlength: '3',
        size: '3',
        'class': 'ruck-text',
        value: points
    });
    var storyInput = new Element('input', {
        type: 'text',
        name: 'description',
        size: '75',
        'class': 'ruck-text',
        value: stories
    });
    var form = new Element('form', {action: '../changestory/' + id, method: 'post', id: elementName + '_form'}).insert(pointsInput).insert(storyInput);
    var frmUpdate = function() {
        new Ajax.Request($(elementName + '_form').action + "?" + $(elementName + '_form').serialize(), {
            onSuccess: function(transport) {
                $(elementName).update("(" + transport.responseJSON.points + ") " + transport.responseJSON.description);
                href.show();
            },
            onFailure: function() {
                alert("Could not communicate with server!");
                $(elementName).update("(" + points + ") " + stories);
                href.show();
            }
        });
    };
    var submit = new Element('a', {href: '#'}).update("ok");
    submit.onclick = frmUpdate;
    $(elementName).update(form).insert(submit);
};