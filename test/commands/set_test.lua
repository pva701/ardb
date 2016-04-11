--[[   --]]
ardb.call("del", "myset")
local s = ardb.call("sadd", "myset", "s0", "s0", "s1", "s2")
ardb.assert2(s == 3, s)
s = ardb.call("sadd2", "myset", "s1", "s2", "s3")
ardb.assert2(s["ok"] == "OK", s)
s = ardb.call("scard", "myset")
ardb.assert2(s == 4, s)
ardb.call("del", "myset")
s = ardb.call("sadd2", "myset", "s1", "s2", "s3")
ardb.assert2(s["ok"] == "OK", s)
s = ardb.call("sadd", "myset", "s0", "s0", "s1", "s2")
ardb.assert2(s == 1, s)
local vs = ardb.call("smembers", "myset")
ardb.assert2(vs[1] == "s0", vs)
ardb.assert2(vs[2] == "s1", vs)
ardb.assert2(vs[3] == "s2", vs)
ardb.assert2(vs[4] == "s3", vs)
s = ardb.call("sismember", "myset", "sx")
ardb.assert2(s == 0, s)
s = ardb.call("sismember", "myset", "s0")
ardb.assert2(s == 1, s)
s = ardb.call("srem", "myset", "s1", "s21", "s31")
ardb.assert2(s == 1, s)
s = ardb.call("srem2", "myset", "s2", "s22", "s31")
ardb.assert2(s["ok"] == "OK", s)
vs = ardb.call("smembers", "myset")
ardb.assert2(table.getn(vs) == 2, vs)
ardb.assert2(vs[1] == "s0", vs)
ardb.assert2(vs[2] == "s3", vs)
s = ardb.call("srandmember", "myset")
ardb.assert2(s == "s0", s)
vs = ardb.call("srandmember", "myset", "2")
ardb.assert2(vs[1] == "s0", vs)
ardb.assert2(vs[2] == "s3", vs)
vs = ardb.call("srandmember", "myset", "-2")
ardb.assert2(vs[1] == "s0", vs)
ardb.assert2(vs[2] == "s3", vs)

ardb.call("del", "myset1", "myset2")
vs = ardb.call("srandmember", "myset2", "-2")
ardb.assert2(table.getn(vs) == 0, vs)
s = ardb.call("srandmember", "myset1")
ardb.assert2(s == false, s)
s = ardb.call("spop", "myset1")
ardb.assert2(s == false, s)
ardb.call("sadd2", "myset1", "s0", "s0", "s1", "s2")
ardb.call("sadd2", "myset2", "s2")
s = ardb.call("spop", "myset1")
ardb.assert2(s == "s0", s)
s = ardb.call("smove", "myset1", "myset2", "s2")
ardb.assert2(s == 1, s)
s = ardb.call("smove", "myset1", "myset2", "sx")
ardb.assert2(s == 0, s)
s = ardb.call("smove", "myset1", "myset2", "s1")
ardb.assert2(s == 1, s)

ardb.call("del", "myset1", "myset2", "myset3", "storeset")
ardb.call("sadd2", "myset1", "a", "b", "c", "d")
ardb.call("sadd2", "myset2", "c")
ardb.call("sadd2", "myset3", "a", "c", "e")
vs = ardb.call("sunion", "myset1", "myset2", "myset3")
ardb.assert2(table.getn(vs) == 5, vs)
ardb.assert2(vs[1] == "a", vs)
ardb.assert2(vs[2] == "b", vs)
ardb.assert2(vs[3] == "c", vs)
ardb.assert2(vs[4] == "d", vs)
ardb.assert2(vs[5] == "e", vs)
s = ardb.call("sunioncount", "myset1", "myset2", "myset3")
ardb.assert2(s == 5, vs)
s = ardb.call("sunionstore", "storeset", "myset1", "myset2", "myset3")
ardb.assert2(s == 5, vs)
vs = ardb.call("smembers", "storeset")
ardb.assert2(table.getn(vs) == 5, vs)
ardb.assert2(vs[1] == "a", vs)
ardb.assert2(vs[2] == "b", vs)
ardb.assert2(vs[3] == "c", vs)
ardb.assert2(vs[4] == "d", vs)
ardb.assert2(vs[5] == "e", vs)
vs = ardb.call("sdiff", "myset1", "myset2", "myset3")
ardb.assert2(table.getn(vs) == 2, vs)
ardb.assert2(vs[1] == "b", vs)
ardb.assert2(vs[2] == "d", vs)
s = ardb.call("sdiffcount", "myset1", "myset2", "myset3")
ardb.assert2(s == 2, vs)
s = ardb.call("sdiffstore", "storeset", "myset1", "myset2", "myset3")
ardb.assert2(s == 2, vs)
vs = ardb.call("smembers", "storeset")
ardb.assert2(table.getn(vs) == 2, vs)
ardb.assert2(vs[1] == "b", vs)
ardb.assert2(vs[2] == "d", vs)
vs = ardb.call("sinter", "myset1", "myset2", "myset3")
ardb.assert2(table.getn(vs) == 1, vs)
ardb.assert2(vs[1] == "c", vs)
s = ardb.call("sintercount", "myset1", "myset2", "myset3")
ardb.assert2(s == 1, vs)
s = ardb.call("sinterstore", "storeset", "myset1", "myset2", "myset3")
ardb.assert2(s == 1, vs)
vs = ardb.call("smembers", "storeset")
ardb.assert2(table.getn(vs) == 1, vs)
ardb.assert2(vs[1] == "c", vs)

