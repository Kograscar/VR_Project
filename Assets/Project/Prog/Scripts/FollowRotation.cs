using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class FollowRotation : MonoBehaviour {
    
    [SerializeField] Transform _objectToChange;
    [SerializeField] Transform _objectToFollow;

    private void Update()
    {
        _objectToChange.localRotation = _objectToFollow.localRotation;
    }
}
