using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class UserInformationManager : MonoBehaviour
{
    public Dictionary<string, int> itemCounts;

    string[] cats = { "onigiri", "shokupan", "soda", "chicken", "bottle", "snack" };

    // Start is called before the first frame update
    void Start()
    {
        DontDestroyOnLoad(this);
        itemCounts = new Dictionary<string, int>();
    }

    public void loadItemCounts()
    {
        itemCounts.Clear();

        foreach (string cat in cats) {
            itemCounts.Add(cat, 1);
        }
    }
}
