function flag = Gason_ifBelongPerson(joints,person)
    xlt = person.x;
    ylt = person.y;
    xrb = person.x + person.width;
    yrb = person.y + person.height;
    if joints.x >=xlt && joints.x <= xrb && joints.y >= ylt && joints.y <= yrb
        flag = true;
    else
        flag = false;
    end
end