#include <time.h>
#include "ScriptPCH.h"
#include "Language.h"
#include "ScriptedGossip.h"
//#include "bot_ai.h"

#define CLASS_GOSSIP_MESSAGE(x) 71000+x
#define HERO_GOSSIP_MESSAGE DEFAULT_GOSSIP_MESSAGE
#define MEMBERSHIP_GOSSIP_MESSAGE DEFAULT_GOSSIP_MESSAGE
#define MEMBERSHIP_VIP_BUY_GOSSIP_MESSAGE 64000

#define GOSSIP_SENDER_MENU_BACK 0

//Main
#define GOSSIP_SENDER_WOWBOOK_CUSTOM GOSSIP_ACTION_INFO_DEF + 1
#define GOSSIP_SENDER_WOWBOOK_HEROS GOSSIP_ACTION_INFO_DEF + 2
#define GOSSIP_SENDER_WOWBOOK_SHOP GOSSIP_ACTION_INFO_DEF + 3
#define GOSSIP_SENDER_WOWBOOK_PROMOTE GOSSIP_ACTION_INFO_DEF + 4
#define GOSSIP_SENDER_WOWBOOK_MEMBERSHIP GOSSIP_ACTION_INFO_DEF + 5

//Membership
#define GOSSIP_SENDER_MEMBERSHIP_TYPE GOSSIP_ACTION_INFO_DEF + 7
#define GOSSIP_SENDER_MEMBERSHIP_POINTS GOSSIP_ACTION_INFO_DEF + 8
#define GOSSIP_SENDER_MEMBERSHIP_VIP_EXPIRE GOSSIP_ACTION_INFO_DEF + 9
#define GOSSIP_SENDER_MEMBERSHIP_BANK GOSSIP_ACTION_INFO_DEF + 10
#define GOSSIP_SENDER_MEMBERSHIP_MAILBOX GOSSIP_ACTION_INFO_DEF + 11
#define GOSSIP_SENDER_MEMBERSHIP_VIP_BUY GOSSIP_ACTION_INFO_DEF + 12
#define GOSSIP_SENDER_MEMBERSHIP_GOLD_BUY GOSSIP_ACTION_INFO_DEF + 13
#define GOSSIP_SENDER_MEMBERSHIP_5000GOLD_BUY GOSSIP_ACTION_INFO_DEF + 14
#define GOSSIP_SENDER_MEMBERSHIP_10000GOLD_BUY GOSSIP_ACTION_INFO_DEF + 15
#define GOSSIP_SENDER_MEMBERSHIP_22000GOLD_BUY GOSSIP_ACTION_INFO_DEF + 16
#define GOSSIP_SENDER_MEMBERSHIP_35000GOLD_BUY GOSSIP_ACTION_INFO_DEF + 17
#define GOSSIP_SENDER_MEMBERSHIP_60000GOLD_BUY GOSSIP_ACTION_INFO_DEF + 18
#define GOSSIP_SENDER_MEMBERSHIP_BUYCONFIRM GOSSIP_ACTION_INFO_DEF + 19

//Heros
#define GOSSIP_SENDER_WOWBOOK_HERO_DETAILS GOSSIP_ACTION_INFO_DEF + 6



