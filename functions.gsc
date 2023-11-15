spawnentity(class, model, origin, angle)
{
	entity = spawn(class, origin);
	entity.angles = angle;
	entity setmodel(model);
	return entity;
}

createobject(model, origin, angle)
{
	return spawnentity("script_model", model, origin, angle);
}

removeskybarriers()
{
	foreach(barrier in getentarray("trigger_hurt", "classname"))
	{
		if (barrier.origin[2] > 180)
		{
			barrier.origin = barrier.origin + (0, 0, 9999999);
		}
	}
}

removedeathbarriers()
{
	foreach(barrier in getentarray("trigger_hurt", "classname"))
	{
		barrier.origin = barrier.origin + (0, 0, 9999999);
	}
	level.deathbarriers = 1;
}

removemodelentities()
{
	foreach(scriptmodel in getentarray("script_model", "classname"))
	{
		scriptmodel delete();
	}
	self iprintln("Removed Model Entities");
}

removebrushentities()
{
	foreach(scriptbrushmodel in getentarray("script_brushmodel", "classname"))
	{
		scriptbrushmodel delete();
	}
	self iprintln("Removed Brush Entities");
}

movebrush(scriptbrushmodelnumber, origin, angles)
{
	level.mapscriptbrushmodels[scriptbrushmodelnumber].origin = origin;
	level.mapscriptbrushmodels[scriptbrushmodelnumber].angles = angles;
}

deletemodel(scriptmodelnumber)
{
	level.mapmodels[scriptmodelnumber] delete();
}

deletebrush(scriptbrushmodelnumber)
{
	level.mapscriptbrushmodels[scriptbrushmodelnumber] delete();
}

movemodel(scriptmodelnumber, origin, angles)
{
	level.mapmodels[scriptmodelnumber].origin = origin;
	level.mapmodels[scriptmodelnumber].angles = angles;
	level.mapmodels[scriptmodelnumber].pickup = 0;
}

