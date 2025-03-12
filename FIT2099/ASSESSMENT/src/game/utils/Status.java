package game.utils;

/**
 * Use this enum class to give `buff` or `debuff`.
 *
 * @author Riordan D. Alfredo
 * Modified by: Foo Kai Yan, Ng Yu Mei, Chew Xin Ning
 */
public enum Status {
    HOSTILE_TO_ENEMY,
    RESPAWNABLE,        // Enemy that can respawn from the ground
    RESTING,            // Player, actor who can rest at lost of the grace site
    REVIVABLE,          // Enemy that can be revived
    RESETTABLE,         // Things that can be reset during game reset
    BONEPILES,          // The unique ability for Skeletal Enemy to revive
    HAS_UNIQUE_SKILL,   // for weapons that has unique skill
    ENEMY_SPECIAL_SKILL,// enemy that has special skill
    PLAYER_DROP_ITEM,   // item that can dropped by player when the player die
    CANNOT_BE_SOLD,     // Item or Weapons that cannot be sold
    TRADABLE            // Item or Weapons that cen be traded
}