class wowbook : public ItemScript
{
	private:
		uint32 currentBotClass;
		uint32 currentBot;
    public:
        wowbook() : ItemScript("wowbook") { }
 		bool OnUse(Player *player, Item *_item, SpellCastTargets const& /*targets*/)
		{
			if (player->IsInCombat())
			{
				CloseGossipMenuFor(player);
				ChatHandler(player->GetSession()).PSendSysMessage(player->GetSession()->GetTrinityString(LANG_YOU_IN_COMBAT));
				return true;
			}
			else
			{
				ClearGossipMenuFor(player);
				AddGossipItemFor(player, GOSSIP_ICON_DOT, player->GetSession()->GetTrinityString(LANG_WOWBOOK_MEMBERSHIP), GOSSIP_SENDER_MAIN, GOSSIP_SENDER_WOWBOOK_MEMBERSHIP);
				AddGossipItemFor(player, GOSSIP_ICON_CHAT, player->GetSession()->GetTrinityString(LANG_WOWBOOK_SHOP), GOSSIP_SENDER_MAIN, GOSSIP_SENDER_WOWBOOK_SHOP);
				AddGossipItemFor(player, GOSSIP_ICON_DOT, player->GetSession()->GetTrinityString(LANG_WOWBOOK_CUSTOMIZE), GOSSIP_SENDER_MAIN, GOSSIP_SENDER_WOWBOOK_CUSTOM);
				AddGossipItemFor(player, GOSSIP_ICON_DOT, player->GetSession()->GetTrinityString(LANG_WOWBOOK_PROMOTE), GOSSIP_SENDER_MAIN, GOSSIP_SENDER_WOWBOOK_PROMOTE);
				//AddGossipItemFor(player, GOSSIP_ICON_CHAT, player->GetSession()->GetTrinityString(LANG_WOWBOOK_RIDER), GOSSIP_SENDER_MAIN, GOSSIP_SENDER_WOWBOOK_RIDER);
				
			}
			SendGossipMenuFor(player, DEFAULT_GOSSIP_MESSAGE, _item->GetGUID());
			return true;
		}

		bool OnGossipSelect(Player *player, Item *_item, uint32 sender, uint32 uiAction)
		{
			if (player->IsInCombat())
			{
				CloseGossipMenuFor(player);
				ChatHandler(player->GetSession()).PSendSysMessage(player->GetSession()->GetTrinityString(LANG_YOU_IN_COMBAT));
				return true;
			}

			if (sender == GOSSIP_SENDER_MAIN)
			{
				ClearGossipMenuFor(player);
				switch(uiAction)
				{
				/*case GOSSIP_SENDER_WOWBOOK_HEROS: //LANG_WOWBOOK_HEROS
					OnListHeroClasses(player, _item);
					break;*/
				case GOSSIP_SENDER_WOWBOOK_SHOP: //LANG_WOWBOOK_HEROS
					OnHandleShop(player, _item);
					break;
				case GOSSIP_SENDER_WOWBOOK_MEMBERSHIP: //LANG_WOWBOOK_QUERY_MEMBERSHIP
					OnHandleMembership(player, _item, sender, uiAction);
					break;
				case GOSSIP_SENDER_WOWBOOK_CUSTOM: //LANG_WOWBOOK_CUSTOMIZE
					OnHandleCustomize(player, _item);
					break;
				case GOSSIP_SENDER_WOWBOOK_PROMOTE: 
					//OnHandleCustomize(player, _item);
					break;
				default:
					break;
				}
			}
			else if (sender == GOSSIP_SENDER_WOWBOOK_HEROS) 
			{
				ClearGossipMenuFor(player);
				OnListHerosForClass(player, _item, uiAction);
			}
			else if (sender == GOSSIP_SENDER_WOWBOOK_MEMBERSHIP)
			{
				OnHandleMembership(player, _item, sender, uiAction);
			}
			else if (sender == GOSSIP_SENDER_WOWBOOK_HERO_DETAILS)
			{
				if (uiAction == GOSSIP_SENDER_MENU_BACK)//back
				{
					OnListHerosForClass(player, _item, currentBotClass);
				}
				else
				{
					CloseGossipMenuFor(player);
					//player->SummonBot(currentBot);
				}
			}
			return true;
		}
		void OnShowHeroDetails(Player* player, Item *_item, uint32 heroId)
		{
			ObjectGuid guildHero = ObjectGuid(HighGuid::Unit, heroId);
			/*if (player->HaveBot(guildHero))
			{
				AddGossipItemFor(player, GOSSIP_ICON_DOT, player->GetSession()->GetTrinityString(LANG_WOWBOOK_SUMMON), GOSSIP_SENDER_WOWBOOK_HERO_DETAILS, heroId);
			}
			currentBot = heroId;
			AddGossipItemFor(player, GOSSIP_ICON_DOT, player->GetSession()->GetTrinityString(LANG_SLOT_NAME_BACK), GOSSIP_SENDER_WOWBOOK_HERO_DETAILS, 0);
			SendGossipMenuFor(player, heroId, _item->GetGUID());*/
		}
		void OnListHerosForClass(Player* player, Item *_item, uint32 uiAction)
		{
			CloseGossipMenuFor(player);
			ClearGossipMenuFor(player);
			/*if (uiAction > BOT_CLASS_NORMAL_END)//show hero details, uiAction is hero id
			{
				OnShowHeroDetails(player, _item, uiAction);
			}
			else
			{
				uint8 botclass = uiAction;
				currentBotClass = botclass;
				uint8 localeIndex = ChatHandler(player->GetSession()).GetSessionDbLocaleIndex();
				CreatureTemplateContainer const* ctc = sObjectMgr->GetCreatureTemplates();
				int idx = 0;
				for (CreatureTemplateContainer::const_iterator itr = ctc->begin(); itr != ctc->end()&&idx<10; ++itr)
				{
					uint32 id = itr->second.Entry;
					std::string name;
					
					if (id < BOT_ENTRY_BEGIN || id > BOT_ENTRY_END) continue;
					uint32 trainer_class = itr->second.trainer_class;
					if (trainer_class != botclass) continue;
					
					if (CreatureLocale const* creatureLocale = sObjectMgr->GetCreatureLocale(id))
					{
						if (creatureLocale->Name.size() > localeIndex && !creatureLocale->Name[localeIndex].empty())
						{
							name = creatureLocale->Name[localeIndex];
						}
					}
					else
						name = itr->second.Name;

					if (name.empty())
						continue;
					++idx;
					AddGossipItemFor(player, GOSSIP_ICON_DOT, name, GOSSIP_SENDER_WOWBOOK_HEROS, id);
				}
			}

			*/
			SendGossipMenuFor(player, CLASS_GOSSIP_MESSAGE(currentBotClass), _item->GetGUID());
		}
		void OnListHeroClasses(Player* player, Item *_item)
		{
			/*CloseGossipMenuFor(player);
			for (int i = BOT_CLASS_NORMAL_START; i <= BOT_CLASS_NORMAL_END; i++)
			{
				if (i == 10)continue;
				AddGossipItemFor(player, GOSSIP_ICON_DOT, player->GetSession()->GetTrinityString(LANG_HEROS_CLASS_BASE+i), GOSSIP_SENDER_WOWBOOK_HEROS, i);
			}
			*/
			SendGossipMenuFor(player, HERO_GOSSIP_MESSAGE, _item->GetGUID());
		}
		
