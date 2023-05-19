module matrix_mutiply1(
	input [14499:0] image,		// 30*10*50
	input [29999:0] weight,		// 30*50*20
	input [599:0] Bias,			// 30*20
	output reg [5999:0] Result
	);

	reg [29:0] A1 [0:9][0:49];
	reg [29:0] B1 [0:49][0:19];
	reg [29:0] Bias_reg [0:19];
	reg [29:0] Res1 [0:9][0:19];
	
	integer i,j,k;
	
	always@ (image or weight) begin
		//We convert the 1D arrays into 2D
		{
			A1[0][0], A1[0][1], A1[0][2], A1[0][3], A1[0][4], A1[0][5], A1[0][6], A1[0][7], A1[0][8], A1[0][9], A1[0][10], A1[0][11], A1[0][12], A1[0][13], A1[0][14], A1[0][15], A1[0][16], A1[0][17], A1[0][18], A1[0][19], A1[0][20], A1[0][21], A1[0][22], A1[0][23], A1[0][24], A1[0][25], A1[0][26], A1[0][27], A1[0][28], A1[0][29], A1[0][30], A1[0][31], A1[0][32], A1[0][33], A1[0][34], A1[0][35], A1[0][36], A1[0][37], A1[0][38], A1[0][39], A1[0][40], A1[0][41], A1[0][42], A1[0][43], A1[0][44], A1[0][45], A1[0][46], A1[0][47], A1[0][48], A1[0][49],
		 A1[1][0], A1[1][1], A1[1][2], A1[1][3], A1[1][4], A1[1][5], A1[1][6], A1[1][7], A1[1][8], A1[1][9], A1[1][10], A1[1][11], A1[1][12], A1[1][13], A1[1][14], A1[1][15], A1[1][16], A1[1][17], A1[1][18], A1[1][19], A1[1][20], A1[1][21], A1[1][22], A1[1][23], A1[1][24], A1[1][25], A1[1][26], A1[1][27], A1[1][28], A1[1][29], A1[1][30], A1[1][31], A1[1][32], A1[1][33], A1[1][34], A1[1][35], A1[1][36], A1[1][37], A1[1][38], A1[1][39], A1[1][40], A1[1][41], A1[1][42], A1[1][43], A1[1][44], A1[1][45], A1[1][46], A1[1][47], A1[1][48], A1[1][49], 
		 A1[2][0], A1[2][1], A1[2][2], A1[2][3], A1[2][4], A1[2][5], A1[2][6], A1[2][7], A1[2][8], A1[2][9], A1[2][10], A1[2][11], A1[2][12], A1[2][13], A1[2][14], A1[2][15], A1[2][16], A1[2][17], A1[2][18], A1[2][19], A1[2][20], A1[2][21], A1[2][22], A1[2][23], A1[2][24], A1[2][25], A1[2][26], A1[2][27], A1[2][28], A1[2][29], A1[2][30], A1[2][31], A1[2][32], A1[2][33], A1[2][34], A1[2][35], A1[2][36], A1[2][37], A1[2][38], A1[2][39], A1[2][40], A1[2][41], A1[2][42], A1[2][43], A1[2][44], A1[2][45], A1[2][46], A1[2][47], A1[2][48], A1[2][49],
		 A1[3][0], A1[3][1], A1[3][2], A1[3][3], A1[3][4], A1[3][5], A1[3][6], A1[3][7], A1[3][8], A1[3][9], A1[3][10], A1[3][11], A1[3][12], A1[3][13], A1[3][14], A1[3][15], A1[3][16], A1[3][17], A1[3][18], A1[3][19], A1[3][20], A1[3][21], A1[3][22], A1[3][23], A1[3][24], A1[3][25], A1[3][26], A1[3][27], A1[3][28], A1[3][29], A1[3][30], A1[3][31], A1[3][32], A1[3][33], A1[3][34], A1[3][35], A1[3][36], A1[3][37], A1[3][38], A1[3][39], A1[3][40], A1[3][41], A1[3][42], A1[3][43], A1[3][44], A1[3][45], A1[3][46], A1[3][47], A1[3][48], A1[3][49],
		 A1[4][0], A1[4][1], A1[4][2], A1[4][3], A1[4][4], A1[4][5], A1[4][6], A1[4][7], A1[4][8], A1[4][9], A1[4][10], A1[4][11], A1[4][12], A1[4][13], A1[4][14], A1[4][15], A1[4][16], A1[4][17], A1[4][18], A1[4][19], A1[4][20], A1[4][21], A1[4][22], A1[4][23], A1[4][24], A1[4][25], A1[4][26], A1[4][27], A1[4][28], A1[4][29], A1[4][30], A1[4][31], A1[4][32], A1[4][33], A1[4][34], A1[4][35], A1[4][36], A1[4][37], A1[4][38], A1[4][39], A1[4][40], A1[4][41], A1[4][42], A1[4][43], A1[4][44], A1[4][45], A1[4][46], A1[4][47], A1[4][48], A1[4][49],
		 A1[5][0], A1[5][1], A1[5][2], A1[5][3], A1[5][4], A1[5][5], A1[5][6], A1[5][7], A1[5][8], A1[5][9], A1[5][10], A1[5][11], A1[5][12], A1[5][13], A1[5][14], A1[5][15], A1[5][16], A1[5][17], A1[5][18], A1[5][19], A1[5][20], A1[5][21], A1[5][22], A1[5][23], A1[5][24], A1[5][25], A1[5][26], A1[5][27], A1[5][28], A1[5][29], A1[5][30], A1[5][31], A1[5][32], A1[5][33], A1[5][34], A1[5][35], A1[5][36], A1[5][37], A1[5][38], A1[5][39], A1[5][40], A1[5][41], A1[5][42], A1[5][43], A1[5][44], A1[5][45], A1[5][46], A1[5][47], A1[5][48], A1[5][49],
		 A1[6][0], A1[6][1], A1[6][2], A1[6][3], A1[6][4], A1[6][5], A1[6][6], A1[6][7], A1[6][8], A1[6][9], A1[6][10], A1[6][11], A1[6][12], A1[6][13], A1[6][14], A1[6][15], A1[6][16], A1[6][17], A1[6][18], A1[6][19], A1[6][20], A1[6][21], A1[6][22], A1[6][23], A1[6][24], A1[6][25], A1[6][26], A1[6][27], A1[6][28], A1[6][29], A1[6][30], A1[6][31], A1[6][32], A1[6][33], A1[6][34], A1[6][35], A1[6][36], A1[6][37], A1[6][38], A1[6][39], A1[6][40], A1[6][41], A1[6][42], A1[6][43], A1[6][44], A1[6][45], A1[6][46], A1[6][47], A1[6][48], A1[6][49],
		 A1[7][0], A1[7][1], A1[7][2], A1[7][3], A1[7][4], A1[7][5], A1[7][6], A1[7][7], A1[7][8], A1[7][9], A1[7][10], A1[7][11], A1[7][12], A1[7][13], A1[7][14], A1[7][15], A1[7][16], A1[7][17], A1[7][18], A1[7][19], A1[7][20], A1[7][21], A1[7][22], A1[7][23], A1[7][24], A1[7][25], A1[7][26], A1[7][27], A1[7][28], A1[7][29], A1[7][30], A1[7][31], A1[7][32], A1[7][33], A1[7][34], A1[7][35], A1[7][36], A1[7][37], A1[7][38], A1[7][39], A1[7][40], A1[7][41], A1[7][42], A1[7][43], A1[7][44], A1[7][45], A1[7][46], A1[7][47], A1[7][48], A1[7][49],
		 A1[8][0], A1[8][1], A1[8][2], A1[8][3], A1[8][4], A1[8][5], A1[8][6], A1[8][7], A1[8][8], A1[8][9], A1[8][10], A1[8][11], A1[8][12], A1[8][13], A1[8][14], A1[8][15], A1[8][16], A1[8][17], A1[8][18], A1[8][19], A1[8][20], A1[8][21], A1[8][22], A1[8][23], A1[8][24], A1[8][25], A1[8][26], A1[8][27], A1[8][28], A1[8][29], A1[8][30], A1[8][31], A1[8][32], A1[8][33], A1[8][34], A1[8][35], A1[8][36], A1[8][37], A1[8][38], A1[8][39], A1[8][40], A1[8][41], A1[8][42], A1[8][43], A1[8][44], A1[8][45], A1[8][46], A1[8][47], A1[8][48], A1[8][49],
		 A1[9][0], A1[9][1], A1[9][2], A1[9][3], A1[9][4], A1[9][5], A1[9][6], A1[9][7], A1[9][8], A1[9][9], A1[9][10], A1[9][11], A1[9][12], A1[9][13], A1[9][14], A1[9][15], A1[9][16], A1[9][17], A1[9][18], A1[9][19], A1[9][20], A1[9][21], A1[9][22], A1[9][23], A1[9][24], A1[9][25], A1[9][26], A1[9][27], A1[9][28], A1[9][29], A1[9][30], A1[9][31], A1[9][32], A1[9][33], A1[9][34], A1[9][35], A1[9][36], A1[9][37], A1[9][38], A1[9][39], A1[9][40], A1[9][41], A1[9][42], A1[9][43], A1[9][44], A1[9][45], A1[9][46], A1[9][47], A1[9][48], A1[9][49]
		} = image;
		{
			B1[0][0], B1[0][1], B1[0][2], B1[0][3], B1[0][4], B1[0][5], B1[0][6], B1[0][7], B1[0][8], B1[0][9], B1[0][10], B1[0][11], B1[0][12], B1[0][13], B1[0][14], B1[0][15], B1[0][16],
		 B1[0][17], B1[0][18], B1[0][19], B1[1][0], B1[1][1], B1[1][2], B1[1][3], B1[1][4], B1[1][5], B1[1][6], B1[1][7], B1[1][8], B1[1][9], B1[1][10], B1[1][11], B1[1][12], B1[1][13], B1[1][14], B1[1][15], B1[1][16], B1[1][17], B1[1][18], B1[1][19], B1[2][0], B1[2][1], B1[2][2], B1[2][3], B1[2][4], B1[2][5], B1[2][6], B1[2][7], B1[2][8], B1[2][9], B1[2][10], B1[2][11], B1[2][12], B1[2][13], B1[2][14], B1[2][15], B1[2][16], B1[2][17], B1[2][18], B1[2][19], B1[3][0], B1[3][1], B1[3][2], B1[3][3], B1[3][4], B1[3][5], B1[3][6], B1[3][7], B1[3][8], B1[3][9], B1[3][10], B1[3][11], B1[3][12], B1[3][13], B1[3][14], B1[3][15], B1[3][16], B1[3][17], B1[3][18], B1[3][19],
		 B1[4][0], B1[4][1], B1[4][2], B1[4][3], B1[4][4], B1[4][5], B1[4][6], B1[4][7], B1[4][8], B1[4][9], B1[4][10], B1[4][11], B1[4][12], B1[4][13], B1[4][14], B1[4][15], B1[4][16], B1[4][17], B1[4][18], B1[4][19], B1[5][0], B1[5][1], B1[5][2], B1[5][3], B1[5][4], B1[5][5], B1[5][6], B1[5][7], B1[5][8], B1[5][9], B1[5][10], B1[5][11], B1[5][12], B1[5][13], B1[5][14], B1[5][15], B1[5][16], B1[5][17], B1[5][18], B1[5][19], B1[6][0], B1[6][1], B1[6][2], B1[6][3], B1[6][4], B1[6][5], B1[6][6], B1[6][7], B1[6][8], B1[6][9], B1[6][10], B1[6][11], B1[6][12], B1[6][13], B1[6][14], B1[6][15], B1[6][16], B1[6][17], B1[6][18], B1[6][19], B1[7][0], B1[7][1], B1[7][2], B1[7][3], B1[7][4], B1[7][5], B1[7][6], B1[7][7], B1[7][8], B1[7][9], B1[7][10], B1[7][11], B1[7][12], B1[7][13], B1[7][14], B1[7][15], B1[7][16], B1[7][17], B1[7][18], B1[7][19], B1[8][0], B1[8][1], B1[8][2], B1[8][3], B1[8][4], B1[8][5], B1[8][6], B1[8][7], B1[8][8], B1[8][9], B1[8][10],
		 B1[8][11], B1[8][12], B1[8][13], B1[8][14], B1[8][15], B1[8][16], B1[8][17], B1[8][18], B1[8][19], B1[9][0], B1[9][1], B1[9][2], B1[9][3], B1[9][4], B1[9][5], B1[9][6], B1[9][7], B1[9][8], B1[9][9], B1[9][10], B1[9][11], B1[9][12], B1[9][13], B1[9][14], B1[9][15], B1[9][16], B1[9][17], B1[9][18], B1[9][19], B1[10][0], B1[10][1], B1[10][2], B1[10][3], B1[10][4], B1[10][5], B1[10][6], B1[10][7], B1[10][8], B1[10][9], B1[10][10], B1[10][11], B1[10][12], B1[10][13], B1[10][14], B1[10][15], B1[10][16], B1[10][17], B1[10][18], B1[10][19], B1[11][0], B1[11][1], B1[11][2], B1[11][3], B1[11][4], B1[11][5], B1[11][6], B1[11][7], B1[11][8], B1[11][9], B1[11][10], B1[11][11],
		 B1[11][12], B1[11][13], B1[11][14], B1[11][15], B1[11][16], B1[11][17], B1[11][18], B1[11][19], B1[12][0], B1[12][1], B1[12][2], B1[12][3], B1[12][4], B1[12][5], B1[12][6], B1[12][7], B1[12][8], B1[12][9], B1[12][10], B1[12][11], B1[12][12], B1[12][13], B1[12][14], B1[12][15], B1[12][16], B1[12][17], B1[12][18], B1[12][19], B1[13][0], B1[13][1], B1[13][2], B1[13][3], B1[13][4], B1[13][5], B1[13][6], B1[13][7], B1[13][8], B1[13][9], B1[13][10], B1[13][11], B1[13][12], B1[13][13], B1[13][14], B1[13][15], B1[13][16], B1[13][17], B1[13][18], B1[13][19], B1[14][0], B1[14][1], B1[14][2], B1[14][3], B1[14][4], B1[14][5], B1[14][6], B1[14][7], B1[14][8], B1[14][9], B1[14][10], B1[14][11], B1[14][12], B1[14][13], B1[14][14], B1[14][15], B1[14][16], B1[14][17], B1[14][18], B1[14][19], B1[15][0], B1[15][1], B1[15][2], B1[15][3], B1[15][4], B1[15][5], B1[15][6], B1[15][7], B1[15][8], B1[15][9], B1[15][10], B1[15][11], B1[15][12], B1[15][13], B1[15][14], B1[15][15], B1[15][16], B1[15][17], B1[15][18], B1[15][19], B1[16][0], B1[16][1], B1[16][2], B1[16][3], B1[16][4], B1[16][5], B1[16][6], B1[16][7], B1[16][8], B1[16][9], B1[16][10], B1[16][11], B1[16][12], B1[16][13], B1[16][14], B1[16][15], B1[16][16], B1[16][17], B1[16][18], B1[16][19], B1[17][0], B1[17][1], B1[17][2], B1[17][3], B1[17][4], B1[17][5], B1[17][6], B1[17][7], B1[17][8], B1[17][9], B1[17][10], B1[17][11], B1[17][12], B1[17][13], B1[17][14], B1[17][15], B1[17][16], B1[17][17], B1[17][18], B1[17][19], B1[18][0], B1[18][1], B1[18][2], B1[18][3], B1[18][4], B1[18][5], B1[18][6], B1[18][7],
		 B1[18][8], B1[18][9], B1[18][10], B1[18][11], B1[18][12], B1[18][13], B1[18][14], B1[18][15], B1[18][16], B1[18][17], B1[18][18], B1[18][19], B1[19][0], B1[19][1], B1[19][2], B1[19][3], B1[19][4], B1[19][5], B1[19][6], B1[19][7], B1[19][8], B1[19][9], B1[19][10], B1[19][11], B1[19][12], B1[19][13], B1[19][14], B1[19][15], B1[19][16], B1[19][17], B1[19][18], B1[19][19], B1[20][0], B1[20][1], B1[20][2], B1[20][3], B1[20][4], B1[20][5], B1[20][6], B1[20][7], B1[20][8], B1[20][9], B1[20][10], B1[20][11], B1[20][12], B1[20][13], B1[20][14], B1[20][15], B1[20][16], B1[20][17], B1[20][18], B1[20][19], B1[21][0], B1[21][1], B1[21][2], B1[21][3], B1[21][4], B1[21][5], B1[21][6], B1[21][7], B1[21][8], B1[21][9], B1[21][10], B1[21][11], B1[21][12], B1[21][13], B1[21][14], B1[21][15], B1[21][16], B1[21][17], B1[21][18], B1[21][19], B1[22][0], B1[22][1], B1[22][2], B1[22][3], B1[22][4], B1[22][5], B1[22][6], B1[22][7], B1[22][8], B1[22][9], B1[22][10], B1[22][11], B1[22][12], B1[22][13], B1[22][14], B1[22][15], B1[22][16], B1[22][17], B1[22][18], B1[22][19], B1[23][0], B1[23][1], B1[23][2],
		 B1[23][3], B1[23][4], B1[23][5], B1[23][6], B1[23][7], B1[23][8], B1[23][9], B1[23][10], B1[23][11], B1[23][12], B1[23][13], B1[23][14], B1[23][15], B1[23][16], B1[23][17], B1[23][18], B1[23][19], B1[24][0], B1[24][1], B1[24][2], B1[24][3], B1[24][4], B1[24][5], B1[24][6], B1[24][7], B1[24][8], B1[24][9], B1[24][10], B1[24][11], B1[24][12], B1[24][13], B1[24][14], B1[24][15], B1[24][16], B1[24][17], B1[24][18], B1[24][19], B1[25][0], B1[25][1], B1[25][2], B1[25][3], B1[25][4], B1[25][5], B1[25][6], B1[25][7], B1[25][8], B1[25][9], B1[25][10], B1[25][11], B1[25][12], B1[25][13], B1[25][14], B1[25][15], B1[25][16], B1[25][17], B1[25][18], B1[25][19], B1[26][0], B1[26][1], B1[26][2], B1[26][3], B1[26][4], B1[26][5], B1[26][6], B1[26][7], B1[26][8], B1[26][9], B1[26][10], B1[26][11], B1[26][12], B1[26][13], B1[26][14], B1[26][15], B1[26][16], B1[26][17], B1[26][18], B1[26][19], B1[27][0], B1[27][1], B1[27][2], B1[27][3], B1[27][4], B1[27][5], B1[27][6], B1[27][7], B1[27][8], B1[27][9], B1[27][10], B1[27][11], B1[27][12], B1[27][13], B1[27][14], B1[27][15], B1[27][16], B1[27][17], B1[27][18], B1[27][19], B1[28][0], B1[28][1], B1[28][2], B1[28][3], B1[28][4], B1[28][5], B1[28][6], B1[28][7], B1[28][8], B1[28][9], B1[28][10], B1[28][11], B1[28][12], B1[28][13], B1[28][14], B1[28][15], B1[28][16], B1[28][17], B1[28][18], B1[28][19], B1[29][0], B1[29][1], B1[29][2], B1[29][3], B1[29][4], B1[29][5], B1[29][6], B1[29][7], B1[29][8], B1[29][9], B1[29][10], B1[29][11], B1[29][12], B1[29][13], B1[29][14], B1[29][15], B1[29][16], B1[29][17], B1[29][18], B1[29][19], B1[30][0], B1[30][1], B1[30][2], B1[30][3], B1[30][4], B1[30][5], B1[30][6], B1[30][7], B1[30][8], B1[30][9], B1[30][10], B1[30][11], B1[30][12], B1[30][13], B1[30][14], B1[30][15], B1[30][16], B1[30][17], B1[30][18], B1[30][19], B1[31][0], B1[31][1], B1[31][2], B1[31][3], B1[31][4], B1[31][5], B1[31][6], B1[31][7], B1[31][8], B1[31][9], B1[31][10], B1[31][11], B1[31][12], B1[31][13], B1[31][14], B1[31][15], B1[31][16], B1[31][17], B1[31][18],
		 B1[31][19], B1[32][0], B1[32][1], B1[32][2], B1[32][3], B1[32][4], B1[32][5], B1[32][6], B1[32][7], B1[32][8], B1[32][9], B1[32][10], B1[32][11], B1[32][12], B1[32][13], B1[32][14], B1[32][15], B1[32][16], B1[32][17], B1[32][18], B1[32][19], B1[33][0], B1[33][1], B1[33][2], B1[33][3], B1[33][4], B1[33][5], B1[33][6], B1[33][7], B1[33][8], B1[33][9], B1[33][10], B1[33][11], B1[33][12], B1[33][13], B1[33][14], B1[33][15], B1[33][16], B1[33][17], B1[33][18], B1[33][19], B1[34][0], B1[34][1], B1[34][2], B1[34][3], B1[34][4], B1[34][5], B1[34][6], B1[34][7], B1[34][8], B1[34][9], B1[34][10], B1[34][11], B1[34][12], B1[34][13], B1[34][14], B1[34][15], B1[34][16], B1[34][17], B1[34][18], B1[34][19], B1[35][0], B1[35][1], B1[35][2], B1[35][3], B1[35][4], B1[35][5], B1[35][6], B1[35][7], B1[35][8], B1[35][9], B1[35][10], B1[35][11], B1[35][12], B1[35][13], B1[35][14], B1[35][15], B1[35][16], B1[35][17], B1[35][18], B1[35][19], B1[36][0], B1[36][1], B1[36][2], B1[36][3], B1[36][4], B1[36][5], B1[36][6], B1[36][7], B1[36][8], B1[36][9], B1[36][10], B1[36][11], B1[36][12], B1[36][13], B1[36][14], B1[36][15], B1[36][16], B1[36][17], B1[36][18], B1[36][19], B1[37][0], B1[37][1], B1[37][2], B1[37][3], B1[37][4], B1[37][5], B1[37][6], B1[37][7], B1[37][8], B1[37][9], B1[37][10], B1[37][11], B1[37][12], B1[37][13], B1[37][14], B1[37][15], B1[37][16], B1[37][17], B1[37][18], B1[37][19], B1[38][0], B1[38][1], B1[38][2], B1[38][3], B1[38][4], B1[38][5], B1[38][6], B1[38][7], B1[38][8], B1[38][9], B1[38][10], B1[38][11], B1[38][12], B1[38][13], B1[38][14], B1[38][15], B1[38][16], B1[38][17], B1[38][18], B1[38][19], B1[39][0], B1[39][1], B1[39][2], B1[39][3], B1[39][4], B1[39][5], B1[39][6], B1[39][7], B1[39][8], B1[39][9], B1[39][10], B1[39][11], B1[39][12], B1[39][13], B1[39][14], B1[39][15], B1[39][16],
		 B1[39][17], B1[39][18], B1[39][19], B1[40][0], B1[40][1], B1[40][2], B1[40][3], B1[40][4], B1[40][5], B1[40][6], B1[40][7], B1[40][8], B1[40][9], B1[40][10], B1[40][11], B1[40][12], B1[40][13], B1[40][14], B1[40][15], B1[40][16], B1[40][17], B1[40][18], B1[40][19], B1[41][0], B1[41][1], B1[41][2], B1[41][3], B1[41][4], B1[41][5], B1[41][6], B1[41][7], B1[41][8], B1[41][9], B1[41][10], B1[41][11], B1[41][12], B1[41][13], B1[41][14], B1[41][15], B1[41][16], B1[41][17], B1[41][18], B1[41][19], B1[42][0], B1[42][1], B1[42][2], B1[42][3],
		 B1[42][4], B1[42][5], B1[42][6], B1[42][7], B1[42][8], B1[42][9], B1[42][10], B1[42][11], B1[42][12], B1[42][13], B1[42][14], B1[42][15], B1[42][16], B1[42][17], B1[42][18], B1[42][19], B1[43][0], B1[43][1], B1[43][2], B1[43][3], B1[43][4], B1[43][5], B1[43][6], B1[43][7], B1[43][8], B1[43][9], B1[43][10], B1[43][11], B1[43][12], B1[43][13], B1[43][14],
		 B1[43][15], B1[43][16], B1[43][17], B1[43][18], B1[43][19], B1[44][0], B1[44][1], B1[44][2], B1[44][3], B1[44][4], B1[44][5], B1[44][6], B1[44][7], B1[44][8], B1[44][9], B1[44][10], B1[44][11], B1[44][12], B1[44][13], B1[44][14], B1[44][15], B1[44][16], B1[44][17], B1[44][18], B1[44][19], B1[45][0], B1[45][1], B1[45][2], B1[45][3], B1[45][4], B1[45][5], B1[45][6], B1[45][7], B1[45][8], B1[45][9], B1[45][10], B1[45][11], B1[45][12], B1[45][13], B1[45][14], B1[45][15], B1[45][16], B1[45][17], B1[45][18], B1[45][19], B1[46][0], B1[46][1], B1[46][2], B1[46][3], B1[46][4], B1[46][5], B1[46][6], B1[46][7], B1[46][8], B1[46][9], B1[46][10], B1[46][11], B1[46][12], B1[46][13], B1[46][14], B1[46][15], B1[46][16], B1[46][17], B1[46][18], B1[46][19], B1[47][0], B1[47][1],
		 B1[47][2], B1[47][3], B1[47][4], B1[47][5], B1[47][6], B1[47][7], B1[47][8], B1[47][9], B1[47][10], B1[47][11], B1[47][12], B1[47][13], B1[47][14], B1[47][15], B1[47][16], B1[47][17], B1[47][18], B1[47][19], B1[48][0], B1[48][1], B1[48][2], B1[48][3], B1[48][4], B1[48][5], B1[48][6], B1[48][7], B1[48][8], B1[48][9], B1[48][10], B1[48][11], B1[48][12], B1[48][13],
		 B1[48][14], B1[48][15], B1[48][16], B1[48][17], B1[48][18], B1[48][19], B1[49][0], B1[49][1], B1[49][2], B1[49][3], B1[49][4], B1[49][5], B1[49][6], B1[49][7], B1[49][8], B1[49][9], B1[49][10], B1[49][11], B1[49][12], B1[49][13], B1[49][14], B1[49][15], B1[49][16], B1[49][17], B1[49][18], B1[49][19]
		} = weight;
		{
			Bias_reg[0] ,Bias_reg[1] ,Bias_reg[2] ,Bias_reg[3] ,Bias_reg[4] ,Bias_reg[5] ,Bias_reg[6] ,Bias_reg[7] ,Bias_reg[8] ,Bias_reg[9] ,Bias_reg[10] ,Bias_reg[11] ,Bias_reg[12] ,Bias_reg[13] ,Bias_reg[14] ,Bias_reg[15] ,Bias_reg[16] ,Bias_reg[17] ,Bias_reg[18] ,Bias_reg[19]
		} = Bias;
		{
			Res1[0][0], Res1[0][1], Res1[0][2], Res1[0][3], Res1[0][4], Res1[0][5], Res1[0][6], Res1[0][7], Res1[0][8], Res1[0][9], Res1[0][10], Res1[0][11], Res1[0][12], Res1[0][13], Res1[0][14], Res1[0][15], Res1[0][16], Res1[0][17], Res1[0][18], Res1[0][19], Res1[1][0], Res1[1][1], Res1[1][2], Res1[1][3], Res1[1][4], Res1[1][5], Res1[1][6], Res1[1][7], Res1[1][8], Res1[1][9], Res1[1][10], Res1[1][11], Res1[1][12], Res1[1][13], Res1[1][14], Res1[1][15], Res1[1][16], Res1[1][17], Res1[1][18], Res1[1][19], Res1[2][0], Res1[2][1], Res1[2][2], Res1[2][3], Res1[2][4],
		 Res1[2][5], Res1[2][6], Res1[2][7], Res1[2][8], Res1[2][9], Res1[2][10], Res1[2][11], Res1[2][12], Res1[2][13], Res1[2][14], Res1[2][15], Res1[2][16], Res1[2][17], Res1[2][18], Res1[2][19], Res1[3][0], Res1[3][1], Res1[3][2], Res1[3][3], Res1[3][4], Res1[3][5], Res1[3][6], Res1[3][7], Res1[3][8], Res1[3][9], Res1[3][10], Res1[3][11], Res1[3][12], Res1[3][13], Res1[3][14], Res1[3][15], Res1[3][16], Res1[3][17], Res1[3][18], Res1[3][19], Res1[4][0], Res1[4][1], Res1[4][2], Res1[4][3], Res1[4][4], Res1[4][5], Res1[4][6], Res1[4][7], Res1[4][8], Res1[4][9], Res1[4][10], Res1[4][11], Res1[4][12],
		 Res1[4][13], Res1[4][14], Res1[4][15], Res1[4][16], Res1[4][17], Res1[4][18], Res1[4][19], Res1[5][0], Res1[5][1], Res1[5][2], Res1[5][3], Res1[5][4], Res1[5][5], Res1[5][6], Res1[5][7], Res1[5][8], Res1[5][9], Res1[5][10], Res1[5][11], Res1[5][12], Res1[5][13], Res1[5][14], Res1[5][15], Res1[5][16], Res1[5][17], Res1[5][18], Res1[5][19], Res1[6][0], Res1[6][1], Res1[6][2], Res1[6][3], Res1[6][4], Res1[6][5], Res1[6][6], Res1[6][7], Res1[6][8], Res1[6][9], Res1[6][10], Res1[6][11], Res1[6][12], Res1[6][13], Res1[6][14], Res1[6][15], Res1[6][16], Res1[6][17],
		 Res1[6][18], Res1[6][19], Res1[7][0], Res1[7][1], Res1[7][2], Res1[7][3], Res1[7][4], Res1[7][5], Res1[7][6], Res1[7][7], Res1[7][8], Res1[7][9], Res1[7][10], Res1[7][11], Res1[7][12], Res1[7][13], Res1[7][14], Res1[7][15], Res1[7][16], Res1[7][17], Res1[7][18], Res1[7][19], Res1[8][0], Res1[8][1], Res1[8][2], Res1[8][3], Res1[8][4], Res1[8][5], Res1[8][6], Res1[8][7], Res1[8][8], Res1[8][9], Res1[8][10], Res1[8][11], Res1[8][12], Res1[8][13], Res1[8][14], Res1[8][15], Res1[8][16], Res1[8][17], Res1[8][18], Res1[8][19], Res1[9][0],
		 Res1[9][1], Res1[9][2], Res1[9][3], Res1[9][4], Res1[9][5], Res1[9][6], Res1[9][7], Res1[9][8], Res1[9][9], Res1[9][10], Res1[9][11], Res1[9][12], Res1[9][13], Res1[9][14], Res1[9][15], Res1[9][16], Res1[9][17], Res1[9][18], Res1[9][19]
		} = 6000'd0;
		
		i=0; j=0; k=0;
		
		for(i=0;i<10;i=i+1) begin
			for(j=0;j<20;j=j+1) begin
				for(k=0;k<50;k=k+1) begin
					Res1[i][j] = Res1[i][j]+ (A1[i][k]*B1[k][j]);
				end
					if (Res1[i][j][29] == 1 ) // reg 沒有正負之分，藉由判斷MSB知道是否為負
						Res1[i][j] = 0;
					else 
						Res1[i][j] = Res1[i][j] + Bias_reg[j];
			end
		end

		Result = {Res1[0][0], Res1[0][1], Res1[0][2], Res1[0][3], Res1[0][4], Res1[0][5], Res1[0][6], Res1[0][7], Res1[0][8], Res1[0][9], Res1[0][10], Res1[0][11], Res1[0][12], Res1[0][13], Res1[0][14], Res1[0][15], Res1[0][16], Res1[0][17], Res1[0][18], Res1[0][19], Res1[1][0], Res1[1][1], Res1[1][2], Res1[1][3], Res1[1][4], Res1[1][5], Res1[1][6], Res1[1][7], Res1[1][8],
		 Res1[1][9], Res1[1][10], Res1[1][11], Res1[1][12], Res1[1][13], Res1[1][14], Res1[1][15], Res1[1][16], Res1[1][17], Res1[1][18], Res1[1][19], Res1[2][0], Res1[2][1], Res1[2][2], Res1[2][3], Res1[2][4],
		 Res1[2][5], Res1[2][6], Res1[2][7], Res1[2][8], Res1[2][9], Res1[2][10], Res1[2][11], Res1[2][12], Res1[2][13], Res1[2][14], Res1[2][15], Res1[2][16], Res1[2][17], Res1[2][18], Res1[2][19], Res1[3][0], Res1[3][1], Res1[3][2], Res1[3][3], Res1[3][4], Res1[3][5], Res1[3][6], Res1[3][7], Res1[3][8], Res1[3][9], Res1[3][10], Res1[3][11], Res1[3][12], Res1[3][13], Res1[3][14], Res1[3][15], Res1[3][16], Res1[3][17], Res1[3][18], Res1[3][19], Res1[4][0], Res1[4][1], Res1[4][2], Res1[4][3], Res1[4][4], Res1[4][5], Res1[4][6], Res1[4][7], Res1[4][8], Res1[4][9], Res1[4][10], Res1[4][11], Res1[4][12],
		 Res1[4][13], Res1[4][14], Res1[4][15], Res1[4][16], Res1[4][17], Res1[4][18], Res1[4][19], Res1[5][0], Res1[5][1], Res1[5][2], Res1[5][3], Res1[5][4], Res1[5][5], Res1[5][6], Res1[5][7], Res1[5][8], Res1[5][9], Res1[5][10], Res1[5][11], Res1[5][12], Res1[5][13], Res1[5][14], Res1[5][15], Res1[5][16], Res1[5][17], Res1[5][18], Res1[5][19], Res1[6][0], Res1[6][1], Res1[6][2], Res1[6][3], Res1[6][4], Res1[6][5], Res1[6][6], Res1[6][7], Res1[6][8], Res1[6][9], Res1[6][10], Res1[6][11], Res1[6][12], Res1[6][13], Res1[6][14], Res1[6][15], Res1[6][16], Res1[6][17],
		 Res1[6][18], Res1[6][19], Res1[7][0], Res1[7][1], Res1[7][2], Res1[7][3], Res1[7][4], Res1[7][5], Res1[7][6], Res1[7][7], Res1[7][8], Res1[7][9], Res1[7][10], Res1[7][11], Res1[7][12], Res1[7][13], Res1[7][14], Res1[7][15], Res1[7][16], Res1[7][17], Res1[7][18], Res1[7][19], Res1[8][0], Res1[8][1], Res1[8][2], Res1[8][3], Res1[8][4], Res1[8][5], Res1[8][6], Res1[8][7], Res1[8][8], Res1[8][9], Res1[8][10], Res1[8][11], Res1[8][12], Res1[8][13], Res1[8][14], Res1[8][15], Res1[8][16], Res1[8][17], Res1[8][18], Res1[8][19], Res1[9][0],
		 Res1[9][1], Res1[9][2], Res1[9][3], Res1[9][4], Res1[9][5], Res1[9][6], Res1[9][7], Res1[9][8], Res1[9][9], Res1[9][10], Res1[9][11], Res1[9][12], Res1[9][13], Res1[9][14], Res1[9][15], Res1[9][16], Res1[9][17], Res1[9][18], Res1[9][19]
		};
	end

endmodule