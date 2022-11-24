
-- 二阶贝塞尔曲线
-- t (0-1)
-- pV3d, aV3d, qV3d 类型为Vector3d类型的点
-- function math.QuadBezierV3d(t, pV3d, aV3d, qV3d)
--     t2 = t * t
--     u = 1 - t
--     u2 = u * u

--     local p1 = pV3d:CScale(u2)
--     local p2 = aV3d:CScale(2 * t * u)
--     local p3 = qV3d:CScale(t2)

--     return p1:RAdd(p2):RAdd(p3)
-- end