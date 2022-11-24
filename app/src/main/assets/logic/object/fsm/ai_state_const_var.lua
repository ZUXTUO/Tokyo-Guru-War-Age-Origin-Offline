

AIEvent = 
{
    NEWPatrolPath = "NEWPatrolPath",
    RESUME = "Resume",
    PAUSE = "Pause",
    UserHasOperatedUI = "UserHasOperatedUI",
    PlayerEnter = "PlayerEnter",
    PlayerLeave = "PlayerLeave",
    PlayerOpen = "PlayerOpen",
    EntityOpenEnd = "EntityOpenEnd",
    PlyaerClose = "PlyaerClose",
    EntityCloseEnd = "EntityCloseEnd",
    CloseAI = "CloseAI",
    EnterFight = "EnterFight",
    EnterEscape = "EnterEscape",
    FastSpeed = "FastSpeed",
    NormalSpeed = "NormalSpeed",
    Dangerous = "Dangerous",
    StandTime = "StandTime",
}



AIStateConstVar = 
{

    followDetectTargetUpdateDist = 1,

    followDetectTargetUpdateAngle = 30,

    followHeroFollowDist = 3,

    followPositionPositiveRotateAngle = 30,
    followPositionPositiveRotateAngleQuat = {},
    followPositionNegativeRotateAngle = -30,
    followPositionNegativeRotateAngleQuat = {},

    followHeroOutOfScreenRange = 8,
    followNeedRotateAngle = math.cos(math.rad(15)),

    findNextMinDistance = 7,

    enterDetectOtherTargetExtraRadius = 1.5,

    aroundRandius = 6,

    hatredValueResetTime = 5,

    dangousCheckRange = 8,
    safeCheckRange = 12,

    -- beAttack后动作延迟参数
    stateDelayMinNumber = 0.1,
    stateDelayMaxNumber = 0.5,
    stateDElayStep = 0.15,

    --走打参数
    attackMoveProbability = 0.5,              --触发概率
    attackMoveAttackProbability = 1,          --移动后攻击概率
    attackMoveToTargetDistance = 2,         --到目标的距离
    attackMoveMaxMoveDistance = 2,          --范围最大距离
    attackMoveCanNotMoveAngle = 45,         --角度1
    attackMoveCanMoveAngle = 45,            --角度2

}
AIStateConstVar.followDetectTargetUpdateAngleCos = math.cos(math.rad(AIStateConstVar.followDetectTargetUpdateAngle))
AIStateConstVar.followDetectTargetUpdateDistSQ = AIStateConstVar.followDetectTargetUpdateDist * AIStateConstVar.followDetectTargetUpdateDist

AIStateConstVar.followPositionPositiveRotateAngleQuat.x,AIStateConstVar.followPositionPositiveRotateAngleQuat.y,AIStateConstVar.followPositionPositiveRotateAngleQuat.z,AIStateConstVar.followPositionPositiveRotateAngleQuat.w = util.quaternion_euler(0, AIStateConstVar.followPositionPositiveRotateAngle, 0);
AIStateConstVar.followPositionNegativeRotateAngleQuat.x,AIStateConstVar.followPositionNegativeRotateAngleQuat.y,AIStateConstVar.followPositionNegativeRotateAngleQuat.z,AIStateConstVar.followPositionNegativeRotateAngleQuat.w = util.quaternion_euler(0, AIStateConstVar.followPositionNegativeRotateAngle, 0);

AIStateConstVar.followHeroInCappainAroundRadius = AIStateConstVar.followHeroFollowDist + 1
AIStateConstVar.followHeroInCappainAroundRadiusSQ = AIStateConstVar.followHeroInCappainAroundRadius *AIStateConstVar.followHeroInCappainAroundRadius
AIStateConstVar.followHeroCheckTargetInCaptainAroundRadiusSQ = (AIStateConstVar.followHeroFollowDist + 2) * ( AIStateConstVar.followHeroFollowDist + 2 )
AIStateConstVar.followHeroOutOfScreenRangeSQ = AIStateConstVar.followHeroOutOfScreenRange * AIStateConstVar.followHeroOutOfScreenRange

AIStateConstVar.dangousCheckRangeSQ = AIStateConstVar.dangousCheckRange * AIStateConstVar.dangousCheckRange
AIStateConstVar.safeCheckRangeSQ = AIStateConstVar.safeCheckRange * AIStateConstVar.safeCheckRange