		void OnHandleMembership(Player* player, Item *_item, uint32 sender, uint32 uiAction)
		{
			if (sender == GOSSIP_SENDER_MAIN)
			{
				ClearGossipMenuFor(player);
				CloseGossipMenuFor(player);

				char buf[255];
				sprintf(buf, player->GetSession()->GetTrinityString(LANG_MEMBERSHIP_TYPE),player->GetSession()->GetMembershipType());
				AddGossipItemFor(player, GOSSIP_ICON_DOT, buf, GOSSIP_SENDER_WOWBOOK_MEMBERSHIP, GOSSIP_SENDER_MEMBERSHIP_TYPE);
				if (player->GetSession()->IsPremium())
				{
					sprintf(buf, player->GetSession()->GetTrinityString(LANG_MEMBERSHIP_VIP_EXPIRE), player->GetSession()->GetVIPExpireDate());
					AddGossipItemFor(player, GOSSIP_ICON_DOT, buf, GOSSIP_SENDER_WOWBOOK_MEMBERSHIP, GOSSIP_SENDER_MEMBERSHIP_VIP_EXPIRE);
				}
				sprintf(buf, player->GetSession()->GetTrinityString(LANG_MEMBERSHIP_POINTS), player->GetSession()->GetWowPoint());
				AddGossipItemFor(player, GOSSIP_ICON_DOT, buf, GOSSIP_SENDER_WOWBOOK_MEMBERSHIP, GOSSIP_SENDER_MEMBERSHIP_POINTS);
				AddGossipItemFor(player, GOSSIP_ICON_DOT, player->GetSession()->GetTrinityString(LANG_MEMBERSHIP_BANK), GOSSIP_SENDER_WOWBOOK_MEMBERSHIP, GOSSIP_SENDER_MEMBERSHIP_BANK);
				AddGossipItemFor(player, GOSSIP_ICON_DOT, player->GetSession()->GetTrinityString(LANG_MEMBERSHIP_MAILBOX), GOSSIP_SENDER_WOWBOOK_MEMBERSHIP, GOSSIP_SENDER_MEMBERSHIP_MAILBOX);
				AddGossipItemFor(player, GOSSIP_ICON_DOT, player->GetSession()->GetTrinityString(LANG_MEMBERSHIP_VIP_BUY), GOSSIP_SENDER_WOWBOOK_MEMBERSHIP, GOSSIP_SENDER_MEMBERSHIP_VIP_BUY);
				AddGossipItemFor(player, GOSSIP_ICON_DOT, player->GetSession()->GetTrinityString(LANG_MEMBERSHIP_GOLD_BUY), GOSSIP_SENDER_WOWBOOK_MEMBERSHIP, GOSSIP_SENDER_MEMBERSHIP_GOLD_BUY);
				AddGossipItemFor(player, GOSSIP_ICON_CHAT, player->GetSession()->GetTrinityString(LANG_MENU_NAME_BACK), GOSSIP_SENDER_WOWBOOK_MEMBERSHIP, GOSSIP_SENDER_MENU_BACK);
			}
			else if (sender == GOSSIP_SENDER_WOWBOOK_MEMBERSHIP)
			{
				switch (uiAction)
				{
				case GOSSIP_SENDER_MEMBERSHIP_VIP_BUY:
					ClearGossipMenuFor(player);
					CloseGossipMenuFor(player);
					AddGossipItemFor(player, GOSSIP_ICON_DOT, player->GetSession()->GetTrinityString(LANG_MEMBERSHIP_GOLD_BUY), GOSSIP_SENDER_MEMBERSHIP_VIP_BUY, GOSSIP_SENDER_MEMBERSHIP_BUYCONFIRM);
					AddGossipItemFor(player, GOSSIP_ICON_CHAT, player->GetSession()->GetTrinityString(LANG_MENU_NAME_BACK), GOSSIP_SENDER_MEMBERSHIP_VIP_BUY, GOSSIP_SENDER_MENU_BACK);
					SendGossipMenuFor(player, MEMBERSHIP_VIP_BUY_GOSSIP_MESSAGE, _item->GetGUID());
					break;
				case GOSSIP_SENDER_MEMBERSHIP_GOLD_BUY:
					ClearGossipMenuFor(player);
					CloseGossipMenuFor(player);
					AddGossipItemFor(player, GOSSIP_ICON_DOT, player->GetSession()->GetTrinityString(LANG_MEMBERSHIP_5000GOLD_BUY), GOSSIP_SENDER_MEMBERSHIP_GOLD_BUY, GOSSIP_SENDER_MEMBERSHIP_5000GOLD_BUY);
					AddGossipItemFor(player, GOSSIP_ICON_DOT, player->GetSession()->GetTrinityString(LANG_MEMBERSHIP_5000GOLD_BUY), GOSSIP_SENDER_MEMBERSHIP_GOLD_BUY, GOSSIP_SENDER_MEMBERSHIP_10000GOLD_BUY);
					AddGossipItemFor(player, GOSSIP_ICON_DOT, player->GetSession()->GetTrinityString(LANG_MEMBERSHIP_5000GOLD_BUY), GOSSIP_SENDER_MEMBERSHIP_GOLD_BUY, GOSSIP_SENDER_MEMBERSHIP_22000GOLD_BUY);
					AddGossipItemFor(player, GOSSIP_ICON_DOT, player->GetSession()->GetTrinityString(LANG_MEMBERSHIP_5000GOLD_BUY), GOSSIP_SENDER_MEMBERSHIP_GOLD_BUY, GOSSIP_SENDER_MEMBERSHIP_35000GOLD_BUY);
					AddGossipItemFor(player, GOSSIP_ICON_DOT, player->GetSession()->GetTrinityString(LANG_MEMBERSHIP_5000GOLD_BUY), GOSSIP_SENDER_MEMBERSHIP_GOLD_BUY, GOSSIP_SENDER_MEMBERSHIP_60000GOLD_BUY);
					AddGossipItemFor(player, GOSSIP_ICON_CHAT, player->GetSession()->GetTrinityString(LANG_MENU_NAME_BACK), GOSSIP_SENDER_MEMBERSHIP_GOLD_BUY, GOSSIP_SENDER_MENU_BACK);
					SendGossipMenuFor(player, MEMBERSHIP_GOSSIP_MESSAGE, _item->GetGUID());
					break;
				case GOSSIP_SENDER_MEMBERSHIP_BANK:
					if (player->GetSession()->IsPremium() && sWorld->getBoolConfig(COMMAND_MAIL_PREMIUM))
					{
						//Different Checks
						if (player->IsInCombat() || player->IsInFlight() || player->GetMap()->IsBattlegroundOrArena() || player->HasStealthAura() || player->HasFlag(UNIT_FIELD_FLAGS_2, UNIT_FLAG2_FEIGN_DEATH) || player->isDead())
						{
							ChatHandler(player->GetSession()).SendSysMessage(LANG_PREMIUM_CANT_DO);
							ChatHandler(player->GetSession()).SetSentErrorMessage(true);
						}

						player->GetSession()->SendShowBank(player->GetGUID());
					}
					break;
				case GOSSIP_SENDER_MEMBERSHIP_MAILBOX:
					if (player->GetSession()->IsPremium() && sWorld->getBoolConfig(COMMAND_MAIL_PREMIUM))
					{
						//Different Checks
						if (player->IsInCombat() || player->IsInFlight() || player->GetMap()->IsBattlegroundOrArena() || player->HasStealthAura() || player->HasFlag(UNIT_FIELD_FLAGS_2, UNIT_FLAG2_FEIGN_DEATH) || player->isDead())
						{
							ChatHandler(player->GetSession()).SendSysMessage(LANG_PREMIUM_CANT_DO);
							ChatHandler(player->GetSession()).SetSentErrorMessage(true);
						}

						player->GetSession()->SendShowMailBox(player->GetGUID());
					}
					break;
				default:
					break;
				}
			}
			else if (sender == GOSSIP_SENDER_MEMBERSHIP_GOLD_BUY)
			{
				CloseGossipMenuFor(player);
				switch (uiAction)
				{
					case LANG_MEMBERSHIP_5000GOLD_BUY:
						player->GetSession()->BuyGold(5000);
						break;
					case LANG_MEMBERSHIP_10000GOLD_BUY:
						player->GetSession()->BuyGold(10000);
						break;
					case LANG_MEMBERSHIP_22000GOLD_BUY:
						player->GetSession()->BuyGold(22000);
						break;
					case LANG_MEMBERSHIP_35000GOLD_BUY:
						player->GetSession()->BuyGold(35000);
						break;
					case LANG_MEMBERSHIP_60000GOLD_BUY:
						player->GetSession()->BuyGold(60000);
						break;
				}
			}
			else if (sender == GOSSIP_SENDER_MEMBERSHIP_VIP_BUY)
			{
				CloseGossipMenuFor(player);
				if (uiAction == GOSSIP_SENDER_MEMBERSHIP_BUYCONFIRM)
				{
					if (player->GetSession()->GetWowPoint() < 20)
					{
							//not enough DPs
							ChatHandler(player->GetSession()).PSendSysMessage(player->GetSession()->GetTrinityString(LANG_MEMBERSHIP_NOT_ENOUGH_DP));
					}
					else
					{
						if (player->GetSession()->BuyVip())
						{
							ChatHandler(player->GetSession()).PSendSysMessage(player->GetSession()->GetTrinityString(LANG_MEMBERSHIP_BUY_SUCCESS));
						}
						else
						{
							ChatHandler(player->GetSession()).PSendSysMessage(player->GetSession()->GetTrinityString(LANG_MEMBERSHIP_BUY_FAIL));
						}
					}
				}
			}
		}

		void OnHandleShop(Player* player, Item *_item)
		{

		}

		void OnHandleCustomize(Player* player, Item *_item)
		{

		}
};



void AddSC_wowbook()
{
    new wowbook();
}