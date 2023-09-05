// Define necessary constants
#define MAX_PLAYERS 32
#define MAX_WEAPONS 38
#define MAX_BODY_PARTS 14

// Damage log structure
new Float:DamageLog[MAX_PLAYERS][MAX_WEAPONS][MAX_BODY_PARTS];

// Function to add damage information to the log
stock AddToDamageLog(attacker, victim, weaponid, bodypart, amount)
{
    DamageLog[attacker][weaponid][bodypart] += amount;
    return 1;
}

// Function to display the damage log for a specific player, weapon, and body part
stock ShowDamageLog(playerid, weaponid, bodypart)
{
    new Float:totalDamage = DamageLog[playerid][weaponid][bodypart];
    printf("Player %d damage with weapon %d to body part %d: %f", playerid, weaponid, bodypart, totalDamage);
    return 1;
}

// Function to display the maximum damage for each weapon and body part
stock ShowMaximumDamage()
{
    for (new playerid = 0; playerid < MAX_PLAYERS; playerid++)
    {
        for (new weaponid = 0; weaponid < MAX_WEAPONS; weaponid++)
        {
            for (new bodypart = 0; bodypart < MAX_BODY_PARTS; bodypart++)
            {
                new Float:totalDamage = DamageLog[playerid][weaponid][bodypart];
                if (totalDamage > 0.0)
                {
                    printf("Player %d damage with weapon %d to body part %d: %f", playerid, weaponid, bodypart, totalDamage);
                }
            }
        }
    }
    return 1;
}

// Example use of the damage log system
public OnPlayerGiveDamage(attackerid, victimid, Float:amount, weaponid, bodypart)
{
    // Add damage information to the log
    AddToDamageLog(attackerid, victimid, weaponid, bodypart, amount);
    return 1;
}

// Command to show damage log for a specific weapon and body part
CMD:showweapondamage(playerid, params[])
{
    new weaponid = strval(params);
    new bodypart = GetPlayerHealth(playerid); // Replace with your logic to get the body part
    ShowDamageLog(playerid, weaponid, bodypart);
    return 1;
}

// Command to show maximum damage for all weapons and body parts
CMD:showmaxdamage(playerid, params[])
{
    ShowMaximumDamage();
    return 1;
}
