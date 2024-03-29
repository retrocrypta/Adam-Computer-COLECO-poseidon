library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity controller_rom2 is
generic	(
	ADDR_WIDTH : integer := 8; -- ROM's address width (words, not bytes)
	COL_WIDTH  : integer := 8;  -- Column width (8bit -> byte)
	NB_COL     : integer := 4  -- Number of columns in memory
	);
port (
	clk : in std_logic;
	reset_n : in std_logic := '1';
	addr : in std_logic_vector(ADDR_WIDTH-1 downto 0);
	q : out std_logic_vector(31 downto 0);
	-- Allow writes - defaults supplied to simplify projects that don't need to write.
	d : in std_logic_vector(31 downto 0) := X"00000000";
	we : in std_logic := '0';
	bytesel : in std_logic_vector(3 downto 0) := "1111"
);
end entity;

architecture arch of controller_rom2 is

-- type word_t is std_logic_vector(31 downto 0);
type ram_type is array (0 to 2 ** ADDR_WIDTH - 1) of std_logic_vector(NB_COL * COL_WIDTH - 1 downto 0);

signal ram : ram_type :=
(

     0 => x"c185cb87",
     1 => x"abb7c883",
     2 => x"87c7ff04",
     3 => x"264d2626",
     4 => x"264b264c",
     5 => x"4a711e4f",
     6 => x"5aceedc2",
     7 => x"48ceedc2",
     8 => x"fe4978c7",
     9 => x"4f2687dd",
    10 => x"711e731e",
    11 => x"aab7c04a",
    12 => x"c287d303",
    13 => x"05bff9cd",
    14 => x"4bc187c4",
    15 => x"4bc087c2",
    16 => x"5bfdcdc2",
    17 => x"cdc287c4",
    18 => x"cdc25afd",
    19 => x"c14abff9",
    20 => x"a2c0c19a",
    21 => x"87e8ec49",
    22 => x"cdc248fc",
    23 => x"fe78bff9",
    24 => x"711e87ef",
    25 => x"1e66c44a",
    26 => x"f5e94972",
    27 => x"4f262687",
    28 => x"f9cdc21e",
    29 => x"cfe649bf",
    30 => x"c2edc287",
    31 => x"78bfe848",
    32 => x"48feecc2",
    33 => x"c278bfec",
    34 => x"4abfc2ed",
    35 => x"99ffc349",
    36 => x"722ab7c8",
    37 => x"c2b07148",
    38 => x"2658caed",
    39 => x"5b5e0e4f",
    40 => x"710e5d5c",
    41 => x"87c8ff4b",
    42 => x"48fdecc2",
    43 => x"497350c0",
    44 => x"7087f5e5",
    45 => x"9cc24c49",
    46 => x"cb49eecb",
    47 => x"497087c3",
    48 => x"fdecc24d",
    49 => x"c105bf97",
    50 => x"66d087e2",
    51 => x"c6edc249",
    52 => x"d60599bf",
    53 => x"4966d487",
    54 => x"bffeecc2",
    55 => x"87cb0599",
    56 => x"c3e54973",
    57 => x"02987087",
    58 => x"c187c1c1",
    59 => x"87c0fe4c",
    60 => x"d8ca4975",
    61 => x"02987087",
    62 => x"ecc287c6",
    63 => x"50c148fd",
    64 => x"97fdecc2",
    65 => x"e3c005bf",
    66 => x"c6edc287",
    67 => x"66d049bf",
    68 => x"d6ff0599",
    69 => x"feecc287",
    70 => x"66d449bf",
    71 => x"caff0599",
    72 => x"e4497387",
    73 => x"987087c2",
    74 => x"87fffe05",
    75 => x"dcfb4874",
    76 => x"5b5e0e87",
    77 => x"f40e5d5c",
    78 => x"4c4dc086",
    79 => x"c47ebfec",
    80 => x"edc248a6",
    81 => x"c178bfca",
    82 => x"c71ec01e",
    83 => x"87cdfd49",
    84 => x"987086c8",
    85 => x"ff87cd02",
    86 => x"87ccfb49",
    87 => x"e349dac1",
    88 => x"4dc187c6",
    89 => x"97fdecc2",
    90 => x"87c302bf",
    91 => x"c287fed4",
    92 => x"4bbfc2ed",
    93 => x"bff9cdc2",
    94 => x"87e9c005",
    95 => x"e249fdc3",
    96 => x"fac387e6",
    97 => x"87e0e249",
    98 => x"ffc34973",
    99 => x"c01e7199",
   100 => x"87cefb49",
   101 => x"b7c84973",
   102 => x"c11e7129",
   103 => x"87c2fb49",
   104 => x"fac586c8",
   105 => x"c6edc287",
   106 => x"029b4bbf",
   107 => x"cdc287dd",
   108 => x"c749bff5",
   109 => x"987087d7",
   110 => x"c087c405",
   111 => x"c287d24b",
   112 => x"fcc649e0",
   113 => x"f9cdc287",
   114 => x"c287c658",
   115 => x"c048f5cd",
   116 => x"c2497378",
   117 => x"87cd0599",
   118 => x"e149ebc3",
   119 => x"497087ca",
   120 => x"c20299c2",
   121 => x"734cfb87",
   122 => x"0599c149",
   123 => x"f4c387cd",
   124 => x"87f4e049",
   125 => x"99c24970",
   126 => x"fa87c202",
   127 => x"c849734c",
   128 => x"87cd0599",
   129 => x"e049f5c3",
   130 => x"497087de",
   131 => x"d40299c2",
   132 => x"ceedc287",
   133 => x"87c902bf",
   134 => x"c288c148",
   135 => x"c258d2ed",
   136 => x"c14cff87",
   137 => x"c449734d",
   138 => x"87ce0599",
   139 => x"ff49f2c3",
   140 => x"7087f5df",
   141 => x"0299c249",
   142 => x"edc287db",
   143 => x"487ebfce",
   144 => x"03a8b7c7",
   145 => x"486e87cb",
   146 => x"edc280c1",
   147 => x"c2c058d2",
   148 => x"c14cfe87",
   149 => x"49fdc34d",
   150 => x"87ccdfff",
   151 => x"99c24970",
   152 => x"c287d502",
   153 => x"02bfceed",
   154 => x"c287c9c0",
   155 => x"c048ceed",
   156 => x"87c2c078",
   157 => x"4dc14cfd",
   158 => x"ff49fac3",
   159 => x"7087e9de",
   160 => x"0299c249",
   161 => x"edc287d9",
   162 => x"c748bfce",
   163 => x"c003a8b7",
   164 => x"edc287c9",
   165 => x"78c748ce",
   166 => x"fc87c2c0",
   167 => x"c04dc14c",
   168 => x"c003acb7",
   169 => x"66c487d1",
   170 => x"82d8c14a",
   171 => x"c6c0026a",
   172 => x"744b6a87",
   173 => x"c00f7349",
   174 => x"1ef0c31e",
   175 => x"f749dac1",
   176 => x"86c887db",
   177 => x"c0029870",
   178 => x"a6c887e2",
   179 => x"ceedc248",
   180 => x"66c878bf",
   181 => x"c491cb49",
   182 => x"80714866",
   183 => x"bf6e7e70",
   184 => x"87c8c002",
   185 => x"c84bbf6e",
   186 => x"0f734966",
   187 => x"c0029d75",
   188 => x"edc287c8",
   189 => x"f349bfce",
   190 => x"cdc287c9",
   191 => x"c002bffd",
   192 => x"c24987dd",
   193 => x"987087c7",
   194 => x"87d3c002",
   195 => x"bfceedc2",
   196 => x"87eff249",
   197 => x"cff449c0",
   198 => x"fdcdc287",
   199 => x"f478c048",
   200 => x"87e9f38e",
   201 => x"5c5b5e0e",
   202 => x"711e0e5d",
   203 => x"caedc24c",
   204 => x"cdc149bf",
   205 => x"d1c14da1",
   206 => x"747e6981",
   207 => x"87cf029c",
   208 => x"744ba5c4",
   209 => x"caedc27b",
   210 => x"c8f349bf",
   211 => x"747b6e87",
   212 => x"87c4059c",
   213 => x"87c24bc0",
   214 => x"49734bc1",
   215 => x"d487c9f3",
   216 => x"87c70266",
   217 => x"7087da49",
   218 => x"c087c24a",
   219 => x"c1cec24a",
   220 => x"d8f2265a",
   221 => x"00000087",
   222 => x"00000000",
   223 => x"00000000",
   224 => x"4a711e00",
   225 => x"49bfc8ff",
   226 => x"2648a172",
   227 => x"c8ff1e4f",
   228 => x"c0fe89bf",
   229 => x"c0c0c0c0",
   230 => x"87c401a9",
   231 => x"87c24ac0",
   232 => x"48724ac1",
   233 => x"5e0e4f26",
   234 => x"0e5d5c5b",
   235 => x"d4ff4b71",
   236 => x"4866d04c",
   237 => x"49d678c0",
   238 => x"87ecdbff",
   239 => x"6c7cffc3",
   240 => x"99ffc349",
   241 => x"c3494d71",
   242 => x"e0c199f0",
   243 => x"87cb05a9",
   244 => x"6c7cffc3",
   245 => x"d098c348",
   246 => x"c3780866",
   247 => x"4a6c7cff",
   248 => x"c331c849",
   249 => x"4a6c7cff",
   250 => x"4972b271",
   251 => x"ffc331c8",
   252 => x"714a6c7c",
   253 => x"c84972b2",
   254 => x"7cffc331",
   255 => x"b2714a6c",
   256 => x"c048d0ff",
   257 => x"9b7378e0",
   258 => x"7287c202",
   259 => x"2648757b",
   260 => x"264c264d",
   261 => x"1e4f264b",
   262 => x"5e0e4f26",
   263 => x"f80e5c5b",
   264 => x"c81e7686",
   265 => x"fdfd49a6",
   266 => x"7086c487",
   267 => x"c8486e4b",
   268 => x"c6c303a8",
   269 => x"c34a7387",
   270 => x"d0c19af0",
   271 => x"87c702aa",
   272 => x"05aae0c1",
   273 => x"7387f4c2",
   274 => x"0299c849",
   275 => x"c6ff87c3",
   276 => x"c34c7387",
   277 => x"05acc29c",
   278 => x"c487cdc1",
   279 => x"31c94966",
   280 => x"66c41e71",
   281 => x"c292d44a",
   282 => x"7249d2ed",
   283 => x"fed4fe81",
   284 => x"4966c487",
   285 => x"49e3c01e",
   286 => x"87d1d9ff",
   287 => x"d8ff49d8",
   288 => x"c0c887e6",
   289 => x"c2dcc21e",
   290 => x"cef1fd49",
   291 => x"48d0ff87",
   292 => x"c278e0c0",
   293 => x"d01ec2dc",
   294 => x"92d44a66",
   295 => x"49d2edc2",
   296 => x"d3fe8172",
   297 => x"86d087c6",
   298 => x"c105acc1",
   299 => x"66c487cd",
   300 => x"7131c949",
   301 => x"4a66c41e",
   302 => x"edc292d4",
   303 => x"817249d2",
   304 => x"87ebd3fe",
   305 => x"1ec2dcc2",
   306 => x"d44a66c8",
   307 => x"d2edc292",
   308 => x"fe817249",
   309 => x"c887d2d1",
   310 => x"c01e4966",
   311 => x"d7ff49e3",
   312 => x"49d787eb",
   313 => x"87c0d7ff",
   314 => x"c21ec0c8",
   315 => x"fd49c2dc",
   316 => x"d087d2ef",
   317 => x"48d0ff86",
   318 => x"f878e0c0",
   319 => x"87d1fc8e",
   320 => x"5c5b5e0e",
   321 => x"711e0e5d",
   322 => x"4cd4ff4d",
   323 => x"487e66d4",
   324 => x"06a8b7c3",
   325 => x"48c087c5",
   326 => x"7587e2c1",
   327 => x"dfe1fe49",
   328 => x"c41e7587",
   329 => x"93d44b66",
   330 => x"83d2edc2",
   331 => x"ccfe4973",
   332 => x"83c887db",
   333 => x"d0ff4b6b",
   334 => x"78e1c848",
   335 => x"49737cdd",
   336 => x"7199ffc3",
   337 => x"c849737c",
   338 => x"ffc329b7",
   339 => x"737c7199",
   340 => x"29b7d049",
   341 => x"7199ffc3",
   342 => x"d849737c",
   343 => x"7c7129b7",
   344 => x"7c7c7cc0",
   345 => x"7c7c7c7c",
   346 => x"7c7c7c7c",
   347 => x"78e0c07c",
   348 => x"dc1e66c4",
   349 => x"d4d5ff49",
   350 => x"7386c887",
   351 => x"cefa2648",
   352 => x"5b5e0e87",
   353 => x"1e0e5d5c",
   354 => x"d4ff7e71",
   355 => x"c21e6e4b",
   356 => x"fe49f2ef",
   357 => x"c487f6ca",
   358 => x"9d4d7086",
   359 => x"87c3c302",
   360 => x"bffaefc2",
   361 => x"fe496e4c",
   362 => x"ff87d5df",
   363 => x"c5c848d0",
   364 => x"7bd6c178",
   365 => x"7b154ac0",
   366 => x"e0c082c1",
   367 => x"f504aab7",
   368 => x"48d0ff87",
   369 => x"c5c878c4",
   370 => x"7bd3c178",
   371 => x"78c47bc1",
   372 => x"c1029c74",
   373 => x"dcc287fc",
   374 => x"c0c87ec2",
   375 => x"b7c08c4d",
   376 => x"87c603ac",
   377 => x"4da4c0c8",
   378 => x"e8c24cc0",
   379 => x"49bf97f3",
   380 => x"d20299d0",
   381 => x"c21ec087",
   382 => x"fe49f2ef",
   383 => x"c487eacc",
   384 => x"4a497086",
   385 => x"c287efc0",
   386 => x"c21ec2dc",
   387 => x"fe49f2ef",
   388 => x"c487d6cc",
   389 => x"4a497086",
   390 => x"c848d0ff",
   391 => x"d4c178c5",
   392 => x"bf976e7b",
   393 => x"c1486e7b",
   394 => x"c17e7080",
   395 => x"f0ff058d",
   396 => x"48d0ff87",
   397 => x"9a7278c4",
   398 => x"c087c505",
   399 => x"87e5c048",
   400 => x"efc21ec1",
   401 => x"c9fe49f2",
   402 => x"86c487fe",
   403 => x"fe059c74",
   404 => x"d0ff87c4",
   405 => x"78c5c848",
   406 => x"c07bd3c1",
   407 => x"c178c47b",
   408 => x"c087c248",
   409 => x"4d262648",
   410 => x"4b264c26",
   411 => x"5e0e4f26",
   412 => x"710e5c5b",
   413 => x"0266cc4b",
   414 => x"c04c87d8",
   415 => x"d8028cf0",
   416 => x"c14a7487",
   417 => x"87d1028a",
   418 => x"87cd028a",
   419 => x"87c9028a",
   420 => x"497387d7",
   421 => x"d087eafb",
   422 => x"c01e7487",
   423 => x"87e0f949",
   424 => x"49731e74",
   425 => x"c887d9f9",
   426 => x"87fcfe86",
   427 => x"dbc21e00",
   428 => x"c149bfd6",
   429 => x"dadbc2b9",
   430 => x"48d4ff59",
   431 => x"ff78ffc3",
   432 => x"e1c848d0",
   433 => x"48d4ff78",
   434 => x"31c478c1",
   435 => x"d0ff7871",
   436 => x"78e0c048",
   437 => x"00004f26",
   438 => x"00000000",
  others => ( x"00000000")
);

-- Xilinx Vivado attributes
attribute ram_style: string;
attribute ram_style of ram: signal is "block";

signal q_local : std_logic_vector((NB_COL * COL_WIDTH)-1 downto 0);

signal wea : std_logic_vector(NB_COL - 1 downto 0);

begin

	output:
	for i in 0 to NB_COL - 1 generate
		q((i + 1) * COL_WIDTH - 1 downto i * COL_WIDTH) <= q_local((i+1) * COL_WIDTH - 1 downto i * COL_WIDTH);
	end generate;
    
    -- Generate write enable signals
    -- The Block ram generator doesn't like it when the compare is done in the if statement it self.
    wea <= bytesel when we = '1' else (others => '0');

    process(clk)
    begin
        if rising_edge(clk) then
            q_local <= ram(to_integer(unsigned(addr)));
            for i in 0 to NB_COL - 1 loop
                if (wea(NB_COL-i-1) = '1') then
                    ram(to_integer(unsigned(addr)))((i + 1) * COL_WIDTH - 1 downto i * COL_WIDTH) <= d((i + 1) * COL_WIDTH - 1 downto i * COL_WIDTH);
                end if;
            end loop;
        end if;
    end process;

end arch;
