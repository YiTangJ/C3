function [clones,false_positives] = queryClonePairs()
%QUERYCLONEPAIRS 此处显示有关此函数的摘要
%   此处显示详细说明

loadDatabase;
query="select function_id_one,function_id_two,functionality_id,syntactic_type,similarity_line,similarity_token from clones";
clones=select(dcon,query);

query="select function_id_one,function_id_two,functionality_id,syntactic_type,similarity_line,similarity_token from false_positives";
false_positives=select(dcon,query);

end

