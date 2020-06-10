using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace AnalizaProdaje.Common
{
    public class QueryStringBuilder
    {

        private List<QueryStrings> queryList;

        public QueryStringBuilder(List<QueryStrings> list)
        {
            queryList = list;
        }

        public QueryStringBuilder()
        { }

        public List<QueryStrings> QueryList { get { return queryList; } set { queryList = value; } }

        public string GenerateQueryString()
        {
            string returnString = "";

            foreach (QueryStrings item in QueryList)
            {
                returnString += item.Attribute + "=" + item.Value + "&";
            }

            return returnString.Remove(returnString.Length - 1, 1);
        }

        public string AddQueryItem(QueryStrings item)
        {
            if (QueryList == null || QueryList.Count == 0)
            {
                QueryList = new List<QueryStrings>();
            }

            QueryList.Add(item);

            return GenerateQueryString();
        }

        public void AddSingleQueryItem(QueryStrings item)
        {
            if (QueryList == null || QueryList.Count == 0)
            {
                QueryList = new List<QueryStrings>();
            }

            QueryList.Add(item);
        }

        public string AddQueryList(List<QueryStrings> queryList)
        {
            if (QueryList == null || QueryList.Count == 0)
            {
                QueryList = new List<QueryStrings>();
            }
            QueryList =  queryList;

            return GenerateQueryString();
        }
    }

    public class QueryStrings
    {
        private string attribute;
        private string _value;

        public string Attribute { get { return attribute; } set { attribute = value; } }
        public string Value { get { return _value; } set { _value = value; } }
    }
}