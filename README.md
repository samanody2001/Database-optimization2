# Project description
In this project I optimized a set of queries. For each query, I:
• Identified the attribute to create the index on in order to enhance the query’s performance
• Determined the most expedient type of index to be created
• Listed the execution/physical plan of each query along with the buffer and planing timings
# The following files are provided along with your project description:
## schema.sql contains the SQL commands that create the tables with the schema shown in the figure
## insert-data.sql contains the SQL commands that will load/insert rows in the tables created
## project2-queries.sql contains 19 queries to be optimized individually.
## create_commands: indexes used to optimize each query.
## pdf file that contains the following:
a) For each of the 18 queries, list which attribute you will create an index on and which index type
you will use along with justification
b) List the physical plan of each query along with the planing time. If you changed anything in the
config file for a query, then list the command concerning the query tuning used in the config file for
each query (expected 38 plans)
c) List the parts of the two plans (before and after the index) that had the highest cost, slowest
runtime, and largest number of rows for the physical plan presented in the output
d) Compare the physical plans before and after adding the index for every query
e) Provide a justification for the observed behavior