MapNuketown2035()
{
    self iprintln("^7Custom map : ^1Nuketown 2035");
	wait 1;
	self iprintln("^2Custom map loaded");
	self iprintln("^5Created by ^1AimMisaki");
	typewritter("Welcome to ^1Nuketown 2035");
	if (getdvar("mapname") == "mp_nuketown_2020")
	{
		level thread removeskybarriers();
	}
	level thread removemodelentities();
	level thread removebrushentities();
	createobject( "mlv/nt_tree_ficus_lrg_01", ( -799.759, 1069.54, -191.875 ), ( 0, -17.0928, 0 ) );
    createobject( "mlv/nt_tree_ficus_lrg_01", ( -638.33, 995.204, -191.875 ), ( 0, -18.5045, 0 ) );
	createobject( "mlv/nt_tree_ficus_lrg_01", ( -722.911, 1036.03, -191.875 ), ( 0, -18.5539, 0 ) );
	createobject( "mlv/nt_tree_ficus_lrg_01", ( -588.808, 1046.61, -191.875 ), ( 0, -42.3017, 0 ) );
	createobject( "mlv/nt_tree_ficus_lrg_01", ( -1052.53, 1070.07, -191.875 ), ( 0, -19.7962, 0 ) );
	createobject( "mlv/nt_tree_ficus_lrg_01", ( -1150.68, 1100.13, -191.875 ), ( 0, -25.4376, 0 ) );
	createobject( "mlv/nt_tree_ficus_lrg_01", ( -1464.41, 1193.1, -191.875 ), ( 0, -17.7199, 0 ) );
	createobject( "mlv/nt_tree_ficus_lrg_01", ( 704.422, 1011.89, -191.875 ), ( 0, 15.8386, 0 ) );
	createobject( "mlv/nt_tree_ficus_lrg_01", ( 830.997, 1043.46, -191.875 ), ( 0, 12.1032, 0 ) );
	createobject( "mlv/nt_tree_ficus_lrg_01", ( 920.337, 1061.66, -191.875 ), ( 0, 11.8615, 0 ) );
	createobject( "mlv/nt_tree_ficus_lrg_01", ( 1020.54, 1096.42, -191.875 ), ( 0, 15.52, 0 ) );
	createobject( "mlv/nt_tree_ficus_lrg_01", ( 1234.68, 1133.13, -191.875 ), ( 0, 11.3836, 0 ) );
	createobject( "mlv/nt_tree_ficus_lrg_01", ( 1295.01, 1153.71, -191.875 ), ( 0, 14.8498, 0 ) );
	createobject( "mlv/nt_tree_ficus_lrg_01", ( 1408.74, 1176.82, -191.875 ), ( 0, 13.2898, 0 ) );
	createobject( "mlv/nt_tree_ficus_lrg_01", ( 1549.3, 1221.02, -191.875 ), ( 0, 16.1517, 0 ) );
	createobject( "mlv/nt_tree_ficus_lrg_01", ( 1620.84, 1244.62, -191.875 ), ( 0, 12.9107, 0 ) );
	createobject( "mlv/nt_tree_ficus_lrg_01", ( 1655.15, 1173.41, -191.875 ), ( 0, -75.9804, 0 ) );
	createobject( "mlv/nt_tree_ficus_lrg_01", ( 1681.56, 1091.91, -191.875 ), ( 0, -76.0463, 0 ) );
	createobject( "mlv/nt_tree_ficus_lrg_01", ( 1705.45, 1011.56, -191.875 ), ( 0, -77.2328, 0 ) );
	createobject( "mlv/nt_tree_ficus_lrg_01", ( 1738.73, 900.718, -191.875 ), ( 0, -73.08, 0 ) );
	createobject( "mlv/nt_tree_ficus_lrg_01", ( 11785.94, 814.578, -191.875 ), ( 0, -76.2935, 0 ) );
	createobject( "mlv/nt_tree_ficus_lrg_01", ( 1800.25, 745.216, -191.875 ), ( 0, -68.2295, 0 ) );
	createobject( "mlv/nt_tree_ficus_lrg_01", ( 1973.37, 701.557, -191.875 ), ( 0, -68.8061, 0 ) );
	createobject( "mlv/nt_tree_ficus_lrg_01", ( 2008.17, 605.12, -191.875 ), ( 0, -73.9419, 0 ) );
	createobject( "mlv/nt_tree_ficus_lrg_01", ( 2041.82, 512.749, -191.875 ), ( 0, -73.085, 0 ) );
	createobject( "mlv/nt_tree_ficus_lrg_01", ( 2082.63, 370.121, -191.875 ), ( 0, -60.7034, 0 ) );
	createobject( "mlv/nt_tree_ficus_lrg_01", ( 2121.75, 240.541, -191.875 ), ( 0, -73.909, 0 ) );
	createobject( "mlv/nt_tree_ficus_lrg_01", ( 2163.07, 151.624, -191.875 ), ( 0, -167.062, 0 ) );
	createobject( "mlv/nt_tree_ficus_lrg_01", ( 2048.92, 105.827, -191.875 ), ( 0, -163.53, 0 ) );
	createobject( "mlv/nt_tree_ficus_lrg_01", ( 1916.66, 66.8136, -191.875 ), ( 0, -149.555, 0 ) );
	createobject( "mlv/nt_tree_ficus_lrg_01", ( 1739.78, 24.4162, -191.875 ), ( 0, -166.557, 0 ) );
	createobject( "mlv/nt_tree_ficus_lrg_01", ( 1640.74, 4.72034, -191.875 ), ( 0, -168.408, 0 ) );
	createobject( "mlv/nt_tree_ficus_lrg_01", ( 1541.62, -74.9576, -191.875 ), ( 0, -144.056, 0 ) );
	createobject( "mlv/nt_tree_ficus_lrg_01", ( 1393.34, -112.486, -191.875 ), ( 0, -156.526, 0 ) );
	createobject( "mlv/nt_tree_ficus_lrg_01", ( 1300.17, -135.688, -191.875 ), ( 0, -163.469, 0 ) );
	createobject( "mlv/nt_tree_ficus_lrg_01", ( 1161.05, -170.244, -191.875 ), ( 0, -167.144, 0 ) );
	createobject( "mlv/nt_tree_ficus_lrg_01", ( 1008.09, -223.24, -191.875 ), ( 0, -166.304, 0 ) );
	createobject( "mlv/nt_tree_ficus_lrg_01", ( 900.856, -255.103, -191.875 ), ( 0, -168.111, 0 ) );
	createobject( "mlv/nt_tree_ficus_lrg_01", ( 777.1, -282.35, -191.875 ), ( 0, -138.965, 0 ) );
	createobject( "mlv/nt_tree_ficus_lrg_01", ( 662.279, -332.203, -191.875 ), ( 0, -125.247, 0 ) );
	createobject( "mlv/nt_tree_ficus_lrg_01", ( 484.472, -203.482, -191.875 ), ( 0, -162.151, 0 ) );
	createobject( "mlv/nt_tree_ficus_lrg_01", ( 421.042, -258.441, -191.875 ), ( 0, -168.237, 0 ) );
	createobject( "mlv/nt_tree_ficus_lrg_01", ( 405.385, -293.128, -191.875 ), ( 0, -98.2982, 0 ) );
	createobject( "mlv/nt_tree_ficus_lrg_01", ( 414.766, -357.411, -191.875 ), ( 0, -76.82, 0 ) );
	createobject( "mlv/nt_tree_ficus_lrg_01", ( 416.497, -474.478, -191.875 ), ( 0, -54.0014, 0 ) );
	createobject( "mlv/nt_tree_ficus_lrg_01", ( 416.546, -556.735, -191.875 ), ( 0, -80.1653, 0 ) );
	createobject( "mlv/nt_tree_ficus_lrg_01", ( -538.54, -246.403, -191.875 ), ( 0, -14.544, 0 ) );
	createobject( "mlv/nt_tree_ficus_lrg_01", ( -1724.86, -45.2015, -191.875 ), ( 0, 149.52, 0 ) );
	createobject( "mlv/nt_tree_ficus_lrg_01", ( -1832.11, -26.2697, -191.875 ), ( 0, 148.745, 0 ) );
	createobject( "mlv/nt_tree_ficus_lrg_01", ( -1977.22, -52.6377, -191.875 ), ( 0, 150.943, 0 ) );
	createobject( "mlv/nt_tree_ficus_lrg_01", ( -2144.61, 147.413, -191.875 ), ( 0, 155.672, 0 ) );
	createobject( "mlv/nt_tree_ficus_lrg_01", ( -2184.7, -220.426, -134.347 ), ( 0, 136.211, 0 ) );
	createobject( "mlv/nt_tree_ficus_lrg_01", ( -2171.18, 268.62, -127.145 ), ( 0, 70.7048, 0 ) );
	createobject( "mlv/nt_tree_ficus_lrg_01", ( -2136.87, 362.287, -126.863 ), ( 0, 72.7648, 0 ) );
	createobject( "mlv/nt_tree_ficus_lrg_01", ( -2111.4, 437.987, -123.284 ), ( 0, 68.6997, 0 ) );
	createobject( "mlv/nt_tree_ficus_lrg_01", ( -2091.58, 494.61, -124.251 ), ( 0, 73.9139, 0 ) );
	createobject( "mlv/nt_tree_ficus_lrg_01", ( -2064.61, 569.878, -121.733 ), ( 0, 68.2547, 0 ) );
	createobject( "mlv/nt_tree_ficus_lrg_01", ( -2032.4, 664.5, -124.323 ), ( 0, -106.889, 0 ) );
	createobject( "mlv/nt_tree_ficus_lrg_01", ( -1964.38, 781.602, -61.375 ), ( 0, 63.4154, 0 ) );
	createobject( "mlv/nt_tree_ficus_lrg_01", ( 1941.38, 821.175, -61.375 ), ( 0, 92.0788, 0 ) );
	createobject( "mlv/nt_tree_ficus_lrg_01", ( -1918.71, 906.026, -61.375 ), ( 0, 65.1293, 0 ) );
	createobject( "mlv/nt_tree_ficus_lrg_01", ( -770.096, -348.359, -191.875 ), ( 0, 157.985, 0 ) );
	createobject( "mlv/nt_tree_ficus_lrg_01", ( -893.267, -305.795, -191.875 ), ( 0, 171.783, 0 ) );
	createobject( "mlv/nt_tree_ficus_lrg_01", ( -1011.23, -270.63, -191.875 ), ( 0, 151.421, 0 ) );
	createobject( "mlv/nt_tree_ficus_lrg_01", ( -1096.75, -244.177, -191.875 ), ( 0, 149.24, 0 ) );
	createobject( "mlv/nt_tree_ficus_lrg_01", ( -1211.2, -231.428, -191.875 ), ( 0, 148.734, 0 ) );
	createobject( "mlv/nt_tree_ficus_lrg_01", ( -1316.06, -210.015, -191.875 ), ( 0, 148.635, 0 ) );
	createobject( "mlv/nt_tree_ficus_lrg_01", ( -1373.4, -131.443, -191.875 ), ( 0, 153.914, 0 ) );
	createobject( "mlv/nt_tree_ficus_lrg_01", ( -1724.86, -45.2015, -191.875 ), ( 0, 153.914, 0 ) );
	createobject( "mlv/nt_tree_ficus_lrg_01", ( -1892.16, 978.97, -61.375 ), ( 0, 69.5513, 0 ) );
	createobject( "mlv/nt_tree_ficus_lrg_01", ( -1855.64, 1078.93, -61.375 ), ( 0, 69.826, 0 ) );
	createobject( "mlv/nt_tree_ficus_lrg_01", ( -1821.65, 1172.69, -61.375 ), ( 0, 69.815, 0 ) );
	createobject( "mlv/nt_tree_ficus_lrg_01", ( -1790.28, 1258.89, -61.375 ), ( 0, 71.2981, 0 ) );
	createobject( "mlv/nt_tree_ficus_lrg_01", ( -374.027, -288.675, -191.875 ), ( 0, -72.7993, 0 ) );
	createobject( "mlv/nt_tree_ficus_lrg_01", ( -353.045, -324.868, -191.875 ), ( 0, -72.7993, 0 ) );
	createobject( "mlv/nt_tree_ficus_lrg_01", ( -331.352, -366.077, -191.875 ), ( 0, -72.7993, 0 ) );
	createobject( "mlv/nt_tree_ficus_lrg_01", ( -306.87, -417.619, -191.875 ), ( 0, -72.7993, 0 ) );
	createobject( "mlv/nt_tree_ficus_lrg_01", ( -300.325, -488.621, -191.875 ), ( 0, -72.7993, 0 ) );
	createobject( "mlv/nt_tree_ficus_lrg_01", ( -345.033, -558.079, -191.875 ), ( 0, -72.7993, 0 ) );
	createobject( "mlv/nt_tree_ficus_lrg_01", ( -388.778, -621.122, -191.875 ), ( 0, -72.7993, 0 ) );
	createobject( "mlv/nt_tree_ficus_lrg_01", ( -338.766, -681.826, -191.875 ), ( 0, -72.7993, 0 ) );
	createobject( "mlv/nt_tree_ficus_lrg_01", ( -334.352, -742.348, -191.875 ), ( 0, -72.7993, 0 ) );
	createobject( "mlv/nt_tree_ficus_lrg_01", ( -336.299, -795.491, -191.875 ), ( 0, -72.7993, 0 ) );
	createobject( "p_rus_mountain_desert_b", ( 73.5069, -3363.98, -99.1283 ), ( 0, 1.58764, 0 ) );
	createobject( "c_usa_mp_seal6_sniper_fb", ( -742.871, 369.855, 79.125 ), ( 0, 160.704, 0 ) );
	createobject( "c_usa_mp_seal6_sniper_fb", ( -1016.62, 607.554, 78.287 ), ( 0, -20.1807, 0 ) );
	createobject( "c_usa_mp_seal6_sniper_fb", ( 592.897, 117.443, -54.6251 ), ( 0, 16.1243, 0 ) );
	createobject( "c_usa_mp_seal6_sniper_fb", ( 1127.87, 300.834, 79.125 ), ( 0, 15.1843, 0 ) );
	createobject( "collision_clip_wall_128x128x10", ( -742.566, 372.945, 79.125 ), ( 0, 69.6161, 0 ) );
	createobject( "collision_clip_wall_128x128x10", ( -1013.04, 609.458, 78.6023 ), ( 0, -108.412, 0 ) );
	createobject( "collision_clip_wall_128x128x10", ( 594.553, 120.261, -54.9442 ), ( 0, -72.9206, 0 ) );
	createobject( "collision_clip_wall_128x128x10", ( 1130.69, 308.059, 79.125 ), ( 0, -74.206, 0 ) );
	createobject( "nt_2020_robot_01", ( 1026.66, 222.601, 79.125 ), ( 0, 104.503, 0 ) );
	createobject( "nt_2020_robot_01", ( 982.545, 214.176, 79.125 ), ( 0, 103.042, 0 ) );
	createobject( "nt_2020_robot_01", ( 940.545, 203.306, 79.125 ), ( 0, 102.136, 0 ) );
	createobject( "nt_2020_robot_01", ( 901.599, 193.076, 79.125 ), ( 0, 105.843, 0 ) );
	createobject( "nt_2020_robot_01", ( 870.99, 306.645, 79.125 ), ( 0, -74.367, 0 ) );
	createobject( "nt_2020_robot_01", ( 908.185, 321.546, 79.125 ), ( 0, -73.5633, 0 ) );
	createobject( "nt_2020_robot_01", ( 959.911, 333.828, 79.125 ), ( 0, -74.3817, 0 ) );
	createobject( "nt_2020_robot_01", ( 1002, 345.464, 79.125 ), ( 0, -74.2444, 0 ) );
	createobject( "mlv/nt_2020_robot_shed", ( 506.996, 996.813, -62.7247 ), ( 0, -120.922, 0 ) );
	createobject( "collision_clip_wall_128x128x10", ( -742.659, 194.963, -56.875 ), ( 0, -107.747, 0 ) );
	createobject( "mp_nuketown_2020_light_post", ( -732.462, 245.325, -56.875 ), ( 0, -19.0051, 0 ) );
	createobject( "mp_nuketown_2020_light_post", ( -743.51, 201.266, -56.875 ), ( 0, -20.1697, 0 ) );
	createobject( "mp_nuketown_2020_light_post", ( -764.452, 152.684, -56.875 ), ( 0, -20.0763, 0 ) );
	createobject( "collision_clip_wall_128x128x10", ( 989.926, 694.712, 56.875 ), ( 0, 107.008, 0 ) );
}




