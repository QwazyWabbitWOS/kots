delimiter $$ CREATE EVENT ev_updatekings ON SCHEDULE EVERY 1 HOUR STARTS CURRENT_TIMESTAMP ON COMPLETION PRESERVE ENABLE DO BEGIN Call UpdateKings(); UPDATE characters set title=NULL; UPDATE characters c JOIN kings k ON k.character_id=c.id SET c.title=k.title_male; END $$ delimiter ;
and also
SET GLOBAL event_scheduler = ON;
